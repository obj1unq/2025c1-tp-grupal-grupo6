import objetos.*
import pgmProgram.*
import posiciones.*
import timer.*
import autos.*
import historiaJuego.*

class Nivel {

    // const visualesActuales = []

    method imagenDeTransicion() = "transicion-1.png"

    method mapa() = []

    method configurar() {
    
        const tablero = self.mapa().reverse()
        game.height(tablero.size())
        game.width(tablero.anyOne().size())
        game.cellSize(96) 

        (0 .. game.width() - 1).forEach({x =>
            (0 .. game.height() - 1).forEach({y =>
                const constructor = tablero.get(y).get(x)
                constructor.construir(game.at(x, y))
            })
        })

        game.addVisual(alumno)
        self.musicaDeFondo()
    }

    method usaBordes() = true // Por defecto los bordes están habilitados

    method excepcionesPositivas() = [] // Salidas, cambio el nombre? Se puede pasar aunque esté en borde
    method excepcionesNegativas() = [] // No se puede pasar, no importa donde sea

    method puedePasar(posicion) {
        return self.excepcionesPositivas().contains(posicion) ||
               (
                   self.estaDentroDeLimite(posicion) &&
                   (not self.estaEnBorde(posicion) || self.usaBordes()) &&
                   not self.excepcionesNegativas().contains(posicion)
               )
    }

    method estaDentroDeLimite(posicion) { 	// Revisa si la celda está dentro del tamaño del mapa.
        const x = posicion.x()
        const y = posicion.y()
        return x >= 0 && x < game.width() && y >= 0 && y < game.height() 
    }

    method estaEnBorde(posicion) {  // Revisa si está en una fila o columna de borde.
        const x = posicion.x()
        const y = posicion.y()
        return x == 0 || x == game.width() - 1 || y == 0 || y == game.height() - 1
    }

    method puedeMover(personaje, posicion) {  // Chequea si un personaje puede moverse a una celda
        return 
               self.puedePasar(posicion) &&
               self.puedeAtravesar(personaje, posicion)
    }

    method puedeAtravesar(personaje, posicion) {  // Evalúa si la celda está libre de obstáculos no atravesables.

        return game.getObjectsIn(posicion).copyWithout(personaje).all({obj => obj.atravesable()})
    }

    method posicionInicial() = game.at(0, 0)

    method musicaDeFondo() {
        
        const musica = game.sound("musica" + self.valorNivel() + ".mp3")
        musica.shouldLoop(true)
        game.schedule(500, { musica.play()} )

        return musica

    }

    method valorNivel() 
}

class Visual {
    method atravesable() {
        return true
    }

    method aplicarEfecto(personaje){}
}

object __ {
    method construir(posicion) {// Tile vacío, no hace nada por ahora
    }
}



// ------------------------ NIVEL 1 ------------------------------


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

class Arbol inherits Visual {
    const property position

    method image() {
        return "arbol.png"
    }

    override method atravesable() {
        return false
    }
} 

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

object ve { // Vereda
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

object po { // Pasto q
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

object es {
    method construir(posicion) {
        if (posicion.equals(game.at(0, 0))) {              // "Solo agregá la estación si esta celda es la celda (0, 0)"
            game.addVisual(new Estacion(position=posicion))
        }
    }
}

// ------------------------ NIVEL 2 ------------------------------ 

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

class Parque inherits Visual {
    const property position

    method image() {
        return "pastito-facu.jpg"
    }

    override method atravesable() { 
        return false
    }
}

class Farola inherits Visual {
    const property position

    method image() {
        return "farola.jpg"
    }

    override method atravesable() { 
        return false
    }
}

class Cartel inherits Visual {
    const property position

    method image() {
        return "cartel-pasto.png"
    }

    override method atravesable() { // El override es para redefinir un metodo de la clase, en este caso es igual. Es necesario? 
        return false
    }
}

object  ca {
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion))
        game.addVisual(new Cartel(position=posicion))
    }
}

object fc {
    method construir(posicion) {
     game.addVisual(new Facultad(position=posicion))
    }
}

/* object a { // alumno
    method construir(posicion) {
        game.addVisual(alumno)
    }
}
 */

object pa { // Parque
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
   
object cf { // Calle principal 

    method construir(posicion) {
        calleFacu.position(posicion)
        game.addVisual(calleFacu)
    }
} 

object ar { // Calle principal 

    method construir(posicion) {
        game.addVisual(new Arbol(position=posicion))
    }
} 

object fa { // Calle principal 

    method construir(posicion) {
        game.addVisual(new Farola(position=posicion))
    }
} 



object pm {

    const imagenes = ["personaje1-1.png", "personaje2-1.png", "personaje3-1.png", "personaje4-1.png","personaje5-1.png",
 "personaje6-1.png", "personaje7-1.png", "personaje8-1.png", "personaje9-1.png", "personaje10-1.png"]

    method construir(posicion) {
       game.addVisual(new PersonajeMuro(position=posicion, imagen=imagenes.anyOne()))
    }
}

// ------------------------ NIVEL 3 ------------------------------ 

class Computadora inherits Visual {
    const property position

    method image() {
        return "escritoriofinal.png"
    }

    override method atravesable() {
        return false
    }
}

  class Piso inherits Visual {

    const property position

    method image() {
        return "piso-final.png"
    }

}  

object cm {  
    method construir(posicion) {
        game.addVisual(new Computadora(position=posicion))
    }
}


object ps { 
    method construir(posicion) {
        if (posicion.equals(game.at(0, 0))) {              
            game.addVisual(new Piso(position=posicion))
        }
    }
} 



class Pizarron inherits Visual {
    const property position

    method image() {
        return "bannerPizarron.png" 
    }

    override method atravesable() {
        return false 
    }
}

object pi {
    method construir(posicion) {
        if (posicion.equals(game.at(0, 14))) {              // 
            game.addVisual(new Pizarron(position=posicion))
        }
    }
}


/* ------------------------NIVELES ------------------------- */

object nivel1 inherits Nivel {

    override method mapa() = [
        [ac,ag,ac,ve,ve,ve,ve,ve,ve,ve,ve,ve,ac,ag,ac],
        [po,po,po,ve,ve,ve,ve,ve,ve,ve,ve,ve,po,po,po],
        [cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs],   //(0,15) (14,15)
        [ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci],   //(0,14) (14,14)
        [ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve],
        [ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve],
        [cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs],   //(0,11) (14,11)
        [ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci],   //(0,10) (14,10)
        [ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve],
        [ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve],
        [cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs],   //(0,7) (14,7)
        [ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci],   //(0,6) (14,6)    
        [ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ac,ag,ac],
        [ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,po,po,po],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [es,__,__,__,__,__,__,__,__,__,__,__,__,__,__]  // En este renglon quiero la imagen de la estación. Sera poner de fondo esa imagen y por arriba todo esto?
    ]

    override method imagenDeTransicion() = "transicion-1nueva.png"

    override method excepcionesNegativas() = [game.at(0, 3), game.at(1, 3), game.at(2, 3),game.at(3, 3), game.at(4, 3), game.at(5, 3), game.at(6, 3), game.at(7, 3), game.at(8, 3), game.at(9, 3), game.at(10, 3), game.at(11, 3), game.at(12, 3), game.at(13, 3), game.at(14, 3)] // Toda la fila 3, para que no pase a la estacion
    override method excepcionesPositivas() = [game.at(6,17), game.at(7, 17), game.at(8, 17)] // Pasaje borde superior
    override method posicionInicial() = game.at(8, 4)

    override method configurar(){
        super()
        game.onTick(1900, "generacionDerecha", {autoFactory.generarAutos(derechaAuto)})
        game.onTick(1900, "generacionIzquierda", {autoFactory.generarAutos(izquierdaAuto)})
        game.onTick(400, "movimientoDeAutos", {autoFactory.avanzar()})
    }

    overoverride method valorNivel() {
        return "Nivel1"
    }
}

object nivel2 inherits Nivel {

    override method mapa() = [
        [fc,fc,fc,fc,fc,fc,__,__,__,fc,fc,fc,fc,fc,fc], // Salida
        [pa,pa,__,__,__,pm,__,__,pm,__,__,pm,__,pa,pa],
        [pa,pa,__,pm,__,__,__,pm,__,pm,__,__,__,pa,pa],
        [pa,pa,__,__,__,pm,pm,pm,__,__,pm,pm,__,pa,pa],
        [pa,pa,pm,pm,__,pm,__,__,pm,__,__,__,__,pa,pa],
        [pa,pa,__,pm,__,__,__,pm,__,__,__,pm,pm,pa,pa],
        [pa,pa,__,__,__,pm,pm,__,__,pm,__,pm,pm,pa,pa],
        [pa,pa,__,pm,pm,pm,__,pm,__,pm,__,__,__,pa,ca],
        [pa,pa,__,__,__,__,__,__,pm,pm,pm,pm,__,pa,pa],
        [pa,pa,__,pm,pm,__,pm,__,pm,__,__,__,__,pa,pa],
        [pa,pa,pm,pm,__,__,pm,__,__,__,pm,pm,pm,pa,pa],
        [pa,ca,__,__,__,pm,pm,__,__,pm,__,__,__,pm,pm],
        [pa,pa,__,pm,pm,pm,pm,pm,__,__,__,pm,__,pa,pa],
        [pa,pa,__,__,__,pm,__,__,__,__,pm,pm,__,pa,pa],
        [pa,pa,__,pm,__,__,__,pm,pm,__,pm,pm,__,pa,pa],
        [pa,pa,pm,pm,pm,__,pm,pm,__,__,__,__,__,pa,pa],
        [pa,pa,cf,pm,__,__,__,__,pm,pm,pm,__,pm,pa,pa],
        [ar,ag,ac,ag,ac,fa,__,__,__,fa,ac,ag,ac,ag,ar]   // Entrada 
    ]

    override method imagenDeTransicion() = "transicion-2nueva.png"

    

    override method usaBordes() = false
    override method excepcionesPositivas() = [game.at(7, 0), game.at(6,17), game.at(7, 17), game.at(8, 17)]  // puertas en el borde superior
    override method posicionInicial() = game.at(7, 0)


    override method valorNivel() {
        return "Nivel2"
    }
}

object nivel3 inherits Nivel {
    override method mapa() = 
    [
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [pi,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,cm,__,cm,__,cm,__,cm,__,cm,__,cm,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,cm,__,cm,__,cm,__,cm,__,cm,__,cm,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,cm,__,cm,__,cm,__,cm,__,cm,__,cm,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,cm,__,cm,__,cm,__,cm,__,cm,__,cm,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,cm,__,cm,__,cm,__,cm,__,cm,__,cm,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,cm,__,cm,__,cm,__,cm,__,cm,__,cm,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [ps,__,__,__,__,__,__,__,__,__,__,__,__,__,__]

    ]
    

    override method excepcionesNegativas() = [game.at(0, 15), game.at(1, 15), game.at(2, 15),game.at(3, 15), game.at(4, 15), game.at(5, 15), game.at(6, 15), game.at(7, 15), game.at(8, 15), game.at(9, 15), game.at(10, 15), game.at(11, 14), game.at(12, 15), game.at(13, 15), game.at(14, 15)] //14 
    override method usaBordes() = false
    override method excepcionesPositivas() = [game.at(4, 0)]  
    override method posicionInicial() = game.at(4, 0)
    override method configurar() {
        super()
        game.addVisual(leo)
        game.addVisual(debi)
        game.addVisual(isa)
    }


    override method valorNivel() {
        return "Nivel3"
    }

}


object nivelManager {
  const  niveles = [nivel1, nivel2, nivel3]
  var property indiceNivelActual = 0

  method nivelActual() = niveles.get(indiceNivelActual)

  method avanzarNivel() {
    const nivelTerminado = self.nivelActual()
    indiceNivelActual = indiceNivelActual + 1
    self.limpiarNivelActual()
    const transicion = new Transicion (image= nivelTerminado.imagenDeTransicion(), nivel = self.nivelActual() )
    historiaActual.actual(transicion)
    historiaActual.iniciar()

  }

  method limpiarNivelActual() {
    //niveles.get(indiceNivelActual).configurar()
    game.allVisuals().forEach({visual => game.removeVisual(visual)})
    self.nivelActual().configurar()
  } 
}




