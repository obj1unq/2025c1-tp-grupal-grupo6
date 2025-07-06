import nivel.*
import wollok.game.*
import posiciones.*
import timer.*

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

class Profesor inherits Visual {
  var property position
  var property image
  var property text = ""
  const preguntasYRespuestasCorrectas = [
    self.nuevaPreguntaYSuRespuestaCorrecta(
      "Decimos que dos objetos que comparten cierta interfaz en común, son _ para ese observador",
      ["1-iguales", "2-polimórficos", "3-equivalentes"],
      1
    ),
    self.nuevaPreguntaYSuRespuestaCorrecta(
      "Cual es el equipo que más veces ganó la Copa Libertadores?",
      ["1-Boca", "2-Racing", "3-Independiente"],
      2
    ),
    self.nuevaPreguntaYSuRespuestaCorrecta(
      "En qué año se estrenó la película Matrix?",
      ["1-1999", "2-2000", "3-2002"],
      0
    ),
    self.nuevaPreguntaYSuRespuestaCorrecta(
      "Si tenemos dos referencias _, están apuntando al mismo objeto",
      ["1-gemelas", "2-idénticas", "3-iguales"],
      1
    ),
    self.nuevaPreguntaYSuRespuestaCorrecta(
      "El conjunto de referencias que tiene un objeto representa su _",
      ["1-Coleccion", "2-Estado", "3-Interfaz"],
      1
    ),
    self.nuevaPreguntaYSuRespuestaCorrecta(
      "Dos referencias son idénticas si apuntan al mismo objeto",
      ["1-Verdadero", "2-Falso", "3-Pasapalabra"],
      0
    ),
    self.nuevaPreguntaYSuRespuestaCorrecta(
      "Cual es el nombre de la considerada, primera programadora informatica?",
      ["1-Joan Clarke", "2-Kathleen Booth", "3-Ada Lovelace"],
      2
    ),
    self.nuevaPreguntaYSuRespuestaCorrecta(
      "Dentro de un metodo, cuando no podemos usar self (ya que entrariamos en un loop), que debemos usar?",
      ["1-inherits", "2-super", "3-override"],
      1
    ),
    self.nuevaPreguntaYSuRespuestaCorrecta(
      "A qué se conoce en la industria como “Code Smells?",
      [
        "1-cometarios dentro del código que utilizan lenguaje informal.",
        "2-errores de compilación, que impiden que el código se ejecute correctamente",
        "3-indicios de problemas profundos en el diseño, aunque no impiden que el programa funcione."
      ],
      2
    )
  ]
  
  method nuevaPreguntaYSuRespuestaCorrecta(
    pregunta,
    respuestas,
    correcta
  ) = new PreguntaYRespuesta(
    pregunta = pregunta,
    respuestas = respuestas,
    correcta = correcta,
    profesor = self
  )
  
  override method aplicarEfecto(alumno) {
    seleccion.seleccionar(preguntasYRespuestasCorrectas.anyOne())
  }
}

object leo inherits Profesor (position = game.at(7, 13), image = "88.png") {
  
}

object debi inherits Profesor (position = game.at(5, 13), image = "22.png") {
  
}

object isa inherits Profesor (position = game.at(10, 13), image = "55.png") {
  
}

class PreguntaYRespuesta {
  const property pregunta
  const property respuestas
  const property correcta
  const property profesor
  
  method preguntar() {
    var texto = " 1: " + respuestas.get(0)
    texto = (texto + " 2: ") + respuestas.get(1)
    texto = (texto + " 3: ") + respuestas.get(2)
    
    
    texto = pregunta + texto
    game.say(profesor, texto)
    profesor.text(texto)
  }
  
  method responder(opcion) {
    if (correcta == opcion) game.say(profesor, "Muy bien!")
    else game.say(profesor, "reprobado!")
  }
}

object alumno {
  //marcos
  var property position = game.at(8, 4)
  // Para que no quede encima de la imagen estacion
  var direccion = abajo
  var property puedeMover = true
  
  method image() = "alumno-" + direccion.nombre() + ".png"
  
  method mover(nuevaDireccion) {
    direccion = nuevaDireccion
    const destino = direccion.siguiente(self.position())
    
    if (nivelManager.nivelActual().puedeMover(self, destino)) {
      position = destino
    }
    if (self.llegoAlFinalDelNivel()) {
      nivelManager.avanzarNivel()
      position = nivelManager.nivelActual().posicionInicial()
    }
  }
  
  method llegoAlFinalDelNivel() = nivelManager.nivelActual().excepcionesPositivas().contains(
    self.position()
  )
}