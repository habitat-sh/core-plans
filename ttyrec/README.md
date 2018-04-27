# ttyrec

ttyrec is a tty recorder. Recorded data can be played back with the included ttyplay command. ttyrec is just a derivative of script command for recording timing information with microsecond accuracy as well. It can record emacs -nw, vi, lynx, or any programs running on tty.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

```
$ hab pkg install core/ttyrec
$ hab pkg binlink core/ttyrec
$ ttyrec -help
usage: ttyrec [-u] [-e command] [-a] [file]
```
