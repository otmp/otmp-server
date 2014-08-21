#!/bin/sh
pushd src
erl -make
erl -noshell -s main start
popd
