-ifndef(CONNECTRESP_PB_H).
-define(CONNECTRESP_PB_H, true).
-record(connectresp, {
    success = erlang:error({required, success}),
    sessionid
}).
-endif.

-ifndef(FORCEDISCONNECT_PB_H).
-define(FORCEDISCONNECT_PB_H, true).
-record(forcedisconnect, {
    sessionid = erlang:error({required, sessionid}),
    msg
}).
-endif.

-ifndef(SERVEREGRESSCHATMSG_PB_H).
-define(SERVEREGRESSCHATMSG_PB_H, true).
-record(serveregresschatmsg, {
    username = erlang:error({required, username}),
    msg = erlang:error({required, msg})
}).
-endif.

