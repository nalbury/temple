package main

import (
	"fmt"
	"os"
	"strings"
	"text/template"

	"github.com/urfave/cli/v2"
)

func main() {
	var (
		file    string
		verbose bool
		args    map[string]string = make(map[string]string)
	)

	app := &cli.App{
		Name:      "temple",
		Usage:     "Template files with arbitrary key value pairs",
		UsageText: "temple --file ./myfile.tpl key=val foo=bar",
		//ExitErrHandler: func(c *cli.Context, err error) {
		//	if err == nil {
		//		return
		//	}
		//	fmt.Println(err)
		//	os.Exit(1)
		//},
		Action: func(c *cli.Context) error {
			if c.NArg() > 0 {
				for _, arg := range c.Args().Slice() {
					kv := strings.Split(arg, "=")
					if len(kv) != 2 {
						return fmt.Errorf("Couldn't parse arg: %s as a key value pair! Exiting", arg)
					}
					args[kv[0]] = kv[1]
				}
			}
			if verbose {
				fmt.Fprintf(os.Stderr, "Templating %s\n", file)
				fmt.Fprintf(os.Stderr, "Args: %v\n", args)
				fmt.Fprintf(os.Stderr, "Output:\n")
			}
			t, err := template.ParseFiles(file)
			if err != nil {
				return err
			}
			if err := t.Execute(os.Stdout, args); err != nil {
				return fmt.Errorf("Error executing template, %v", err)
			}
			return nil
		},
		Flags: []cli.Flag{
			&cli.PathFlag{
				Name:        "file",
				Value:       "",
				Usage:       "File to template",
				Destination: &file,
				Required:    true,
			},
			&cli.BoolFlag{
				Name:        "verbose",
				Aliases:     []string{"v"},
				Value:       false,
				Usage:       "Print file name and map of args to stderr (stdout is preserved)",
				Destination: &verbose,
			},
		},
	}

	err := app.Run(os.Args)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
