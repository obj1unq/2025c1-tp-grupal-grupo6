import wollok.game.*
import posiciones.*

object alumno {
  var property position = game.at(3, 1)
  
  method image() = "alumno-Defrente.png"
  
  method mover(direccion) {
    position = direccion.siguiente(self.position())
  }
}