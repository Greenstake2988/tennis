import jugador
import gleam/io
import gleam/int

pub fn main() {
  let oscar = jugador.nuevo("Oscar")
  io.println("El nombre del jugador es " <> oscar.nombre)
  io.println("y tiene: " <> int.to_string(oscar.puntos) <> " pts.")
}
