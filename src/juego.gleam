import gleam/int

pub opaque type Juego {
  Juego(tipo: TipoDeJuego, cierre: CierreJuego, marcador: Marcador)
}

type Marcador {
  Marcador(a: Int, b: Int)
}

pub type TipoDeJuego {
  Normal
  A7
  A10
}

pub type CierreJuego {
  SinVentajas
  ConVentajas
}

pub type ErrorMarcador {
  YaRegistrado
  MarcadorInvalido
}

pub fn nuevo(cierre: CierreJuego, tipo_de_juego: TipoDeJuego) -> Juego {
  Juego(tipo_de_juego, cierre, marcador_nuevo())
}

pub fn registrar_marcador(
  juego: Juego,
  a: Int,
  b: Int,
) -> Result(Juego, ErrorMarcador) {
  case es_nuevo(juego.marcador) {
    True ->
      case marcador_valido(juego.tipo, juego.cierre, a, b) {
        True -> Ok(Juego(..juego, marcador: Marcador(a, b)))
        False -> Error(MarcadorInvalido)
      }
    False -> Error(YaRegistrado)
  }
}

pub fn gana_a(juego: Juego) -> Result(Bool, Nil) {
  case juego.marcador.a, juego.marcador.b {
    0, 0 -> Error(Nil)
    a, b -> Ok(a > b)

  }
}

fn marcador_nuevo() -> Marcador {
  Marcador(0, 0)
}

fn marcador_valido(
  tipo_de_juego: TipoDeJuego,
  cierre: CierreJuego,
  a: Int,
  b: Int,
) -> Bool {
  let ganador = int.max(a, b)
  let perdedor = int.min(a, b)
  let min = minimo(tipo_de_juego)

  case perdedor < 0 {
    True -> False
    False ->
      case cierre {
        ConVentajas -> con_ventajas_valido(ganador, perdedor, min)
        SinVentajas -> sin_ventajas_valido(ganador, perdedor, min)
      }
  }
}

// Hay que llegar al mínimo y ganar por 2.
// Si el ganador pasó el mínimo, el juego se alargó y la diferencia es exactamente 2.
fn con_ventajas_valido(ganador: Int, perdedor: Int, min: Int) -> Bool {
  case ganador == min {
    True -> ganador - perdedor >= 2
    False -> ganador > min && ganador - perdedor == 2
  }
}

// Sin ventaja: el juego termina exactamente al llegar al mínimo.
fn sin_ventajas_valido(ganador: Int, perdedor: Int, min: Int) -> Bool {
  ganador == min && perdedor < min
}

fn minimo(tipo_de_juego: TipoDeJuego) -> Int {
  case tipo_de_juego {
    Normal -> 4
    A7 -> 7
    A10 -> 10
  }
}

fn es_nuevo(marcador: Marcador) -> Bool {
  marcador.a == 0 && marcador.b == 0
}
