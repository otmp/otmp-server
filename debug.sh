#!/bin/bash
pushd src
erl -make
erl -s main start
popd
