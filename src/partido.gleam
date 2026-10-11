import gleam/option.{type Option, Some}
import jugador.{type Jugador}
import marcador.{type Marcador}

pub type Partido {
  Partido(
    jugador_a: Jugador,
    jugador_b: Jugador,
    marcador: Marcador,
    ganador: Option(Jugador),
  )
}

pub fn registrar_resultado(
  partido: Partido,
  a: Int,
  b: Int,
) -> Result(Partido, Nil) {
  case marcador.registrar_marcador(partido.marcador, a, b) {
    Ok(m) -> Partido(..partido, marcador: m) |> registrar_ganador |> Ok
    Error(_) -> Error(Nil)
  }
}

fn registrar_ganador(partido: Partido) -> Partido {
  case marcador.gana_a(partido.marcador) {
    True -> Partido(..partido, ganador: Some(partido.jugador_a))
    False -> Partido(..partido, ganador: Some(partido.jugador_b))
  }
}
