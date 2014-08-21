-ifndef(PING_PB_H).
-define(PING_PB_H, true).
-record(ping, {
    id = erlang:error({required, id}),
    sessionid = erlang:error({required, sessionid})
}).
-endif.

-ifndef(PONG_PB_H).
-define(PONG_PB_H, true).
-record(pong, {
    id = erlang:error({required, id}),
    sessionid = erlang:error({required, sessionid})
}).
-endif.

