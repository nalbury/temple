{{ repeat 18 "#" }}
Welcome to {{ .app | title }}!

{{ .app | title }} is designed to template text with simple string key/{{ .key }} pairs.
For example in this file we have three template variables defined:
- app
- flag
- key

We tell {{ .app }} the path to our filename with the {{ .flag }} flag:

{{ .app }} {{ .flag }} ./example.tpl

If you omit the {{ .flag }} flag, {{ .app }} will read from stdin:

cat ./example.tpl | {{ .app }}

To actually set the values of the template variables, we need to pass each each one as an argument like this:

{{ .app }} {{ .flag }} ./example.tpl app={{ .app }} flag={{ .flag }} key={{ .key }}

Or using stdin

cat ./example.tpl | {{ .app }} app={{ .app }}

Each key/{{ .key }} pair must be separated with an "=".

{{ repeat 18 "#" }}
Templating tips and tricks

{{ .app | title }} also includes the sprig library (https://http://masterminds.github.io/sprig), which extends the standard go templating library significantly.

# String examples using our "key" variable (all variables in {{ .app }} are strings)

## Titles
key: {{ .key | title }}

## Quotes
key: {{ .key | quote }}

## Indents
key:
{{ .key | indent 2 }}

## Truncate
key: {{ .key | trunc 3 }}

# Other cool functions

## Date/Time
Timestamp: {{ now | unixEpoch }}

## Default Values
key: {{ .notkey | default "defaultvalue" }}

## DNS Lookups
localhostIP: {{ getHostByName "localhost" }}

## SHA256 Sum
sha256: {{ .key | sha256sum }}

## Convert a string to a list and iterate over it
{{- range $i, $c := (.key |splitList "") }}
char_{{ $i }}: {{ $c }}
{{- end }}
