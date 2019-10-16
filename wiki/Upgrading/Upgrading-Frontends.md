## Upgrading your frontend - it's still a reinstall

There's some new commands that have been added to make upgrading a frontend slightly less painful,
though it still requires a reinstall of the frontend.

These commands should be available with stacki 5.2 and on. If you're on an older stacki than this,
then this feature is not available.

## Take a dump

The command to get the current data out of your stacki frontend is `stack dump`.

This command will dump out the contents of the stacki database as a json document. Pipe this to
a file and squirrel it away somewhere before nuking your frontend.

Note that this **will not** save:

* The current state of boot state for your node (os vs install)

## Install your new frontend

Follow the [installation instructions](Frontend-Installation) to get your new frontend online.

## Load your dump

The command to load the dump.json data into your new frontend is `stack load`.

However, this isn't completely magical. You still need to manually add all of your pallets
and carts to the new frontend. You can find the original path the pallets came from in the
"pallets" section at the top level of the dump.json.

Once that is done, you can load the dump file using `stack load /path/to/your/dump.json`.
This will output all of the stack commands that are going to be run to load your cluster info
so that you can inspect it to ensure it is doing what you expect.

Once you've determined you're happy with the commands that will be run, either pipe the output of
`stack load` to a file, through bash, or pass the `exec=True` parameter to run the commands. The
`exec=True` method will be much faster than piping through bash, but will not show any output.

You will need to run `stack sync config && stack sync host boot` after `stack load` to sync the
loaded configuration.

**Note:** some commands output by load are expected to fail, as the new frontend might have that information
already in its database. To see these errors it is recommended to pipe the output of `stack load` through bash,
as using the `exec=True` flag will suppress the error output.
