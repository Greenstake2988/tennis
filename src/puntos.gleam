pub opaque type Puntos {
  Puntos(Int)
}

pub fn crear(numero: Int) -> Result(Puntos, Nil) {
  case numero >= 0 {
    True -> Ok(Puntos(numero))
    False -> Error(Nil)
  }
}

pub fn valor(puntos: Puntos) -> Int {
  let Puntos(num) = puntos
  num
}

pub fn sumar(a: Puntos, b: Puntos) -> Puntos {
  Puntos(valor(a) + valor(b))
}

pub fn restar(a: Puntos, b: Puntos) -> Result(Puntos, Nil) {
  crear(valor(a) - valor(b))
}
