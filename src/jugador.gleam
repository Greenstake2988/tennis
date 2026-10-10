import puntos.{type Puntos}

pub type Jugador {
  Jugador(nombre: String, puntos: Puntos)
}

pub fn nuevo(nombre: String) -> Jugador {
  let assert Ok(puntos_iniciales) = puntos.crear(0)
  Jugador(nombre:, puntos: puntos_iniciales)
}

pub fn sumar_puntos(jugador: Jugador, cantidad: Int) -> Result(Jugador, Nil) {
  case puntos.crear(cantidad) {
    Ok(nuevos_puntos) ->
      Ok(
        Jugador(..jugador, puntos: puntos.sumar(jugador.puntos, nuevos_puntos)),
      )
    Error(_) -> Error(Nil)
  }
}
