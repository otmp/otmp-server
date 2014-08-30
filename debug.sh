#!/bin/bash
./rebar compile
erl -pa deps/*/ebin ebin -config otmpd
