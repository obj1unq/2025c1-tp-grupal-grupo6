import wollok.game.*
import objetos.*
import posiciones.*
import timer.*
import nivel.*

class Historia {
  method position() = game.at(0, 0) 
  
  method image()
  
  method iniciar() {
    game.removeTickEvent("reloj")
    game.addVisual(self)
  }

  method ejecutar(){
    self.iniciar()
  }
}

object historiaActual {
  var property actual = inicio

  method continuar() {
    actual.ejecutar()
  }

  method iniciar() {
    actual.iniciar()
  }
}

object jugando {
  method ejecutar() {}
}

object inicio inherits Historia {
  var orden = 0
  
  override method image() {
    return "00" + (orden.toString()) + "-intro.png"
  }
  
  override method ejecutar() {
    self.cambiar()
  }

  
  method seguirMostrando() = orden < 9
  
  method cambiar() {
    if (self.seguirMostrando()) {
      orden += 1
    } else {
      historiaActual.actual(jugando)
      game.removeVisual(self)
      nivel1.configurar()
      nivel1.musicaDeFondo()
    }
  }
}

class Transicion inherits Historia {
  //const nivel 
  var property image

  override method iniciar() {
    super()
    game.schedule(5000, {self.ejecutar()})
  }

  override method  ejecutar(){
    game.removeVisual(self)
    //nivel.iniciar()
  }
}

class PantallaFinal inherits Historia {

  override method  ejecutar(){
    game.removeVisual(self)
  }
  

}


/* object fin inherits PantallaFinal {

  var orden = 0
  var finDeJuego = null // = finDeJuegoSinTiempo o finDeJuegoGano
  
  override method image() = "0" + orden.toString() + "-fin.png"
  
  method seguirMostrando() = orden < finDeJuego.limiteDeMuestra()
  
  method cambiar() {
    if (orden == 1) {
      orden = finDeJuego.ordenInicial()
    } else {
      if (self.seguirMostrando()) {
        orden += 1
      } else {
        fin.ejecutar()
      }
    }
  }
  
  method finDeJuego(final) {
    finDeJuego = final
  }
  
  override method ejecutar() {
    super()
    keyboard.c().onPressDo({ self.cambiar() })
  }
} 
 */

//se quedo sin tiempo
object finDeJuegoSinTiempo inherits Historia {
  override method image() = "00-fin.png"
  override method ejecutar() {
    super()
    keyboard.c().onPressDo({ fin.ejecutar() })
  }
} 

// no aprobo el parcial
object noAproboParcial inherits Historia {
  override method image() = "desaprobo.png"
  override method ejecutar() {
    super()
    keyboard.c().onPressDo({ fin.ejecutar() })
  }
} 

// aprobo el parcial
object ganoJuego inherits Historia {
  override method image() = "aprobo.png"
  override method ejecutar() {
    super()
    keyboard.c().onPressDo({ fin.ejecutar() })
  }
} 

//pantalla final, luego de haber ganado
object fin inherits Historia {
  override method image() = "final.png"
  override method ejecutar() {
    super()
    game.stop() //termina el juego
  }
}