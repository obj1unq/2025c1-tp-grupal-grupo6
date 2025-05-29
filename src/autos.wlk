import tablero.*
import posiciones.*

class Automovil inherits Visual{
    var property position
    const direccion = derecha
    
    method inicio(){
        return position.x() // guarda la coordenada x de la posicion inicial
    }
    
    method image(){
        return "Auto" + self.color() + direccion.nombre()
    }

    method color()

    method movimiento(){
        //inicio=0 es izq hacia der, inicio=14 es der hacia izq
        direccion.movimiento(self)
        if(self.inicio().x() == 14){
            self.position().left(1)
        }else if(position.x() < 0){
            game.removeVisual(self)
        }
    }

    method choque(personaje){
        personaje.down(1)
        self.aplicarEfecto()
    }

    method aplicarEfecto()

    //method advertencia() = "correte, que te choco"
    //method efecto()
}

object movimientoDerecha{
    method nombre(){
        return "Derecha"
    }

    method movimiento(personaje){
        //inicio=0 es izq hacia der, inicio=14 es der hacia izq
        personaje.position(personaje.position().left(1))
        if(personaje.position().x() >= game.width()){
            game.removeVisual(personaje)
        }
    }
}
object movimientoIzquierda{
    method nombre(){
        return "Izquierda"
    }

    method movimiento(personaje){
        //inicio=0 es izq hacia der, inicio=14 es der hacia izq
        personaje.position(personaje.position().right(1))
        if(personaje.position().x() < 0){
            game.removeVisual(personaje)
        }
    }
}

class AutoFactory{
    const property autosDerecha = #{AutoAmarilloHaciaDerecha,AutoNegroHaciaDerecha,AutoPoliciaHaciaDerecha,AutoVerdeHaciaDerecha}
    const property autosIzquierda = #{AutoAmarilloHaciaIzquierda,AutoNegroHaciaIzquierda,AutoPoliciaHaciaIzquierda,AutoVerdeHaciaIzquierda}
    
    method crearAutoHaciaDerecha(posicion){
        self.crearAuto()
    }

    method crearAuto()
    
    method crearAutoHaciaIzquierda(){
        game.addVisual(self.autosIzquierda().ramdomize())
    }
}

object fila1Derecha{
    const property inicio = game.at(0,6)
}

object fila2Derecha{
    const property inicio = game.at(0,10)
}

object fila3Derecha{
    const property inicio = game.at(0,14)
}

object fila1Izquierda{
    const property inicio = game.at(14,7)
}

object fila2Izquierda{
    const property inicio = game.at(14,11)
}

object fila3Izquierda{
    const property inicio = game.at(14,15)
}

class AutoAmarilloHaciaDerecha inherits AutomovilDerecha {
    override method image(){
        return "autoAmarilloHaciaDerecha"
    }
}

class AutoNegroHaciaDerecha inherits AutomovilDerecha {
    override method image(){
        return "autoNegroHaciaDerecha"
    }
}

class AutoPoliciaHaciaDerecha inherits AutomovilDerecha {
    override method image(){
        return "autoPolicia"
    }
}

class AutoVerdeHaciaDerecha inherits AutomovilDerecha {
    override method image(){
        return "autoVerdeHaciaDerecha"
    }
}

class AutoAmarilloHaciaIzquierda inherits AutomovilIzquierda {
    override method image(){
        return "autoAmarilloHaciaIzquierda"
    }
}

class AutoNegroHaciaIzquierda inherits AutomovilIzquierda {
    override method image(){
        return "autoNegroHaciaIzquierda"
    }
}

class AutoPoliciaHaciaIzquierda inherits AutomovilIzquierda {
    override method image(){
        return "autoPoliciaParaIzquierda"
    }
}

class AutoVerdeHaciaIzquierda inherits AutomovilIzquierda {
    override method image(){
        return "autoVerdeHaciaIzquierda"
    }
}