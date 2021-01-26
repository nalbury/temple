# temple
Template files on the command line

## Usage

```
➜  ~ temple --help
NAME:
   temple - Template files with arbitrary key value pairs

USAGE:
   temple --file ./myfile.tpl key=val foo=bar

COMMANDS:
   help, h  Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --file value   File to template (default: "/dev/stdin")
   --verbose, -v  Print file name and map of args to stderr (stdout is preserved) (default: false)
   --help, -h     show help (default: false)
```

An example template can be found in [`./test.tpl`](https://github.com/nalbury/temple/blob/main/test.tpl).

To template this file, you can run:

```
➜  ~ temple --file ./test.tpl test=val foo=bar
This is a test val
When you get foo you also get bar
```

Replace the values of `test` and `foo` to get different results:

```
➜  ~ temple --file ./test.tpl test=value foo=BAR
This is a test value
When you get foo you also get BAR
```
