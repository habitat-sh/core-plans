# jarvus/postfix habitat service

A habitat plan for building and running postfix as a supervised service

## Development / Testing

### Using studio

[`.studiorc`](./.studiorc) provides an environment and several commands for testing and development, see output when studio launches for usage.

To test with the default configuration, ensure that `localhost.localdomain` is an additional name for your `localhost` entry in your host machine's `/etc/hosts`

### Writing test emails directly into queue

1. Open SMTP socket connection from inside of studio:

    `postfix-email`
1. Start SMTP session:

    `EHLO localhost.localdomain`

1. Set sender:

    `MAIL FROM: <tester@example.com>`

1. Set recipient:

    `RCPT TO: <root@localhost>`

1. Set message:

    ```smtp
    DATA
    Subject: Hello world!

    This is the body of my email.

    Have a good day.

    .

    ```

    *Message is terminated by <kbd>[enter]</kbd><kbd>.</kbd><kbd>[enter]</kbd>*

1. Close SMTP session:

    `QUIT`

1. Read the mailbox from within the studio:

    `less /hab/svc/postfix/data/spool/root`

## Sample configurations

### Receive incoming mail to a virtual destination

These options illustrate delivering incoming mail to a script, with some parameters passed as arguments and the mail body piped into STDIN:

```
command_time_limit = "3600s"

[virtual]
transport = "myreceivescript"
mailbox_domains = "pcre:/opt/myreceivescript/domains"

[[services]]
name = "myreceivescript"
destination_recipient_limit = 1
type = "unix"
private = true
unpriv = false
chroot = false
command = """
pipe user=www-data argv=php
  -q
  /opt/myreceivescript/mail.php
  ${domain}
  ${mailbox}
  ${sender}
  ${queue_id}
"""
```

### Delivery to internet via secure relay

These options illustrate delivering outgoing mail via an authenticated relay (like mailgun):

```
relayhost = "[smtp.mailgun.org]:2525"

[smtp.sasl]
password_maps = "static:postmaster@example.org:MYPASSWORD"
```
