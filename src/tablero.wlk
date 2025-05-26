import objetos.*
import pgmProgram.*
import posiciones.*
import timer.*
import autos.*

class Visual {
    method atravesable() {
        return true
    }
}

class Vereda inherits Visual {
    const property position

    method image() {
        return "vereda.png"
    }

    override method atravesable() { // El override es para redefinir un metodo de la clase, en este caso es igual. Es necesario? 
        return true
    }
}

class Pasto inherits Visual {
    const property position

    method image() {
        return "pasto.png"
    }

    override method atravesable() {
        return true
    }
}

class ArbustoChico inherits Visual {
    const property position

    method image() {
        return "arbusto-chico.png"
    }

    override method atravesable() {
        return false
    }
}

class ArbustoGrande inherits Visual {
    const property position

    method image() {
        return "arbusto-grande.png"
    }

    override method atravesable() {
        return false
    }
}

/* class Arbol inherits Visual {
    const property position

    method image() {
        return "arbol.png"
    }

    override method atravesable() {
        return trfalseue
    }
} */

class CalleSuperior inherits Visual {
    const property position

    method image() {
        return "calle-superior.png"
    }

    override method atravesable() {
        return true
    }
}

class CalleInferior inherits Visual {
    const property position

    method image() {
        return "calle-inferior.png"
    }

    override method atravesable() {
        return true
    }
}

class Estacion inherits Visual {
    const property position

    method image() {
        return "estacion-bernal.png" 
    }

    override method atravesable() {
        return false 
    }
}

object _ {
    method construir(posicion) {// Tile vacío, no hace nada por ahora
    }
}

object v { // Vereda
    method construir(posicion) {
        game.addVisual(new Vereda(position=posicion))
    }
}

object ci { // Calle Inferior
    method construir(posicion) {
        game.addVisual(new CalleInferior(position=posicion))
    }
}

object cs { // Calle Superior
    method construir(posicion) {
        game.addVisual(new CalleSuperior(position=posicion))
    }
}

object p { // Pasto
    method construir(posicion) {
        game.addVisual(new Pasto(position=posicion))
    }
}

object ac { // Arbusto Chico
    method construir(posicion) {
        game.addVisual(new ArbustoChico(position=posicion))
    }
}

object ag { // Arbusto Grande
    method construir(posicion) {
        game.addVisual(new ArbustoGrande(position=posicion))
    }
}

object estacion {
    method construir(posicion) {
        if (posicion.equals(game.at(0, 0))) {              // "Solo agregá la estación si esta celda es la celda (0, 0)"
            game.addVisual(new Estacion(position=posicion))
        }
    }
}

object tablero {
    const mapa = [
        [ac,ag,ac,v,v,v,v,v,v,v,v,v,ac,ag,ac],
        [p,p,p,v,v,v,v,v,v,v,v,v,p,p,p],
        [cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs],   //(0,15) (14,15)
        [ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci],   //(0,14) (14,14)
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs],   //(0,11) (14,11)
        [ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci],   //(0,10) (14,10)
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        [cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs],   //(0,7) (14,7)
        [ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci],   //(0,6) (14,6)    
        [v,v,v,v,v,v,v,v,v,v,v,v,ac,ag,ac],
        [v,v,v,v,v,v,v,v,v,v,v,v,p,p,p],
        [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
        [estacion,_,_,_,_,_,_,_,_,_,_,_,_,_,_]  // En este renglon quiero la imagen de la estación. Sera poner de fondo esa imagen y por arriba todo esto?
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

        game.addVisual(alumno)
    }
}
