-module(otmpd_db).
-export([register_player/2, check_player_exists/1]).

register_player(SteamId, Nick) ->
  SessionId = uuid:get_v4(),
  sharded_eredis:q([ "HMSET", SessionId, 
                     "steam_id", SteamId, 
                     "username", Nick ]).
  
check_player_exists(SteamId) ->
  erlang:error(i_dont_exist_yet).
