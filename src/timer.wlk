import wollok.game.*
import posiciones.*
import profesAlumnos.*
import nivel.*

object reloj inherits Visual{
    var property segundos = 60
    var property position = game.at(7,3)

    method reducirTiempo(){
        self.segundos(segundos-1)
    }

    method tieneAunTiempo() {
        return segundos > 0
    }

    method aumentarTiempo(tiempo){
        self.segundos(segundos+tiempo)
    }

    method disminuirTiempo(tiempo){
        self.segundos(segundos-tiempo)
    }

    method segundosParaString(){
        return segundos.toString()
    }

    method charDigitoEnPosicion(unaPosicion){
        return self.segundosParaString().charAt(unaPosicion)
    }

    method removerDigitoDerecho(){
        if (segundos.digits().equals(1)){ game.removeVisual(digitoDerecho)}
    }
    
    method removerDigitoIzquierdo(){
        if (segundos < 0) {game.removeVisual(digitoIzquierdo)}
    }

    method visualizarReloj(){
        game.addVisual(fondoReloj)
        game.addVisual(digitoDerecho)
        game.addVisual(digitoIzquierdo)
    }

    method empezarACorrer() {
        self.reducirTiempo()
        self.removerDigitoIzquierdo()
        self.removerDigitoDerecho()
    }
    

}

object fondoReloj{
    const property position = game.at(0,17)
    method image()= "fondoReloj.png" 
}


class DigitoVisual{
    const property position
    const posicionChar

    method image(){
        return self.digitoQueDeboMostrar()+".png"
    }

    method digitoQueDeboMostrar(){
        return reloj.charDigitoEnPosicion(posicionChar)
    }
}

const digitoIzquierdo = new DigitoVisual(posicionChar=0, position=game.at(0,17))
const digitoDerecho = new DigitoVisual(posicionChar=1, position=game.at(1,17)) 
