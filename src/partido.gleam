// class Partido
//   private_class_method :new
//   attr_reader :jugador1, :jugador2, :ganador, :puntos_en_juego, :tipo_de_partido
//
//   TIPOS_DE_PARTIDOS = %i[muerte_a_10 muerte_a_7 a_4_games].freeze
//
//   NOMBRES_DE_TIPOS = {
//     muerte_a_10: "muerte súbita a 100",
//     muerte_a_7: "muerte súbita a 7",
//     a_4_games: "a 4 games"
//   }.freeze
//
//   def initialize(jugador1, jugador2, puntos_en_juego, tipo_de_partido)
//     raise ArgumentError, "tipo de partido inválido: #{tipo_de_partido}" unless TIPOS_DE_PARTIDOS.include?(tipo_de_partido)
//
//     @jugador1 = jugador1
//     @jugador2 = jugador2
//     @puntos_en_juego =  puntos_en_juego
//     @tipo_de_partido = tipo_de_partido
//     @ganador = nil
//   end
//
//   def registrar_ganador(jugador)
//     @ganador = jugador
//     perdedor = (jugador == @jugador1) ? @jugador2 : @jugador1
//
//     jugador.sumar_puntos(@puntos_en_juego)
//
//     "Terminó #{@jugador1.nombre} vs #{@jugador2.nombre} jugaron #{NOMBRES_DE_TIPOS[@tipo_de_partido]}. " \
//     "Ganador: #{jugador.nombre} (+#{@puntos_en_juego}), ahora tiene #{jugador.puntos}. "
//
//   end
//
//   def to_s
//     "#{jugador1.nombre} vs #{jugador2.nombre}"
//   end
// end

import jugador.{type Jugador}
import gleam/option.{type Option, None, Some}


pub type TipoDePartido{
  MuerteA10
  MuerteA7
  A4Games
}

pub type Partido{
  Partido(jugador_a: Jugador, jugador_b: Jugador, tipo_de_partido: TipoDePartido, ganador: Option(Jugador) )
}

pub fn registrar_ganador(partido: Partido, ganador: Jugador, ) -> Partido {
  Partido (
    ..partido,
    ganador: Some(ganador)
  )
}
