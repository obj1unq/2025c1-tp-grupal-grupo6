import tablero.*
import posiciones.*

class Automovil inherits Visual{
    var property position
    const inicio = position.x() // guarda la coordenada x de la posicion inicial
    const direccion = der
    var property image = ""

    method movimiento(_direccion){
        if(direccion == _direccion){
            self.movimientoDerecha()
        }else{
            self.movimientoIzquierda()
        }
    }

    method movimientoIzquierda(){
    //inicio=0 es izq hacia der, inicio=14 es der hacia izq
        if(inicio.x() == 14){
            self.position().left(1)
        }else if(position.x() < 0){
            game.removeVisual(self)
        }
    }

    method movimientoDerecha(){
    //inicio=0 es izq hacia der, inicio=14 es der hacia izq
        if(inicio.x() == 0){
            self.position().right(1)
        }else if(position.x() >14){
            game.removeVisual(self)
        }
    }

    method choque(personaje){
        personaje.down(1)
    }

    //method advertencia() = "correte, que te choco"
    //method efecto()
    //method aplicarEfectO()
}

object der{}
object izq{}

class AutoFactory{
    const property autosDerecha = #{AutoAmarilloHaciaDerecha,AutoNegroHaciaDerecha,AutoPoliciaHaciaDerecha,AutoVerdeHaciaDerecha}
    const property autosIzquierda = #{AutoAmarilloHaciaIzquierda,AutoNegroHaciaIzquierda,AutoPoliciaHaciaIzquierda,AutoVerdeHaciaIzquierda}
    const property iniciosCalleDerecha = #{game.at(0,6),game.at(0,7),game.at(0,10),game.at(0,11),game.at(0,14),game.at(0,15)}
    const property iniciosCalleIzquierda = #{game.at(14,6),game.at(14,7),game.at(14,10),game.at(14,11),game.at(14,14),game.at(14,15)}

    method crearAutoHaciaDerecha(){
        game.addVisual(self.autosDerecha().ramdomize()).at(self.iniciosCalleDerecha().randomize())
    }
    
    method crearAutoHaciaIzquierda(){
        game.addVisual(self.autosIzquierda().ramdomize()).at(self.iniciosCalleIzquierda().randomize())
    }
}

class AutoAmarilloHaciaDerecha inherits Automovil {
    override method image(){
        return "autoAmarilloHaciaDerecha"
    }
}

class AutoNegroHaciaDerecha inherits Automovil {
    override method image(){
        return "autoNegroHaciaDerecha"
    }
}

class AutoPoliciaHaciaDerecha inherits Automovil {
    override method image(){
        return "autoPolicia"
    }
}

class AutoVerdeHaciaDerecha inherits Automovil {
    override method image(){
        return "autoVerdeHaciaDerecha"
    }
}

class AutoAmarilloHaciaIzquierda inherits Automovil {
    override method image(){
        return "autoAmarilloHaciaIzquierda"
    }
}

class AutoNegroHaciaIzquierda inherits Automovil {
    override method image(){
        return "autoNegroHaciaIzquierda"
    }
}

class AutoPoliciaHaciaIzquierda inherits Automovil {
    override method image(){
        return "autoPoliciaParaIzquierda"
    }
}

class AutoVerdeHaciaIzquierda inherits Automovil {
    override method image(){
        return "autoVerdeHaciaIzquierda"
    }
}