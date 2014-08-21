-module(otmpd).
-export([handler/0]).

handler() ->
  receive
    {udp, Socket, Host, Port, Bin} ->
      { _, MsgName, Payload } = otmp_meta_proto:decode_msg(Bin, meta),
      spawn(fun() -> handle(MsgName, Payload, {Socket, Host, Port}) end),
      handler()
  end.

handle(connect, Payload, _Hostdata) ->
  P = otmp_client_proto:decode_msg(Payload, connect),
  io:format("Recv CONNECT -> ~p~n", [P]);

handle(disconnect, Payload, _Hostdata) ->
  P = otmp_client_proto:decode_msg(Payload, disconnect),
  io:format("Recv DISCONNECT -> ~p~n", [P]).

