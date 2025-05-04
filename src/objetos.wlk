import wollok.game.*
import posiciones.*
import timer.*

object alumno {
  var property position = game.at(3, 1)
  
  method image() = "alumno-Defrente.png"
  
  method mover(direccion) {
    position = direccion.siguiente(self.position())
  }

  method reducirTiempo(tiempo){

  }
}

object chancho{
  method image() = "chancho.png"

  method cobroMulta(){
    game.onCollideDo(alumno, {self.aplicarEfecto()})
  }

  method aplicarEfecto(){}
}

object debi{
  method image() = "debi.png"

  method hacerPregunta(){
    game.onCollideDo(alumno, {self.aplicarEfecto()})
  }

  method aplicarEfecto(){}
}

object isaias{
  var property position = game.at(game.height(), 5)

  method image() = "isaias.png"

  method hacerPregunta(){
    game.onCollideDo(alumno, {self.aplicarEfecto()})
  }

  method aplicarEfecto(){
    reloj.aumentarTiempo(30)
  }
}

object leo{
  method image() = "leo.png"

  method hacerPregunta(){
    game.onCollideDo(alumno, {self.aplicarEfecto()})
  }

  method aplicarEfecto(){}
}