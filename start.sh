#!/bin/bash
./rebar compile
erl -noshell -pa deps/*/ebin ebin -s main start -config otmpd
