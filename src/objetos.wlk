// src/objetos.wlk
import wollok.game.*
import posiciones.*
import timer.*
import tablero2.*

object seleccion {

  var property pregunta = null
  method seleccionar(_pregunta) {
    pregunta = _pregunta
    pregunta.preguntar()
  }

  method respuesta(indice) {
    pregunta.responder(indice)
  }
}
class Profesor {
  var property position 
  var property image
  var property text = ""
  const preguntasYRespuestasCorrectas = [self.nuevaPreguntaYSuRespuestaCorrecta("¿Qué es el polimorfismo?", ["blablabla", "blablabla", "correcta"], 2 ),
                                         self.nuevaPreguntaYSuRespuestaCorrecta("otraPregunta2", ["correcta", "otraRespuesta2", "otraRespuesta2"], 0),
                                         self.nuevaPreguntaYSuRespuestaCorrecta("otraPregunta3", ["otraRespuesta2", "correcta", "otraRespuesta2"], 1)]
    
  method nuevaPreguntaYSuRespuestaCorrecta(pregunta, respuestas, correcta){
    return new PreguntaYRespuesta(pregunta = pregunta, respuestas = respuestas, correcta=correcta, profesor=self)
  }


  //Esto parece viejo, revisar
  method efecto(alumno) {
    game.onCollideDo(alumno, {self.aplicarEfecto(alumno)})
  }

  method aplicarEfecto(alumno){
    seleccion.seleccionar(preguntasYRespuestasCorrectas.anyOne())
  }


}
class PreguntaYRespuesta{
  const property pregunta
  const property respuestas 
  const property correcta
  const property profesor

  method preguntar() {
      var texto = " 1: " + respuestas.get(0)
      texto = texto + " 2: " + respuestas.get(1)
      texto = texto + " 3: " + respuestas.get(2)


      texto = pregunta + texto
      game.say(profesor, texto )
      profesor.text(texto)
  }

  method responder(opcion) {
    if (correcta == opcion) {
      game.say(profesor, "Muy bien!")
    }
    else {
      game.say(profesor, "reprobado!")
    }
  }  

}

object alumno { //marcos

  var property position = game.at(8, 4)  // Para que no quede encima de la imagen estacion
  var direccion = abajo
 
  method image() = "alumno-" + direccion.nombre() + ".png"
  
  method mover(nuevaDireccion) {
    direccion = nuevaDireccion
    const destino = direccion.siguiente(self.position())

    if (nivel.puedeMover(self, destino)) {
      position = destino
    } else { 
      self.reducirTiempo(10)
    }
  }

  method reducirTiempo(tiempo){

  }
}

/* object chancho{
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
} */

const debi = new Profesor (position = game.at(3,1), image = "debi.png")

const isaias = new Profesor (position = game.at(3,2 ), image = "isaias.png" )

const leo = new Profesor (position = game.at(3, 3), image = "leo.png" )


  



/* object debi{
  var property position = game.at(3, 1)

  method image() = "debi.png"

  method hacerPregunta(personaje){
    pregunqta = new Pregunta(texto="Que es el polimorfismo?", opciones = [Respusta(texto = "repsuesta correcta)", "no se", "esto es filosofia?"], 0)
    seleccion.seleccionar(pregunta)
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



