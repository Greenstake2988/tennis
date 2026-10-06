-module(tennis).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/tennis.gleam").
-export([main/0]).

-file("src/tennis.gleam", 5).
-spec main() -> nil.
main() ->
    Oscar = jugador:nuevo(<<"Oscar"/utf8>>),
    gleam_stdlib:println(
        <<"El nombre del jugador es "/utf8, (erlang:element(2, Oscar))/binary>>
    ),
    gleam_stdlib:println(
        <<<<"y tiene: "/utf8,
                (erlang:integer_to_binary(erlang:element(3, Oscar)))/binary>>/binary,
            "pts."/utf8>>
    ).
