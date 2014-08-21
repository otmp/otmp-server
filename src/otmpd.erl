-module(otmpd).
-export([handle_msg/4]).

handle_msg(Socket, Host, Port, Bin) ->
  io:format("Recv from ~p:~p@~p, ~p~n", [Host, Port, Socket, Bin]),
  %M = otmp_common:encode_msg({'Meta', "Connect", <<"1","2","3">>}).                            
  { _, MsgName, Payload } = otmp_common_proto:decode_msg(Bin, 'Meta'),
  case MsgName of
    "Connect"    -> handle_connect(Payload);
    "Disconnect" -> handle_disconnect(Payload)
  end.

handle_disconnect(Payload) ->
  P = otmp_client_proto:decode_msg(Payload, 'Disconnect'),
  io:format("Recv DISCONNECT -> ~p", [P]).

handle_connect(Payload) ->
  P = otmp_client_proto:decode_msg(Payload, 'Connect'),
  io:format("Recv CONNECT -> ~p", [P]).
