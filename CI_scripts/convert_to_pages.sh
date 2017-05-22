#!/bin/bash

mkdir -p docs

## Function to add YAML Front matter to
## each file. The front matter needs to
## contain layout, title, permalink (globally unique)
## and sidebar information. The sidebar information
## gives the location of the sidebar that is supposed
## to be displayed on the page.
function annotate_file(){
	name=$1
	file=$2
	title=$3
	sidebar=$4
	echo "---"
	echo "layout: page"
	echo "title: $title"
	echo "permalink: /$name"
	[ -z $sidebar ] || echo "sidebarloc: $sidebar"
	echo "---"
	echo ""
	cat $file
}

# Copy template, and CSS files
(cd content; find . -type f | cpio -pud ../docs)

# Copy template, and CSS files
find images -type f | cpio -pud docs

# Separate on newlines instead of on spaces. See "man 1 bash"
# for more info about using IFS
IFS=$'\n'

## Process the wiki directory. This is the a git submodule
## pointing to github.com:StackIQ/wiki sub directory

for i in `find wiki -type f`; do
	# Get filename
	fname=$(basename $i)
	# Get directory name, and strip out wiki
	d=$(dirname $i)
	leaddir=${d#wiki}
	# Get name of file without extension
	name=${fname%.md}
	# Generate a title
	title=$(echo $name | tr '-' ' ')

	# Create a directory structure matching
	# wiki's directory structure
	mkdir -p "docs/$leaddir"

	# If we're processing Markdown files 
	if [ ${fname##*.} == "md" ]; then
		echo "Processing $i"
		case $fname in 
			# If it's a sidebar file, create a sidebar html file
			# in the includes directory. Make sure to match the
			# leaddir structure. Otherwise we cannot find the
			# location when processing other markdown files
			_Sidebar.md)
			mkdir -p "docs/_includes/$leaddir"
			kramdown "$i" > "docs/_includes/$leaddir/_Sidebar.html"
			;;
			*)
			# All other markdown files will get simple
			# YAML front matter. If there's a sidebar file
			# in the same directory, as the markdown file
			# make sure to create a pointer to it
			[ -f $d/_Sidebar.md ] && sidebar="$leaddir" || sidebar=""
			annotate_file $name $i "${title}" "${sidebar}" > "docs/$leaddir/$fname"
		esac
	# All other files (images, etc) are copied over
	else
		echo "Copying $i to docs/$leaddir/$fname"
		cp "${i}" "docs/$leaddir/$fname"
	fi
done

# Github pages requires an index file. Our main index file in Home.md
# Copy this over, but filter out the permalink.
sed '/permalink: \/Home/d' docs/Home.md > docs/index.md

