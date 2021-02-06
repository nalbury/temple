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

## Examples

An example template can be found in [`./example.tpl`](https://github.com/nalbury/temple/blob/main/example.tpl).

To template this file, you can run:

```
➜  ~ temple --file ./example.tpl app=temple flag=--file key=value
##################
Welcome to Temple!

Temple is designed to template text with simple string key/value pairs.
For example in this file we have three template variables defined:
- app
- flag
- key

We tell temple the path to our filename with the --file flag:

temple --file ./example.tpl

If you omit the --file flag, temple will read from stdin:

cat ./example.tpl | temple

To actually set the values of the template variables, we need to pass each each one as an argument like this:

temple --file ./example.tpl app=temple flag=--file key=value

Or using stdin

cat ./example.tpl | temple app=temple

Each key/value pair must be separated with an "=".

##################
Templating tips and tricks

Temple also includes the sprig library (https://http://masterminds.github.io/sprig), which extends the standard go templating library significantly.

# String examples using our "key" variable (all variables in temple are strings)

## Titles
key: Value

## Quotes
key: "value"

## Indents
key:
  value

## Truncate
key: val

# Other cool functions

## Date/Time
Timestamp: 1612634261

## Default Values
key: defaultvalue

## DNS Lookups
localhostIP: 127.0.0.1

## SHA256 Sum
sha256: cd42404d52ad55ccfa9aca4adc828aa5800ad9d385a0671fbcbf724118320619

## Convert a string to a list and iterate over it
char_0: v
char_1: a
char_2: l
char_3: u
char_4: e
```

This README.md is also generated with temple :-)
