# R

R is a free software environment for statistical computing and graphics.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

```
[0][default:/src:0]# hab pkg install -b core/R
[1][default:/src:0]# R --help
Usage: R [options] [< infile] [> outfile]
   or: R CMD command [arguments]
Start R, a system for statistical computation and graphics, with the
specified options, or invoke an R tool via the 'R CMD' interface.
Options:
  -h, --help            Print short help message and exit
  --version             Print version info and exit
  --encoding=ENC        Specify encoding to be used for stdin
  --encoding ENC
  RHOME                 Print path to R home directory and exit
  --save                Do save workspace at the end of the session
  --no-save             Don't save it
  --no-environ          Don't read the site and user environment files
  --no-site-file        Don't read the site-wide Rprofile
  --no-init-file        Don't read the user R profile
  --restore             Do restore previously saved objects at startup
  --no-restore-data     Don't restore previously saved objects
  --no-restore-history  Don't restore the R history file
  --no-restore          Don't restore anything
  --vanilla             Combine --no-save, --no-restore, --no-site-file,
                        --no-init-file and --no-environ
  --no-readline         Don't use readline for command-line editing
  --max-ppsize=N        Set max size of protect stack to N
  --min-nsize=N         Set min number of fixed size obj's ("cons cells") to N
  --min-vsize=N         Set vector heap minimum to N bytes; '4M' = 4 MegaB
  -q, --quiet           Don't print startup message
  --silent              Same as --quiet
  --slave               Make R run as quietly as possible
  --interactive         Force an interactive session
  --verbose             Print more information about progress
  -d, --debugger=NAME   Run R through debugger NAME
  --debugger-args=ARGS  Pass ARGS as arguments to the debugger
  -g TYPE, --gui=TYPE   Use TYPE as GUI; possible values are 'X11' (default)
                        and 'Tk'.
  --arch=NAME           Specify a sub-architecture
  --args                Skip the rest of the command line
  -f FILE, --file=FILE  Take input from 'FILE'
  -e EXPR               Execute 'EXPR' and exit
FILE may contain spaces but not shell metacharacters.
Commands:
  BATCH                 Run R in batch mode
  COMPILE               Compile files for use with R
  SHLIB                 Build shared library for dynamic loading
  INSTALL               Install add-on packages
  REMOVE                Remove add-on packages
  build                 Build add-on packages
  check                 Check add-on packages
  LINK                  Front-end for creating executable programs
  Rprof                 Post-process R profiling files
  Rdconv                Convert Rd format to various other formats
  Rd2pdf                Convert Rd format to PDF
  Rd2txt                Convert Rd format to pretty text
  Stangle               Extract S/R code from Sweave documentation
  Sweave                Process Sweave documentation
  Rdiff                 Diff R output ignoring headers etc
  config                Obtain configuration information about R
  javareconf            Update the Java configuration variables
  rtags                 Create Emacs-style tag files from C, R, and Rd files
Please use 'R CMD command --help' to obtain further information about
the usage of 'command'.
Options --arch, --no-environ, --no-init-file, --no-site-file and --vanilla
can be placed between R and CMD, to apply to R processes run by 'command'
Report bugs at <https://bugs.R-project.org>.
[2][default:/src:0]#
```
