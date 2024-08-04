#!/bin/bash
# wrapper script for jenkins cli command
#
# java -jar jenkins-cli.jar -s http://192.168.50.206:8080/ help 
# TODO: add error checking, usage message, etc.
java -jar jenkins-cli.jar -s http://"${1}":8080/ "${2}"
