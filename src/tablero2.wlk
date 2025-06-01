import objetos.*
import pgmProgram.*
import posiciones.*
import timer.*

class Visual {
    method atravesable() {
        return true
    }
}
object nivel {
  
  method puedeMover(personaje, posicion) {
    return self.existe(posicion) && self.puedeAtravesar(personaje, posicion)
  }

  method puedeAtravesar(personaje, posicion) {
    return game.getObjectsIn(posicion).copyWithout(personaje).all({visual => visual.atravesable()})
  }

  method existe(posicion) {
    return self.existeX(posicion.x()) && self.existeY(posicion.y())
  }

  method existeX(x) {
    return x >= 0 && x < game.width()
  }

  method existeY(y) {
    return y >= 0 && y < game.height()
  }
} 


class PersonajeMuro inherits Visual {

    const property position

    const imagen = "personaje1.png"


    method image() = imagen

    override method atravesable() = false
} 

class Facultad inherits Visual {
    const property position

    method image() {
        return "facu.png"
    }

    override method atravesable() {
        return false
    }
}

class Reja inherits Visual {
    const property position

    method image() {
        return "reja.png"
    }

    override method atravesable() { 
        return false
    }
}


class Parque inherits Visual {
    const property position

    method image() {
        return "pastito-facu.jpg"
    }

    override method atravesable() { 
        return false
    }
}


object _ {
    method construir(posicion) { // Tile vacío, no hace nada por ahora
    }
}

object f {
    method construir(posicion) {
     game.addVisual(new Facultad(position=posicion))
    }
}

object a { // alumno
    method construir(posicion) {
        game.addVisual(alumno)
    }
}

object r { // Rejas
    method construir(posicion) {
        game.addVisual(new Reja(position=posicion))
    }
}

object v { // Parque
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion))
    }
}

object calleFacu inherits Visual {  // Fondo Gris
    var property position = game.at(1,1) 
    
    method image() {
        return "calle-facu.jpg"
    }

    override method atravesable() {
        return true
    }
}
    
 object c { // Calle principal 

    method construir(posicion) {
        calleFacu.position(posicion)
        game.addVisual(calleFacu)
    }
} 

object p {

    const imagenes = ["personaje1-1.png", "personaje2-1.png", "personaje3-1.png", "personaje4-1.png","personaje5-1.png",
 "personaje6-1.png", "personaje7-1.png", "personaje8-1.png", "personaje9-1.png", "personaje10-1.png"]

    method construir(posicion) {
       game.addVisual(new PersonajeMuro(position=posicion, imagen=imagenes.anyOne()))
    }
}



object tableroNivel2 {
    const mapa = [
        [f,f,f,f,f,f,f,_,f,f,f,f,f,f,f], // Salida
        [v,p,p,p,p,p,p,_,_,_,p,p,p,p,v],
        [v,p,_,p,_,_,_,_,p,_,_,_,_,_,v],
        [v,p,_,p,_,p,p,p,p,p,p,p,p,_,v],
        [v,_,_,_,_,p,_,_,p,p,_,p,_,_,v],
        [v,_,p,p,p,_,p,_,p,_,_,p,_,p,v],
        [v,_,p,_,_,_,p,_,_,_,p,p,_,_,v],
        [v,_,_,_,p,_,p,p,p,_,p,p,_,p,v],
        [v,_,_,_,p,_,_,_,_,_,_,p,_,p,v],
        [v,p,p,p,p,p,p,_,p,p,_,_,_,p,v],
        [v,p,_,_,_,_,_,_,_,p,p,p,p,p,v],
        [v,p,p,p,p,_,_,p,_,_,_,_,p,_,v],
        [v,_,_,_,p,p,_,p,_,p,p,p,p,_,v],
        [v,_,p,_,_,p,_,p,p,p,p,_,p,_,v],
        [v,p,p,p,_,p,_,_,p,_,p,_,p,_,v],
        [v,_,p,_,_,p,p,_,_,_,_,_,_,_,v],
        [v,c,_,_,_,_,_,_,p,p,_,p,p,p,v],
        [r,r,r,r,r,r,r,a,r,r,r,r,r,r,r]   // Entrada 
    ].reverse()

    method configurar() {
        game.height(mapa.size())
        game.width(mapa.anyOne().size())
        game.cellSize(96) 

        (0 .. game.width() - 1).forEach({x =>
            (0 .. game.height() - 1).forEach({y =>
                const constructor = mapa.get(y).get(x)
                constructor.construir(game.at(x, y))
            })
        })
    }
}
