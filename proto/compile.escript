#!/usr/bin/env escript 
%% -*- erlang -*-
%%! -pa ../deps/protobuffs/ebin/

main(_) ->
  Opts = [{output_ebin_dir, "../ebin"}, {output_include_dir, "../include"}, {imports_dir, ["../src"]}, {output_src_dir, "../src"}],
  protobuffs_compile:generate_source("otmp_server.proto", Opts),
  protobuffs_compile:generate_source("otmp_client.proto", Opts),
  protobuffs_compile:generate_source("otmp_common.proto", Opts).
