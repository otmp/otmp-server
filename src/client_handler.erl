-module(client_handler).
-export([handler/0]).

handler() ->
  receive
    {udp, Socket, Host, Port, Bin} ->
      spawn(fun() -> handle(meta, Bin, Socket, Host, Port) end),
      handler()
  end.

handle(meta, Bin, Socket, Host, Port) ->
  { _Func, MsgName, Payload } = otmp_meta_proto:decode_msg(Bin, meta),
  handle(MsgName, Payload, Socket, Host, Port);

handle(client_egress_chat_msg, Bin, Socket, Host, Port) ->
  P = otmp_client_proto:decode_msg(Bin, client_egress_chat_msg),
  io:format("Recv ~p -> ~p~n", [client_egress_chat_msg, P]),
  erlang:error(connect_failed);

handle(connect, Bin, Socket, Host, Port) ->
  Payload   = otmp_client_proto:decode_msg(Bin, connect),
  io:format("Recv ~p -> ~p~n", [connect, Payload]),
  StatusMsg = otmp_server_proto:encode_msg({conn_status,
                                            connected,
                                            "d34db33f",
                                            "Welcome to OTMPd!"}),
  MetaPacket = otmp_meta_proto:encode_msg({meta, conn_status, StatusMsg}),
  io:format("Xmit ~p -> ~p~n", [connect, MetaPacket]),
  gen_udp:send(Socket, Host, Port, MetaPacket);

handle(disconnect, Bin, Socket, Host, Port) ->
  P = otmp_client_proto:decode_msg(Bin, disconnect),
  io:format("Recv ~p -> ~p~n", [disconnect, P]),
  erlang:error(connect_failed);

handle(pong, Bin, Socket, Host, Port) ->
  P = otmp_client_proto:decode_msg(Bin, pong),
  io:format("Recv ~p -> ~p~n", [pong, P]),
  erlang:error(connect_failed);

handle(_MsgType, _Bin, _Socket, _Host, _Port) ->
  erlang:error(stop_sending_me_garbage).
