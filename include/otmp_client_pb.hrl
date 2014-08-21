-ifndef(CONNECT_PB_H).
-define(CONNECT_PB_H, true).
-record(connect, {
    username = erlang:error({required, username}),
    password = erlang:error({required, password})
}).
-endif.

-ifndef(DISCONNECT_PB_H).
-define(DISCONNECT_PB_H, true).
-record(disconnect, {
    sessionid = erlang:error({required, sessionid})
}).
-endif.

-ifndef(CLIENTEGRESSCHATMSG_PB_H).
-define(CLIENTEGRESSCHATMSG_PB_H, true).
-record(clientegresschatmsg, {
    sessionid = erlang:error({required, sessionid}),
    msg = erlang:error({required, msg})
}).
-endif.

