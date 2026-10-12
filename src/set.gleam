import juego.{type Juego}

pub opaque  type Set {
  Set(set: List(Juego), cierre: CierreSet, cuantos: CuantosSet)
}

pub type CierreSet {
  PrimeroA
  TieBreakA7
  TieBreakA10
}

pub type CuantosSet {
  Uno
  MejorDe3
  MejorDe5
}

pub fn crear(cuantos: CuantosSet, cierre: CierreSet) -> Set {
  Set([], cierre:, cuantos:)
}
