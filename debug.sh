#!/bin/bash
./rebar compile
erl -pa deps/*/ebin ebin -s main start
