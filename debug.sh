#!/bin/sh
pushd src
erl -make
erl -s main start
popd
