-module(jugador).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/jugador.gleam").
-export([nuevo/1, sumar_puntos/2]).
-export_type([jugador/0]).

-type jugador() :: {jugador, binary(), integer()}.

-file("src/jugador.gleam", 18).
-spec nuevo(binary()) -> jugador().
nuevo(Nombre) ->
    {jugador, Nombre, 0}.

-file("src/jugador.gleam", 22).
-spec sumar_puntos(jugador(), integer()) -> jugador().
sumar_puntos(Jugador, Cantidad) ->
    {jugador, erlang:element(2, Jugador), erlang:element(3, Jugador) + Cantidad}.
