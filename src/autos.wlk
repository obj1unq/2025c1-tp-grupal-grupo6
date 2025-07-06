import nivel.*
import wollok.game.*

class Automovil inherits Visual {
  var property position
  const direccion
  const tipo
  
  method image() = "auto" + tipo.caracteristica() + direccion.nombre() + ".png"
  
  method mover() {
    direccion.mover(self)
  }
  
  override method aplicarEfecto(personaje) {
    tipo.aplicarEfecto(personaje)
  }
}

class DireccionAuto {
  method nombre()
  
  method condicion(auto)
  
  method mover(auto) {
    if (self.condicion(auto)) game.removeVisual(auto)
  }
}

object derechaAuto inherits DireccionAuto {
  override method nombre() = "Derecha"
  
  override method mover(auto) {
    super(auto)
    auto.position(auto.position().right(1))
  }
  
  override method condicion(auto) = auto.position().x() >= (game.width() - 1)
}

object izquierdaAuto inherits DireccionAuto {
  override method nombre() = "Izquierda"
  
  override method mover(auto) {
    super(auto)
    auto.position(auto.position().left(1))
  }
  
  override method condicion(auto) = auto.position().x() < 1
}

object autoFactory {
  const property iniciosDerecha = #{game.at(0, 14), game.at(0, 10), game.at(0, 6)}
  const property iniciosIzquierda = #{game.at(14, 15), game.at(14, 11), game.at(14, 7)}
  const property tipos = [amarillo, verde, negro, policia]
  const property autos = []
  
  method spawnAuto(auto) {
    autos.add(auto)
    game.addVisual(auto)
  }
  
  method generarAutos(_direccion) {
    if (_direccion.toString() == "derechaAuto") {
      self.spawnAuto(new Automovil(position = self.inicioRandom(iniciosDerecha), direccion = _direccion, tipo = self.tipoRamdom()))
    } else {
        if (_direccion.toString() == "izquierdaAuto"){
          self.spawnAuto(new Automovil(position = self.inicioRandom(iniciosIzquierda), direccion = _direccion, tipo = self.tipoRamdom()))
        }
    }
  }
  
  method avanzar() {
    autos.forEach({ auto => auto.mover() })
  }
  
  method inicioRandom(inicios) = inicios.anyOne()
  
  method tipoRamdom() = tipos.anyOne()
}

class Tipo {
  method caracteristica()
  
  method aplicarEfecto(personaje) {
    personaje.position(personaje.position().down(1))
  }
  
  method ramdom() = (0 .. (game.width() - 1)).anyOne()
}

object amarillo inherits Tipo {
  override method caracteristica() = "Amarillo"
  
  override method aplicarEfecto(personaje) {
    personaje.position(personaje.position().up(2))
  }
}

object negro inherits Tipo {
  override method caracteristica() = "Negro"
}

object policia inherits Tipo {
  override method caracteristica() = "Policia"
  
  override method aplicarEfecto(personaje) {
    personaje.position(game.at(self.ramdom(), 4))
  }
}

object verde inherits Tipo {
  override method caracteristica() = "Verde"
  
  override method aplicarEfecto(personaje) {
    super(personaje)
    if ((personaje.position().x() + self.ramdom()) >= game.width()){
      self.reasignarX(personaje, 14)
    } else {
      self.reasignarX(personaje, self.ramdom())
    }
  }
  
  method reasignarX(personaje, posicion) {
    personaje.position(game.at(posicion, personaje.position().y()))
  }
}