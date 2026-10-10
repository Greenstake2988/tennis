import puntos.{type Puntos}

pub type Jugador {
  Jugador(nombre: String, puntos: Puntos)
}

pub fn nuevo(nombre: String) -> Jugador {
  Jugador(nombre:, puntos: puntos.cero())
}

pub fn sumar_puntos(jugador: Jugador, puntos: Puntos) -> Jugador {
  Jugador(..jugador, puntos: puntos.sumar(jugador.puntos, puntos))
}
