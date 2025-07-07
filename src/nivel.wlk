import wollok.game.*
import profesAlumnos.*
import posiciones.*
import timer.*
import autos.*
import historiaJuego.*

class Nivel {

    const property musica = musicaNivel

    method imagenDeTransicion() = "transicion-1.png"

    method mapa() = []

    method configurar() {
    
        const tablero = self.mapa().reverse()
        game.height(tablero.size())
        game.width(tablero.anyOne().size())
        game.cellSize(96) 
    // Primera pasada 
        (0 .. game.width() - 1).forEach({x =>
            (0 .. game.height() - 1).forEach({y =>
                const constructor = tablero.get(y).get(x)
                constructor.construir(game.at(x, y))
            })
        })
    // Segunda pasada: dibujar capa superior
    (0 .. game.width() - 1).forEach({x =>
        (0 .. game.height() - 1).forEach({y =>
            const constructor = tablero.get(y).get(x)
            constructor.construirEncima(game.at(x, y))
        })
    })

        game.addVisual(alumno)
        musica.reproducir()
    }

    method usaBordes() = true // Por defecto los bordes están habilitados

    method excepcionesMeta() = [] // Salidas
    method excepcionesPositivas() = [] // Posiciones Iniciales
    method excepcionesNegativas() = [] // No se puede pasar, no importa donde sea

    method puedePasar(posicion) {
        return self.estaDentroDeLimite(posicion) &&
           (
               self.excepcionesPositivas().contains(posicion) ||
               (
                   (not self.estaEnBorde(posicion) || self.usaBordes()) &&
                   not self.excepcionesNegativas().contains(posicion)
               )
           )
    }

    method estaDentroDeLimite(posicion) { 	// Revisa si la celda está dentro del tamaño del mapa.
        const x = posicion.x()
        const y = posicion.y()
        return (x >= 0 && x < game.width()) && (y >= 0 && y < game.height())
    }

    method estaEnBorde(posicion) {  // Revisa si está en una fila o columna de borde.
        const x = posicion.x()
        const y = posicion.y()
        return x == 0 || x == game.width() - 1 || y == 0 || y == game.height() - 1
    }

    method puedeMover(personaje, posicion) {  // Chequea si un personaje puede moverse a una celda
        return self.puedePasar(posicion) && self.puedeAtravesar(personaje, posicion)
    }

    method puedeAtravesar(personaje, posicion) {  // Evalúa si la celda está libre de obstáculos no atravesables.
        return game.getObjectsIn(posicion).copyWithout(personaje).all({obj => obj.atravesable()})
    }

    method posicionInicial() = game.at(0, 0)

    method sonidoDeGameover(){
        const gameOver = game.sound("gameOver.mp3")
        gameOver.play()
    }

    method teQuedasteSinTiempo(){
        if(not reloj.tieneAunTiempo()){
            self.quitarGeneracionDeAutos()
            self.quitarTimer()
            musica.parar()  
            self.sonidoDeGameover()
            historiaActual.actual(finDeJuegoSinTiempo)
            historiaActual.continuar()
        }
    }
    
    method esNivelConTimer() = true

    method esPosicionDeMeta(unaPosicion){
        return self.excepcionesMeta().contains(unaPosicion) // es posicion de meta sin la posicion inicial
    }


    method quitarGeneracionDeAutos(){
        game.removeTickEvent("generacionDerecha")
        game.removeTickEvent("generacionIzquierda")
        game.removeTickEvent("movimientoDeAutos")
    }
    
    method quitarTimer(){
        game.removeTickEvent("cuenta regresiva")
        game.removeTickEvent("quitar timer si llego a meta")
    }
}

//-- -------------------------- Musica
object musicaNivel{
    var property musica = game.sound("musicaJuego.mp3")

    method reproducir(){
        musica.shouldLoop(true)
        game.schedule(500, { musica.play()} )
    }

    method parar(){
		musica.pause()
    }

    method reanudar(){
        musica.resume()
    }
}

//---------------------------- 

class Visual {
    method atravesable() {
        return true
    }

    method aplicarEfecto(personaje){}
}

object __ {
    method construir(posicion) {} // Tile vacío, no hace nada por ahora
    method construirEncima(posicion) {}
}

// ------------------------ NIVEL 1 ------------------------------

class FlechaAnimada inherits Visual {
    var property position
    var frame = 0

    const frames = ["flecha001.png", "flecha002.png", "flecha003.png", "flecha004.png"] 

    method image() {
        return frames.get(frame)
    }

    method siguienteFrame() {  // Avanza al siguiente cuadro de la animación
        frame = (frame + 1) % frames.size()
    }

    method iniciarAnimacion() {  // Inicia la animación
        game.onTick(400, "animacionFlecha", { self.siguienteFrame() })
    }

    method pararAnimacion() {     // Para la animacion
        game.removeTickEvent("animacionFlecha")
    }
}

object fl {
    method construir(posicion) {
        
        game.addVisual(new Pasto(position = posicion, image = "vereda.png")) 
        
        const pulsador = new FlechaAnimada(position = posicion)
        game.addVisual(pulsador)
        pulsador.iniciarAnimacion() 
    }

    method construirEncima(posicion) {}
}

class Vereda inherits Visual {
    const property position
    const property image
}

class Pasto inherits Visual {
    const property position
    const property image
}

class Arbusto inherits Visual {
    const property position
    const property image 

    override method atravesable() {
        return false
    }
}

class Arbol inherits Visual {
    const property position
    const property image 

    override method atravesable() {
        return false
    }
} 

class Calle inherits Visual {
    const property position
    const property image
}

class Estacion inherits Visual {
    const property position

    method image() {
        return "estacionNueva01.png" 
    }

    override method atravesable() {
        return false 
    }
}

class Obstaculo inherits Visual {
    const property position

    method image() {
        return "obstaNormal.png" 
    }

    override method atravesable() {
        return false 
    }
}

object oi { // Vereda Normal
    method construir(posicion) {
        game.addVisual(new Vereda(position=posicion, image= "veredaCI.png"))
    }

    method construirEncima(posicion) {
        game.addVisual(new Obstaculo(position=posicion))
    }
}

object os { // Vereda Normal
    method construir(posicion) {
        game.addVisual(new Vereda(position=posicion, image= "veredaCS.png"))
    }

    method construirEncima(posicion) {
        game.addVisual(new Obstaculo(position=posicion))
    }
}

object ve { // Vereda Normal
    method construir(posicion) {
        game.addVisual(new Vereda(position=posicion, image= "vereda.png"))
    }

    method construirEncima(posicion) {}
}

object vs { // Vereda Cordon Superior
    method construir(posicion) {
        game.addVisual(new Vereda(position=posicion, image= "veredaCS.png" ))
    }
    method construirEncima(posicion) {}
}

object vi { // Vereda Cordon Inferior
    method construir(posicion) {
        game.addVisual(new Vereda(position=posicion, image= "veredaCI.png" ))
    }
    method construirEncima(posicion) {}
}

object ci { // Calle Inferior
    method construir(posicion) {
        game.addVisual(new Calle(position=posicion, image="calle-inferior01.png"))
    }
    method construirEncima(posicion) {}
}

object cs { // Calle Superior
    method construir(posicion) {
        game.addVisual(new Calle(position=posicion, image="calle-superior01.png"))
    }
    method construirEncima(posicion) {}
}

object po { // Pasto Normal
    method construir(posicion) {
        game.addVisual(new Pasto(position=posicion, image= "pasto.png"))
    }
    method construirEncima(posicion) {}
}

object pc { // Pasto Cordon Superior
    method construir(posicion) {
        game.addVisual(new Pasto(position=posicion, image= "pastoCS.png"))
    }
    method construirEncima(posicion) {}
}

object pI { // Pasto Cordon Inferior
    method construir(posicion) {
        game.addVisual(new Pasto(position=posicion, image= "pastoCI.png"))
    }
    method construirEncima(posicion) {}
}

object pE { // Pasto Cordon Inferior
    method construir(posicion) {
        game.addVisual(new Pasto(position=posicion, image= "pastoCI.png"))
    }
    method construirEncima(posicion) {
        game.addVisual(new Arbusto(position=posicion, image="arbusto-color01.png"))
    }
}

// Aca tengo que corregir, uso Arbol. Ya hay un arbusto deberia chequear
object pe { // Pasto Cordon Inferior
    method construir(posicion) {
        game.addVisual(new Pasto(position=posicion, image= "pasto.png"))
    }
    method construirEncima(posicion) {
        game.addVisual(new Arbusto(position=posicion, image="arbusto-color01.png"))
    }
}
object es {
    method construir(posicion) {
        if (posicion.equals(game.at(0, 0))) {              // "Solo agregá la estación si esta celda es la celda (0, 0)"
            game.addVisual(new Estacion(position=posicion))
        }
    }
    method construirEncima(posicion) {}
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
        return "Muro01.png"
    }

    override method atravesable() {
        return false
    }
}

class Parque inherits Visual {
    const property position
    const property image

    override method atravesable() { 
        return false
    }
}

class Cartel inherits Visual {
    const property position

    method image() {
        return "cartel-pasto.png"
    }

    override method atravesable() { 
        return false
    }
}

object an { //Arbustos Sin Cordon
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pasto.png"))
        game.addVisual(new Arbusto(position=posicion, image="arbusto-03.png" ))
    }
    method construirEncima(posicion) {}
}

object ai { //Arbustos Cordon Izquierdo
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pastoCIz.png"))
        game.addVisual(new Arbusto(position=posicion, image="arbusto-03.png"))
    }
    method construirEncima(posicion) {}
}

object ad { //Arbustos Cordon Derecho
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pastoCDe.png"))
        game.addVisual(new Arbusto(position=posicion, image="arbusto-03.png"))
    }
    method construirEncima(posicion) {}
}


object  cz { // Cartel con cordon Izquierdo
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pastoCIz.png"))
        game.addVisual(new Cartel(position=posicion))
    }
    method construirEncima(posicion) {}
}

object  cd { // Cartel con cordon Derecho
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pastoCDe.png"))
        game.addVisual(new Cartel(position=posicion))
    }
    method construirEncima(posicion) {}
}

object  cn { // Cartel sin Cordon
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pasto.png"))
        game.addVisual(new Cartel(position=posicion))
    }
    method construirEncima(posicion) {}
}

object fc {
    method construir(posicion) {
     game.addVisual(new Facultad(position=posicion))
    }
    method construirEncima(posicion) {}
}

object puerta inherits Visual {  
    var property position = game.at(6,16) 
    
    method image() {
        return "puertaV.jpg"
    }
    method construirEncima(posicion) {}
}

object pu { 
    method construir(posicion) {
        puerta.position(posicion)
        game.addVisual(puerta)
    }
    method construirEncima(posicion) {}
} 

object unq inherits Visual {  
    var property position = game.at(10,17) 
    
    method image() {
        return "unqui1.png"
    }
    method construirEncima(posicion) {}
}

object un { 
    method construir(posicion) {
        unq.position(posicion)
        game.addVisual(new Facultad(position=posicion))
        game.addVisual(unq)
    }
    method construirEncima(posicion) {}
}

object pa { // Parque Normal
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pasto.png"))
    }
    method construirEncima(posicion) {}
}

object pd { // Parque Cordon Derecho
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pastoCDe.png"))
    }
    method construirEncima(posicion) {}
}

object pz { // Parque Cordon Izquierdo
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pastoCIz.png"))
    }
    method construirEncima(posicion) {}
}

object calleFacu inherits Visual {  // Fondo Gris
    var property position = game.at(1,1) 
    
    method image() {
        return "pisoo.png"
    }
}
   
object cf { // Calle principal 
    method construir(posicion) {
        calleFacu.position(posicion)
        game.addVisual(calleFacu)
    }
    method construirEncima(posicion) {}
} 

object a1 {  // Arbol Cordon Izquierdo
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pastoCIz.png"))
    }
    method construirEncima(posicion) {
        game.addVisual(new Arbol(position=posicion, image="arbolll.png"))
    }
}

object a2 { // Arbol Cordon Derecho
    method construir(posicion) {
       game.addVisual(new Parque(position=posicion, image= "pastoCDe.png"))
    }

    method construirEncima(posicion) {
        game.addVisual(new Arbol(position=posicion, image="arbol01.png"))
    }

} 
object a3 { // Arbol Normal
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pasto.png"))
    }

    method construirEncima(posicion) {
        game.addVisual(new Arbol(position=posicion, image="arbol-005.png"))
    }
}

object a4 { 
    method construir(posicion) {
        game.addVisual(new Parque(position=posicion, image= "pasto.png"))
    }

    method construirEncima(posicion) {
        game.addVisual(new Arbol(position=posicion, image="pino01.png"))
    }
}

object pm {

    const imagenes = ["personaje1-1.png", "personaje2-1.png", "personaje3-1.png", "personaje4-1.png","personaje5-1.png",
                    "personaje6-1.png", "personaje7-1.png", "personaje8-1.png", "personaje9-1.png", "personaje10-1.png"]

    method construir(posicion) {
       game.addVisual(new PersonajeMuro(position=posicion, imagen=imagenes.anyOne()))
    }
    
    method construirEncima(posicion) {}
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

class ComputadoraError inherits Visual {
    const property position

    method image() {
        return "compuError.png"
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

    method construirEncima(posicion) {}
}

object ce {
    method construir(posicion) {
        game.addVisual(new ComputadoraError(position=posicion))
    }

    method construirEncima(posicion) {}

}

object ps { 
    method construir(posicion) {
        if (posicion.equals(game.at(0, 0))) {              
            game.addVisual(new Piso(position=posicion))
        }
    }
    method construirEncima(posicion) {}
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
        if (posicion.equals(game.at(0, 14))) {              
            game.addVisual(new Pizarron(position=posicion))
        }
    }
    method construirEncima(posicion) {}
}

/* ------------------------NIVELES ------------------------- */

object nivel1 inherits Nivel {

    override method mapa() = [
        [po,po,po,ve,ve,ve,fl,fl,fl,ve,ve,ve,pe,po,pe],
        [pI,pI,pI,oi,vi,vi,vi,vi,vi,vi,oi,vi,pI,pI,pI],
        [cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs],   //(0,15) (14,15)
        [ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci],   //(0,14) (14,14)
        [vs,vs,vs,vs,vs,os,vs,vs,vs,vs,vs,os,vs,vs,vs],
        [vi,vi,vi,oi,vi,vi,vi,vi,vi,vi,vi,vi,vi,vi,vi],
        [cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs],   //(0,11) (14,11)
        [ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci],   //(0,10) (14,10)
        [vs,vs,vs,vs,os,vs,vs,vs,vs,vs,vs,vs,os,vs,vs],
        [vi,vi,oi,vi,vi,vi,vi,oi,oi,vi,vi,vi,vi,vi,vi],
        [cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs,cs],   //(0,7) (14,7)
        [ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci,ci],   //(0,6) (14,6)    
        [vs,vs,vs,os,vs,vs,vs,vs,vs,vs,vs,vs,pc,pc,pc],
        [ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,ve,po,po,pe],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [es,__,__,__,__,__,__,__,__,__,__,__,__,__,__]  
    ]

    override method imagenDeTransicion() = "transicion-1nueva.png"

    override method excepcionesNegativas() = [game.at(0, 3), game.at(1, 3), game.at(2, 3),game.at(3, 3), game.at(4, 3), game.at(5, 3), game.at(6, 3), game.at(7, 3), game.at(8, 3), game.at(9, 3), game.at(10, 3), game.at(11, 3), game.at(12, 3), game.at(13, 3), game.at(14, 3)] // Toda la fila 3, para que no pase a la estacion
    override method excepcionesMeta() = [game.at(6,17), game.at(7, 17), game.at(8, 17)] // Pasaje borde superior
    override method posicionInicial() = game.at(8, 4)

    override method configurar(){
        super()

        game.onTick(1900, "generacionDerecha", {autoFactory.generarAutos(derechaAuto)})
        game.onTick(1900, "generacionIzquierda", {autoFactory.generarAutos(izquierdaAuto)})

        game.onTick(400, "movimientoDeAutos", {autoFactory.avanzar()})
        reloj.visualizarReloj()
        game.onTick(1000, "cuenta regresiva", { reloj.empezarACorrer()
                                                self.teQuedasteSinTiempo()})
    }

    method quitarFlechasLuminosasPasandoNivel(){
        if(self.esPosicionDeMeta(alumno.position())){
            game.removeTickEvent("animacionFlechasGlobal")
        }
    }
}

object nivel2 inherits Nivel {

    override method mapa() = [
        [fc,fc,fc,fc,fc,fc,__,__,__,fc,un,__,fc,fc,fc], // Salida
        [fc,fc,fc,fc,fc,fc,pu,__,__,fc,fc,fc,fc,fc,fc],
        [pa,a1,__,pm,__,pm,__,pm,__,__,__,__,__,a2,pa],
        [pa,pz,__,__,__,pm,pm,pm,__,pm,pm,pm,__,pd,pa],
        [pa,pz,pm,pm,__,pm,__,__,pm,__,__,__,__,pd,pa],
        [pa,pz,__,pm,__,__,__,pm,__,__,__,pm,pm,pd,pa],
        [pa,pz,__,__,__,pm,pm,__,__,pm,__,pm,pm,pd,pa],
        [a4,pz,__,pm,pm,pm,__,pm,__,pm,__,__,__,pd,cn],
        [pa,pz,__,__,__,__,__,__,pm,pm,pm,pm,__,pd,pa],
        [pa,pz,__,pm,pm,__,pm,__,pm,__,__,__,__,pd,pa],
        [pa,pz,pm,pm,__,__,pm,__,__,__,pm,pm,pm,pd,pa],
        [pa,cz,__,__,__,pm,pm,__,__,pm,__,__,__,pd,a3],
        [pa,pz,__,pm,pm,pm,pm,pm,__,__,__,pm,__,pd,pa],
        [pa,pz,__,__,__,pm,__,__,__,__,pm,pm,__,pd,pa],
        [a3,pz,__,pm,__,__,__,pm,pm,__,pm,pm,__,cd,pa],
        [pa,pz,pm,pm,pm,__,pm,pm,__,__,__,__,__,pd,pa],
        [pa,pz,__,pm,__,__,__,__,pm,pm,pm,__,pm,pd,pa],
        [an,ai,cf,__,__,__,__,__,__,__,__,__,__,ad,an]   // Entrada 
    ]

    override method imagenDeTransicion() = "transicion-2nueva.png"

    override method usaBordes() = false

    override method excepcionesPositivas() = [game.at(2, 0), game.at(3, 0), game.at(4, 0), game.at(5, 0), game.at(6, 0), game.at(7, 0), game.at(8, 0), game.at(9, 0), game.at(10, 0), game.at(11, 0), game.at(12, 0)]
    override method excepcionesMeta() = [game.at(6,16), game.at(7, 16), game.at(8, 16)]  // puertas en el borde superior
    override method posicionInicial() = game.at(7, 0)
    
    override method configurar(){
        super()
        self.quitarGeneracionDeAutos()
        reloj.visualizarReloj()
        game.onTick(1000,"quitar timer si llego a meta", {self.quitarTimerSiEstoyPasandoDeNivel()})
    }

    method quitarTimerSiEstoyPasandoDeNivel(){
        if(self.esPosicionDeMeta(alumno.position())){
            game.removeTickEvent("cuenta regresiva")
            game.removeTickEvent("quitar timer si llego a meta")
            game.removeVisual(digitoDerecho)
            game.removeVisual(digitoIzquierdo)
            game.removeVisual(fondoReloj)
        }
    }
}

object nivel3 inherits Nivel {

    override method mapa() = [
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [pi,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,ce,__,cm,__,cm,__,cm,__,cm,__,cm,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,ce,__,cm,__,cm,__,cm,__,cm,__,ce,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__], 
        [__,__,cm,__,cm,__,ce,__,cm,__,cm,__,cm,__,__], 
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,cm,__,cm,__,cm,__,cm,__,cm,__,cm,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,cm,__,ce,__,ce,__,cm,__,cm,__,cm,__,__],
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [__,__,cm,__,cm,__,cm,__,cm,__,cm,__,cm,__,__], 
        [__,__,__,__,__,__,__,__,__,__,__,__,__,__,__],
        [ps,__,__,__,__,__,__,__,__,__,__,__,__,__,__]

    ]
    
    override method excepcionesNegativas() = [game.at(0, 15), game.at(1, 15), game.at(2, 15),game.at(3, 15), game.at(4, 15), game.at(5, 15), game.at(6, 15), game.at(7, 15), game.at(8, 15), game.at(9, 15), game.at(10, 15), game.at(11, 14), game.at(12, 15), game.at(13, 15), game.at(14, 15)] //15 
    override method usaBordes() = true
    override method excepcionesPositivas() = [game.at(4, 0)]  
    override method posicionInicial() = game.at(4, 0)
    override method esNivelConTimer() = false
    
    override method configurar(){
        super()
        self.quitarGeneracionDeAutos()
        self.quitarTimer()
        self.agregarProfesoresYEstudiantes()
    }

    method agregarProfesoresYEstudiantes() {

        const personajes = [leo, debi, isa, maxi, yami, maria]
        
        personajes.forEach { persona => game.addVisual(persona)}
        game.onCollideDo(alumno, {persona => persona.mensaje()})
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
    const transicion = new Transicion (image= nivelTerminado.imagenDeTransicion() )
    historiaActual.actual(transicion)
    historiaActual.iniciar()
  }

  method limpiarNivelActual() {
    game.allVisuals().forEach({visual => game.removeVisual(visual)})
    self.nivelActual().configurar()
  } 
}