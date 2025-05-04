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
}

