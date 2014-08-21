-module(main).
-import(otmpd, [handle_msg/4]).
-export([start/0]).

start() ->
    spawn(fun() -> server(10502) end).

server(Port) ->
    {ok, Socket} = gen_udp:open(Port, [binary, {active, false}]),
    io:format("Listen -> ~p~n",[Socket]),
    loop(Socket).

loop(Socket) ->
    inet:setopts(Socket, [{active, once}]),
    receive
        {udp, Socket, Host, Port, Bin} ->
            handle_msg(Socket, Host, Port, Bin),
            loop(Socket)
    end.
