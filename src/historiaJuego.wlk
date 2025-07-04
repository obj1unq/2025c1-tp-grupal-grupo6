
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
    const image = (orden.toString()) + "-intro.png"
    return image
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
      
    }
  }
}

class Transicion inherits Historia {
  var nivel 
  var property image

  override method iniciar() {
    super()
    game.schedule(5000, {self.ejecutar()})
  }

  override method  ejecutar(){
    game.removeVisual(self)
    nivel.iniciar()
  }
}



object pantallaFinal inherits Historia {

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
  override method image() = "01-fin.png"
  override method ejecutar() {
    super()
    keyboard.c().onPressDo({ fin.ejecutar() })
  }
} 

// aprobo el parcial

object ganoJuego inherits Historia {
  override method image() = "02-fin.png"
  override method ejecutar() {
    super()
    keyboard.c().onPressDo({ fin.ejecutar() })
  }
} 

//pantalla final, independientemente del resultado
object fin inherits Historia {
  override method image() = "final.png"
  override method ejecutar() {
    super()
    game.stop()
  }
}