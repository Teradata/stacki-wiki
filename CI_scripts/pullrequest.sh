# Just check for clean merge
git remote remove origin
git remote add origin https://github.com/StackIQ/stacki-wiki.git
git remote add upstream https://github.com/StackIQ/stacki.wiki.git
git fetch origin
git fetch upstream
git merge upstream/master --no-edit
