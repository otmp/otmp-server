-module(main).
-import(otmpd, [handleMsg/1]).
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
            io:format("Recv from ~p:~p@~p -> ~p~n",[Host, Port, Socket, Bin]),
            otmpd:handle_msg(Bin),
            gen_udp:send(Socket, Host, Port, Bin),
            loop(Socket)
    end.
