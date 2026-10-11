import gleam/list
import jugador.{type Jugador}
import marcador.{type Regla}
import partido.{type Partido}

pub type ErrorTorneo {
  NumeroImpar
  JugadoresRepetidos
}

pub opaque type Torneo {
  Torneo(tipo: Regla, partidos: List(Partido), jugadores: List(Jugador))
}

pub fn nuevo(tipo: Regla) -> Torneo {
  Torneo(tipo, [], [])
}

/// Esta funcion puede fallar si el jugador ya esta dentro de la lista.
/// No pueden haber jugadores repetidos
pub fn agregar_jugador(
  torneo: Torneo,
  jugador: Jugador,
) -> Result(Torneo, Nil) {
  case
    !list.any(torneo.jugadores, fn(existente) {
      jugador.iguales(existente, jugador)
    })
  {
    True -> Ok(Torneo(..torneo, jugadores: [jugador, ..torneo.jugadores]))
    False -> Error(Nil)
  }
}

/// El numero de jugadores tiene que ser par de lo contrario falla.
pub fn armar_partidos(torneo: Torneo) -> Result(Torneo, Nil) {
  case list.length(torneo.jugadores) % 2 == 0 {
    True -> Ok(torneo)
    False -> Error(Nil)
  }
}
