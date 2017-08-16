# README #

### CGI HTTP PROXY Flibusta for example ###

* Version 16.02.25

### How do I get set up? ###

* Install required software: `apt-get install nginx libfcgi-perl wget`
* Copy nph-flibuxta.pl to /var/www/proxy/*
* Add proxy.conf to /etc/nginx/sites-available and enable it
`chmod +x /usr/bin/fastcgi-wrapper.pl`
`chmod +x /etc/init.d/perl-fcgi`
`update-rc.d perl-fcgi defaults`
`insserv perl-fcgi`
`/etc/init.d/nginx start`
`/etc/init.d/perl-fcgi start`

### Who do I talk to? ###

* Repo owner CyberManiac