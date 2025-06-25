/* import objetos.*
import pgmProgram.*
import posiciones.*
import timer.*

class Visual {
    method atravesable() {
        return true
    }
}

class Pupitre inherits Visual {
    const property position

    method image() {
        return "pupitre.png"
    }

    override method atravesable() { // El override es para redefinir un metodo de la clase, en este caso es igual. Es necesario? 
        return false
    }
}

class Escritorio inherits Visual {
    const property position

    method image() {
        return "escritorio.png"
    }

    override method atravesable() {
        return false
    }
}

object pizarronVerde inherits Visual {
    method image() {
        return "pizarron-verde.png"
    }

}

object pizarronNotas inherits Visual {
    method image() {
        return "pizarron-notas.png"
    }

}

object piso inherits Visual {
    method image() {
        return "pizarron-notas.png"
    }

}

object _ {
    method construir(posicion) {// Tile vacío, no hace nada por ahora
    }
}

object p { // 
    method construir(posicion) {
        game.addVisual(new Pupitre(position=posicion))
    }
}

object e { // 
    method construir(posicion) {
        game.addVisual(new Escritorio(position=posicion))
    }
}

object pi { //
    method construir(posicion) {
        game.addVisual(pizarronVerde)
    }
}

object pn { // 
    method construir(posicion) {
        game.addVisual(pizarronNotas)
    }
}

object p

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
 */