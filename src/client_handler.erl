-module(client_handler).
-export([handler/0]).

handler() ->
  receive
    {udp, Socket, Host, Port, Bin} ->
      spawn(fun() -> handle(meta, Bin, {Socket, Host, Port}) end),
      handler()
  end.

handle(meta, Bin, Hostdata) ->
  { _, MsgName, Payload } = otmp_meta_proto:decode_msg(Bin, meta),
  handle(MsgName, Payload, Hostdata);

handle(client_egress_chat_msg, Bin, _Hostdata) ->
  P = otmp_client_proto:decode_msg(Bin, client_egress_chat_msg),
  io:format("Recv ~p -> ~p~n", [client_egress_chat_msg, P]),
  erlang:error(connect_failed);

handle(connect, Bin, _Hostdata) ->
  P = otmp_client_proto:decode_msg(Bin, connect),
  io:format("Recv ~p -> ~p~n", [connect, P]),
  erlang:error(connect_failed);

handle(disconnect, Bin, _Hostdata) ->
  P = otmp_client_proto:decode_msg(Bin, disconnect),
  io:format("Recv ~p -> ~p~n", [disconnect, P]),
  erlang:error(connect_failed);

handle(pong, Bin, _Hostdata) ->
  P = otmp_client_proto:decode_msg(Bin, pong),
  io:format("Recv ~p -> ~p~n", [pong, P]),
  erlang:error(connect_failed);

handle(_MsgType, _Bin, _Hostdata) ->
  erlang:error(stop_sending_me_garbage).
