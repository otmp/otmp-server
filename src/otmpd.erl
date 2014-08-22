-module(otmpd).
-export([handler/0]).

handler() ->
  receive
    {udp, Socket, Host, Port, Bin} ->
      { _, MsgName, Payload } = otmp_meta_proto:decode_msg(Bin, meta),
      spawn(fun() -> handle(MsgName, Payload, {Socket, Host, Port}) end),
      handler()
  end.

handle(MsgType, Payload, _Hostdata) ->
  P = otmp_client_proto:decode_msg(Payload, MsgType),
  io:format("Recv ~p -> ~p~n", [MsgType, P]).
