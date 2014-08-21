#!/bin/bash
pushd src
erl -make
erl -noshell -pa deps/*/ebin ebin -s main start
popd
