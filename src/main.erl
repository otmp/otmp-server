-module(main).
-export([start/0]).

start() ->
    io:format("-- otmpd v0.0.1 starting -- ~n"),
    spawn(fun() -> server(10502) end),
    register(handler, spawn(client_handler, handler, [])).

server(Port) ->
    {ok, Socket} = gen_udp:open(Port, [binary, {active, false}]),
    io:format("Listening on port ~p, otp socket ~p~n",[Port, Socket]),
    loop(Socket).

loop(Socket) ->
    inet:setopts(Socket, [{active, once}]),
    receive
        {udp, Socket, Host, Port, Bin} ->
            handler ! {udp, Socket, Host, Port, Bin},
            loop(Socket)
    end.
