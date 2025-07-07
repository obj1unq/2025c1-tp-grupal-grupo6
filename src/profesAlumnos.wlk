import nivel.*
import wollok.game.*
import posiciones.*
import timer.*
import historiaJuego.*

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

class Estudiante inherits Visual {

  var property position 
  var property image

  override method atravesable() { 
        return false
  }

  method mensaje(){
    game.say(self,self.texto())
  }

  method texto()
}

object maxi inherits Estudiante (position = game.at(1, 4), image = "maxi.png") {
  override method atravesable() = true
  override method texto(){
    return "suerte!!"
  }
}

object yami inherits Estudiante (position = game.at(12, 9), image = "yamii.png" ) {
  override method atravesable() = true
  override method texto(){
    return "exitos!!"
  }
}

object maria inherits Estudiante (position = game.at(10, 3), image = "maria.png" ) {
  override method atravesable() = true
  override method texto(){
    return "dale!!"
  }
}


class Profesor inherits Visual {
  var property position
  var property image
  var property text = ""

  const preguntasYRespuestasCorrectas = [ self.nuevaPreguntaYSuRespuestaCorrecta("Dentro de un metodo, cuando no podemos usar self (ya que entrariamos en un loop), que debemos usar?", ["1-inherits", "2-super", "3-override"], 1, "preguntaLeo1.png"),
                                          self.nuevaPreguntaYSuRespuestaCorrecta("Cual es el equipo que más veces ganó la Copa Libertadores?", ["1-Boca", "2-Racing", "3-Independiente"], 2, "preguntaLeo2-.png"),
                                          self.nuevaPreguntaYSuRespuestaCorrecta("Decimos que dos objetos que comparten ciertos mensajes en común, son _ para ese observador", ["1-iguales", "2-polimórficos", "3-equivalentes"], 1 , "preguntaLeo3.png"),
                                          self.nuevaPreguntaYSuRespuestaCorrecta("El conjunto de referencias que tiene un objeto representa su _", ["1-Coleccion", "2-Estado", "3-Interfaz"], 1, "preguntaIsa1.png"),
                                          self.nuevaPreguntaYSuRespuestaCorrecta("A qué se conoce en la industria como “Code Smells?", ["1-cometarios dentro del código que utilizan lenguaje informal.", "2-errores de compilación, que impiden que el código se ejecute correctamente", "3-indicios de problemas profundos en el diseño, aunque no impiden que el programa funcione."], 2, "preguntaIsa2.png"),
                                          self.nuevaPreguntaYSuRespuestaCorrecta("En qué año se estrenó la película Matrix?", ["1-1999", "2-2000", "3-2002"], 0, "preguntaIsa3.png"),
                                          self.nuevaPreguntaYSuRespuestaCorrecta("Para aplicar una accion a todos los elementos de una coleccion, se debe utilizar", ["1-foreach(closure)", "2-all(predicate)", "3-foreEach(closure)"], 2, "preguntaDebi1.png"),
                                          self.nuevaPreguntaYSuRespuestaCorrecta("Cual es el nombre de la considerada, primera programadora informatica?", ["1-Joan Clarke", "2-Kathleen Booth", "3-Ada Lovelace"], 2, "preguntaDebi2.png"),
                                          self.nuevaPreguntaYSuRespuestaCorrecta("Si tenemos dos referencias _, están apuntando al mismo objeto", ["1-gemelas", "2-idénticas", "3-iguales"], 1, "preguntaDebi3.png")]
                                         
    
  method nuevaPreguntaYSuRespuestaCorrecta(pregunta, respuestas, correcta, imagen){
    return new PreguntaYRespuesta(pregunta = pregunta, respuestas = respuestas, correcta=correcta, profesor=self, imagen = imagen)
  }

  method mensaje(){
    var contadorRespuestas = 0
    const preguntas = preguntasYRespuestasCorrectas
    self.selectorRespuesta()
    game.onTick(10000,"preguntados",{
      contadorRespuestas += 1
      const pregunta = self.preguntaAleatoria(preguntas)
      seleccion.seleccionar(pregunta)
      preguntas.remove(pregunta)
      if(contadorRespuestas >= 9){
        self.validarAprobado()
      }
    })
  }

  method selectorRespuesta(){
    keyboard.num1().onPressDo({seleccion.respuesta(0)})
    keyboard.num2().onPressDo({seleccion.respuesta(1)})
    keyboard.num3().onPressDo({seleccion.respuesta(2)})
  }

  method preguntaAleatoria(coleccion){
    if(coleccion.isEmpty()){
        game.removeTickEvent("preguntados")
      }else{
        return coleccion.anyOne()
      }
  }

  method validarAprobado(){
    if(nota.contador() >= 6){
      game.schedule(6000, {
        self.escena(ganoJuego)
      })
    }else{
      game.schedule(6000, {
        self.escena(noAproboParcial)
      })
    }
    self.escena(fin)
  }

  method escena(escena){
    historiaActual.actual(escena)
    historiaActual.continuar()
  }
}

object leo inherits Profesor (position = game.at(7, 14), image = "leoVersionFinal.png" ) {}

object debi inherits Profesor (position = game.at(5, 14), image = "debiVersionFinal.png" ) {}

object isa inherits Profesor (position = game.at(10, 14), image = "isaVersionFinal.png" ){}


class PreguntaYRespuesta {
  const property pregunta
  const property respuestas
  const property correcta
  const property profesor
  const property imagen

  method position() = game.at(0, 0) 
  
  method preguntar() {
    game.addVisual(self)
  }

  method image(){
    return imagen
  }

  method responder(opcion) {
    if (correcta == opcion){
      nota.contador().incrementar()
    }
  }
}

object nota {
  var property contador = 0

  method incrementar(){
    contador += 1
  }
}

object alumno { //marcos

  var property position = game.at(8, 4)  // Para que no quede encima de la imagen estacion
  var direccion = abajo

  method image() = "alumno-" + direccion.nombre() + ".png"

  method mover(nuevaDireccion) {
    direccion = nuevaDireccion
    const destino = direccion.siguiente(self.position())

    if (self.puedeMoverA(destino)) {
      self.avanzarA(destino)
    }
  }

  method puedeMoverA(destino) {
    return nivelManager.nivelActual().puedeMover(self, destino)
  }

  method avanzarA(destino) {
    position = destino

    if (self.llegoAlFinalDelNivel()) {
      self.cambiarDeNivel()
    }
  }

  method llegoAlFinalDelNivel() {
    return nivelManager.nivelActual().excepcionesMeta().contains(self.position())
  }

  method cambiarDeNivel() {
    nivelManager.avanzarNivel()
    position = nivelManager.nivelActual().posicionInicial()
  }
}
