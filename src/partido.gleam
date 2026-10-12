import juego.{type Juego,type TipoDeJuego}
import jugador.{type Jugador}
import set.{type Set}
pub type TipoDePartido {
  EsDuelo
  EsPartido
}

pub opaque type Partido {
  Partido(
    jugador_a: Jugador,
    jugador_b: Jugador,
    sets: List(Set),
    tipo: TipoDePartido,
  )
}

// pub type CierreSet {
//   PrimeroA
//   TieBreakA7
//   TieBreakA10
// }

// pub type Set {
//   Set(set: List(Juego), cierre: CierreSet)
// }

// pub type CuantosSet {
//   Uno
//   MejorDe3
//   MejorDe5
// }

pub type Formato {
  Duelo(TipoDeJuego)
  ASets(TipoDeSet)
}

pub type TipoDeSet {
  SetA4Games(CuantosSet)
  SetNormal(CuantosSet)
}

pub fn nuevo(
  jugador_a: Jugador,
  jugador_b: Jugador,
  tipo: TipoDeSet,
) -> Result(Partido, Nil) {
  case !jugador.iguales(jugador_a, jugador_b) {
    True ->
      case tipo {
        SetA4Games(Uno) -> {
          let assert Ok(un_juego) =
            juego.nuevo(jugador_a, jugador_b, juego.ConVentajas, juego.Normal)
          Ok(Partido(jugador_a, jugador_b, [Set([un_juego], TieBreakA7)], tipo))
        }
        SetA4Games(MejorDe3) -> {
          let assert Ok(un_juego) =
            juego.nuevo(jugador_a, jugador_b, juego.ConVentajas, juego.Normal)
          Ok(Partido(jugador_a, jugador_b, [Set([un_juego], TieBreakA7)], tipo))
        }
        SetA4Games(MejorDe5) -> {
          let assert Ok(un_juego) =
            juego.nuevo(jugador_a, jugador_b, juego.ConVentajas, juego.Normal)
          Ok(Partido(jugador_a, jugador_b, [Set([un_juego], TieBreakA7)], tipo))
        }
        SetNormal(Uno) -> {
          let assert Ok(un_juego) =
            juego.nuevo(jugador_a, jugador_b, juego.ConVentajas, juego.Normal)
          Ok(Partido(jugador_a, jugador_b, [Set([un_juego], TieBreakA7)], tipo))
        }
        SetNormal(MejorDe3) -> {
          let assert Ok(un_juego) =
            juego.nuevo(jugador_a, jugador_b, juego.ConVentajas, juego.Normal)
          Ok(Partido(jugador_a, jugador_b, [Set([un_juego], TieBreakA7)], tipo))
        }
        SetNormal(MejorDe5) -> {
          let assert Ok(un_juego) =
            juego.nuevo(jugador_a, jugador_b, juego.ConVentajas, juego.Normal)
          Ok(Partido(jugador_a, jugador_b, [Set([un_juego], TieBreakA7)], tipo))
        }
      }
    False -> Error(Nil)
  }
}

pub fn jugador_a(partido: Partido) -> Jugador {
  partido.jugador_a
}

pub fn jugador_b(partido: Partido) -> Jugador {
  partido.jugador_b
}

pub fn marcador(partido: Partido) -> Marcador {
  partido.marcador
}

pub fn registrar_resultado(
  partido: Partido,
  a: Int,
  b: Int,
) -> Result(Partido, marcador.ErrorMarcador) {
  case marcador.registrar_marcador(partido.marcador, a, b) {
    Ok(m) -> Ok(Partido(..partido, marcador: m))
    Error(e) -> Error(e)
  }
}

pub fn ganador(partido: Partido) -> Result(Jugador, Nil) {
  case marcador.gana_a(partido.marcador) {
    Ok(True) -> Ok(partido.jugador_a)
    Ok(False) -> Ok(partido.jugador_b)
    Error(_) -> Error(Nil)
  }
}
