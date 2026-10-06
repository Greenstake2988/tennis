// class Jugador
//   attr_reader :nombre, :puntos
//
//   def initialize(nombre)
//     @nombre = nombre
//     @puntos = 0
//   end
//
//   def sumar_puntos(puntos)
//     @puntos += puntos
//   end
// end

pub type Jugador {
  Jugador(nombre: String, puntos: Int)
}

pub fn nuevo(nombre: String) -> Jugador {
  Jugador(nombre:, puntos: 0)
}

pub fn sumar_puntos(jugador: Jugador, cantidad: Int) -> Jugador {
  Jugador(..jugador, puntos: jugador.puntos + cantidad)
}
