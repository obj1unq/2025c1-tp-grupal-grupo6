import wollok.game.*
import posiciones.*
import timer.*

class Profesor {
  var property position 
  var property image

  method hacerPregunta(personaje){
        game.say(self, "Que es el polimorfismo?")

  /* method efecto() {
    game.onCollideDo(alumno, {self.aplicarEfecto()})
  }

  method aplicarEfecto() {} */

}
}

object alumno { //marcos
  var property position = game.at(3, 3)
  
  method image() = "alumno-Defrente.png"
  
  method mover(direccion) {
    position = direccion.siguiente(self.position())
  }

  method reducirTiempo(tiempo){

  }
}


const debi = new Profesor (position = game.at(3,1), image = "debi.png")

const isaias = new Profesor (position = game.at(3,2 ), image = "isaias.png" )

const leo = new Profesor (position = game.at(3, 3), image = "leo.png" )


/* object debi{
  var property position = game.at(3, 1)

  method image() = "debi.png"

  method hacerPregunta(){
    game.onCollideDo(alumno, {self.aplicarEfecto()})
  }

  method aplicarEfecto(){}
} */
/* 
object isaias{
  var property position = game.at(3,2)

  method image() = "isaias.png"

  method hacerPregunta(){
    game.whenCollideDo(alumno, {self.aplicarEfecto()})
  }

  method aplicarEfecto(){
    reloj.aumentarTiempo(30)
  }
}
 */
/* object leo{
  var property position = game.at(3, 4)

  method image() = "leo.png"

  method hacerPregunta(){
    game.onCollideDo(alumno, {self.aplicarEfecto()})
  }

  method aplicarEfecto(){}
}
 */

/* object chancho{
  var property position = game.at(3, 0)

  method image() = "chancho.png"

  method cobroMulta(){
    game.onCollideDo(alumno, {self.aplicarEfecto()})
  }

  method aplicarEfecto(){}
} */