# postfix habitat service

A habitat plan for building and running postfix as a supervised service

## Logging

Postfix is hardcoded to use syslog via `/dev/log`, which is not available by default in studio or container environments.

`busybox-static` contains `syslogd` which can provide a minimal logging interface that writes to `/var/log/messages`. Start it within a studio before starting postfix with `hab pkg exec core/busybox-static syslogd -n &`

## Testing

To test with the default configuration, ensure that `localhost.localdomain` is an additional name for your `localhost` entry in your host machine's `/etc/hosts`

### Start in studio

1. Run `build` at least once to have at least one build available under `./results/`, re-run as needed
1. Run `script/server` to start syslogd, configure postfix service, and (re)load the postfix service
1. Tail `/var/log/messages` for postfix log output

### Write test emails directly into queue

1. Open socket connection from outside of studio:

    `nc localhost 25`

   - Or, from inside studio:

       `hab pkg install core/netcat && hab pkg exec core/netcat nc localhost 25`
1. Start SMTP session:

    `ehlo localhost.localdomain`

1. Set sender:

    `mail from: tester@example.com`

1. Set recipient:

    `rcpt to: root@localhost`

1. Set message:

    ```smtp
    data
    Subject: Hello world!

    This is the body of my email.

    Have a good day.

    .

    ```

    *Message is terminated by <kbd>[enter]</kbd><kbd>.</kbd><kbd>[enter]</kbd>*

1. Close SMTP session:

    `quit`

1. Read the mailbox from within the studio:

    `less /hab/svc/postfix/data/spool/root`

## References

- http://www.postfix.org/INSTALL.html
- http://www.postfix.org/DB_README.html
- http://www.postfix.org/BASIC_CONFIGURATION_README.html
- http://www.postfix.org/postconf.5.html
- http://www.postfix.org/VIRTUAL_README.html
- https://github.com/alezzandro/postfix-docker
- http://www.postfix.org/master.8.html
- https://mediatemple.net/community/products/dv/204404584/sending-or-viewing-emails-using-telnet
