import wollok.game.*
import posiciones.*
import objetos.*

object reloj {
    var property segundos = 150
    var property position = game.at(7,3)

    method text(){
        
        return if (self.tieneAunTiempo()){
            segundos.printString()
        }else {""}
    }

    method reducirTiempo(){
        self.segundos(segundos-1)
    }

    method textColor() ="FF87CEEB"

    method tieneAunTiempo() {
        return segundos > 0
    }

    method aumentarTiempo(tiempo){
        self.segundos(segundos+tiempo)
    }

    method disminuirTiempo(tiempo){
        self.segundos(segundos-tiempo)
    }
    
    method aplicarEfecto(personaje) {

    }
}

