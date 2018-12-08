# restic

restic is a backup program that is fast, efficient and secure.

For detailed usage check out the [documentation](https://restic.readthedocs.io/en/latest).

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Start off with creating a repository for your backups:

```console
$ hab pkg install -b core/restic
$ restic init --repo /tmp/backup
enter password for new backend:
enter password again:
created restic backend 085b3c76b9 at /tmp/backup
Please note that knowledge of your password is required to access the repository.
Losing your password means that your data is irrecoverably lost.
```

and add some data:

```console
$ restic --repo /tmp/backup backup ~/work
enter password for repository:
scan [/home/user/work]
scanned 764 directories, 1816 files in 0:00
[0:29] 100.00%  54.732 MiB/s  1.582 GiB / 1.582 GiB  2580 / 2580 items  0 errors  ETA 0:00
duration: 0:29, 54.47MiB/s
snapshot 40dc1520 saved
```

Next you can either use `restic restore` to restore files or use `restic mount` to mount the repository via fuse and browse the files from previous snapshots.

For more options check out the [online documentation](https://restic.readthedocs.io/en/latest/).
