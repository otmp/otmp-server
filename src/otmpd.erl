-module(otmpd).
-export([handle_msg/4]).

handle_msg(Socket, Host, Port, Bin) ->
  io:format("Recv from ~p:~p@~p, ~p~n", [Host, Port, Socket, Bin]),
  gen_udp:send(Socket, Host, Port, Bin).
