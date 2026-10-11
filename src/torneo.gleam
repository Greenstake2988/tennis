import jugador
import marcador.{type Regla}
import partido.{type Partido}

pub opaque type Torneo {
  Torneo(partidos: List(Partido), tipo: Regla, jugadores: List(jugador.Jugador))
}

pub fn crear() {
  todo
}
