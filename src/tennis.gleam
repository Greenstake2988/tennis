import gleam/int
import gleam/io
import jugador
import puntos

pub fn main() {
  let oscar = jugador.nuevo("Oscar")
  io.println("El nombre del jugador es " <> oscar.nombre)
  io.println(
    "y tiene: " <> int.to_string(puntos.valor(oscar.puntos)) <> " pts.",
  )
}
