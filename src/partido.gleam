import jugador.{type Jugador}
import marcador.{type Marcador}

pub opaque type Partido {
  Partido(jugador_a: Jugador, jugador_b: Jugador, marcador: Marcador)
}

pub fn nuevo(
  jugador_a: Jugador,
  jugador_b: Jugador,
  marcador: Marcador,
) -> Result(Partido, Nil) {
  case jugador.iguales(jugador_a, jugador_b) {
    False -> Ok(Partido(jugador_a:, jugador_b:, marcador:))
    True -> Error(Nil)
  }
}

pub fn jugador_a(partido: Partido) -> Jugador {
  partido.jugador_a
}

pub fn jugador_b(partido: Partido) -> Jugador {
  partido.jugador_b
}

pub fn marcador(partido: Partido) -> Marcador {
  partido.marcador
}

pub fn registrar_resultado(
  partido: Partido,
  a: Int,
  b: Int,
) -> Result(Partido, marcador.ErrorMarcador) {
  case marcador.registrar_marcador(partido.marcador, a, b) {
    Ok(m) -> Ok(Partido(..partido, marcador: m))
    Error(e) -> Error(e)
  }
}

pub fn ganador(partido: Partido) -> Result(Jugador, Nil) {
  case marcador.gana_a(partido.marcador) {
    Ok(True) -> Ok(partido.jugador_a)
    Ok(False) -> Ok(partido.jugador_b)
    Error(_) -> Error(Nil)
  }
}
