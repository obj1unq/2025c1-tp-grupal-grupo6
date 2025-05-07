// src/objetos.wlk
import wollok.game.*
import posiciones.*
import timer.*

object alumno {
  var property position = game.at(3, 3)
  
  method image() = "alumno-Defrente.png"
  
  method mover(direccion) {
    position = direccion.siguiente(self.position())
  }

  method reducirTiempo(tiempo){

  }
}

object chancho{
  var property position = game.at(3, 0)
  var property multa = 20

  method image() = "chancho.png"

  method cobroMulta(personaje){
    personaje.reducirTiempo(multa)
    game.say(self, "Te cobre " + multa + " segundos de multa")
  }

  method aplicarEfecto(personaje){
    position = position.left(1)
    self.cobroMulta(personaje)
  }
}

object debi{
  var property position = game.at(3, 1)

  method image() = "debi.png"

  method hacerPregunta(personaje){
    game.say(self, "Que es el polimorfismo?")
  }

  method aplicarEfecto(personaje){
    self.hacerPregunta(personaje)
  }
}

object isaias{
  var property position = game.at(3,2)

  method image() = "isaias.png"

  method aplicarEfecto(personaje){
//    reloj.aumentarTiempo(30)
  }
}

object leo{
  var property position = game.at(3, 4)

  method image() = "leo.png"


  method aplicarEfecto(personaje){}
}