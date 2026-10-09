// src/marcador.gleam
import gleam/int

pub type CierrePuntos {
  SinVentajas
  ConVentajas
}

pub type CierreSet {
  PrimeroA
  ConTiebreak
}

pub type VarianteMuerte {
  A7
  A10
}

pub type VariantePuntos {
  Normal
}

pub type VarianteSet {
  SetNormal
  SetA4
}

pub type Regla {
  Muerte(VarianteMuerte, CierrePuntos)
  Juego(VariantePuntos, CierrePuntos)
  Set(VarianteSet, CierreSet)
}

fn minimo(regla: Regla) -> Int {
  case regla {
    Juego(Normal, _) -> 4
    Muerte(A7, _) -> 7
    Muerte(A10, _) -> 10
    Set(SetNormal, _) -> 6
    Set(SetA4, _) -> 4
  }
}

pub fn valido(regla: Regla, a: Int, b: Int) -> Bool {
  let ganador = int.max(a, b)
  let perdedor = int.min(a, b)
  let min = minimo(regla)

  case perdedor < 0 {
    True -> False
    False ->
      case regla {
        Set(_, cierre) -> set_valido(ganador, perdedor, min, cierre)
        Juego(_, cierre) | Muerte(_, cierre) ->
          juego_valido(ganador, perdedor, min, cierre)
      }
  }
}

fn juego_valido(
  ganador: Int,
  perdedor: Int,
  min: Int,
  cierre: CierrePuntos,
) -> Bool {
  case ganador < min, cierre {
    True, _ -> False
    False, ConVentajas ->
      case ganador == min {
        True -> perdedor <= min - 2
        False -> ganador - perdedor == 2
      }
    False, SinVentajas -> ganador == min && perdedor < min
  }
}

fn set_valido(
  ganador: Int,
  perdedor: Int,
  min: Int,
  cierre: CierreSet,
) -> Bool {
  case ganador < min, cierre {
    True, _ -> False
    False, PrimeroA -> ganador == min && perdedor < min
    False, ConTiebreak ->
      case ganador == min {
        True -> perdedor <= min - 2
        False -> ganador == min + 1 && perdedor >= min - 1
      }
  }
}
