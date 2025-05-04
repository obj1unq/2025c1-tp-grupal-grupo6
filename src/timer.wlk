import wollok.game.*
import posiciones.*
import objetos.*

object reloj {
    var property segundos = 150 

    method text() = if (self.tieneAunTiempo()) segundos.toSting() else ""

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
}

