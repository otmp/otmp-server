#!/bin/bash
pushd src
erl -make
erl -noshell -s main start
popd
