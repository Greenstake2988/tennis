import marcador.{type Marcador}

pub type TipoDeJuego {
  Normal(CierreJuego)
  A7(CierreJuego)
  A10(CierreJuego)
}

pub type CierreJuego {
  SinVentajas
  ConVentajas
}

pub opaque type Juego {
  Juego(Marcador, TipoDeJuego)
}

pub fn nuevo(tipo_de_juego: TipoDeJuego) -> Juego {
  Juego(marcador.nuevo(tipo_de_juego), tipo_de_juego)
}
