-module(jugador).
-compile([no_auto_import, nowarn_ignored, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-export([nuevo/1, sumar_puntos/2, iguales/2]).
-export_type([jugador/0]).

-type jugador() :: {jugador, binary(), puntos:puntos()}.

-file("src/jugador.gleam", 7).
-spec nuevo(binary()) -> jugador().
nuevo(Nombre) ->
    {jugador, Nombre, puntos:cero()}.

-file("src/jugador.gleam", 11).
-spec sumar_puntos(jugador(), puntos:puntos()) -> jugador().
sumar_puntos(Jugador, Puntos) ->
    {jugador, erlang:element(2, Jugador), puntos:sumar(erlang:element(3, Jugador), Puntos)}.

-file("src/jugador.gleam", 15).
-spec iguales(jugador(), jugador()) -> boolean().
iguales(Jugador_a, Jugador_b) ->
    erlang:element(2, Jugador_a) =:= erlang:element(2, Jugador_b).

