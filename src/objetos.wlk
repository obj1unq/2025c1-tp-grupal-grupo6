// src/objetos.wlk
import wollok.game.*
import posiciones.*
import timer.*

class Profesor {
  var property position 
  var property image
  const preguntasYRespuestasCorrectas = [self.nuevaPreguntaYSuRespuestaCorrecta("¿Qué es el polimorfismo?", "blablabla"),
                                         self.nuevaPreguntaYSuRespuestaCorrecta("otraPregunta2", "otraRespuesta2"),
                                         self.nuevaPreguntaYSuRespuestaCorrecta("otraPregunta3", "otraRespuesta3")]

  var preguntaAleatoria = "" //preguntasYRespuestasCorrectas.anyOne().pregunta()
      
  method nuevaPreguntaYSuRespuestaCorrecta(pregunta, respuesta){
    return new PreguntaYRespuesta(pregunta = pregunta, respuesta = respuesta)
  }



  method text(){
    return preguntaAleatoria
  }

   method efecto(alumno) {
    game.onCollideDo(alumno, {self.aplicarEfecto(alumno)})
  }

  method aplicarEfecto(alumno){
    preguntaAleatoria = preguntasYRespuestasCorrectas.anyOne().pregunta()
  }


}
class PreguntaYRespuesta{
  const pregunta
  const respuesta
  
  method pregunta(){
    return pregunta
  }

  method respuesta(){
    return respuesta
  }
}

object alumno { //marcos
  var property position = game.at(3, 3)
  var direccion = abajo
  
 /*  method image() = "alumno-frente.png" */
 
  method image() = "alumno-" + direccion.nombre() + ".png"
  
  method mover(nuevaDireccion) {
    direccion = nuevaDireccion
    position = direccion.siguiente(self.position())

  }

  method reducirTiempo(tiempo){

  }
}


object chancho{
  var property position = game.at(3, 0)
  var property multa = 20

  method cobroMulta(personaje){
    personaje.reducirTiempo(multa)
    game.say(self, "Te cobre " + multa + " segundos de multa")
  }

  method aplicarEfecto(personaje){
    position = position.left(1)
    self.cobroMulta(personaje)
  }
}

const debi = new Profesor (position = game.at(3,1), image = "debi.png")

const isaias = new Profesor (position = game.at(3,2 ), image = "isaias.png" )

const leo = new Profesor (position = game.at(3, 3), image = "leo.png" )


  



/* object debi{
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
 */
/* object leo{
  var property position = game.at(3, 4)

  method image() = "leo.png"



  method aplicarEfecto(){}
}
 */



