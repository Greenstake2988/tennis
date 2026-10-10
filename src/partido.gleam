import gleam/option.{type Option, Some}
import jugador.{type Jugador}

pub type TipoDePartido {
  MuerteA10
  MuerteA7
  A4Games
}

pub type Partido {
  Partido(
    jugador_a: Jugador,
    jugador_b: Jugador,
    tipo_de_partido: TipoDePartido,
    ganador: Option(Jugador),
  )
}

pub fn registrar_ganador(partido: Partido, ganador: Jugador) -> Partido {
  Partido(..partido, ganador: Some(ganador))
}
