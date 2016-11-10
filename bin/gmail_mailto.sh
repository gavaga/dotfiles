#!/bin/sh

google-chrome-stable https://mail.google.com/mail?view=cm&tf=0&to=`echo $1 | sed 's/mailto://'`
