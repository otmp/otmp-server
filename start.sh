#!/bin/sh
erlc *.erl
erl -noshell -s main start
