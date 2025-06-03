import tablero.*
import wollok.game.*

class Automovil inherits Visual{
    var property position = game.at(0,0)
    const direccion = derecha
    const tipo
    
    method image(){
        return "auto" + tipo.caracteristica() + direccion.nombre()
    }

    method movimiento(){
        game.onTick(2000,"movimiento auto",{direccion.movimiento(self)})
    }

    method choque(personaje){
        personaje.down(1)
    }
}

class Direccion{
    method nombre()
    method direccion(personaje)
    method limite()
    method condicion(personaje)

    method movimiento(personaje){
        personaje.position(self.direccion(personaje))
        if(self.condicion(personaje)){
            game.removeVisual(personaje)
        }
    }   
}

object derecha inherits Direccion{
    override method nombre(){
        return "Derecha"
    }

    override method direccion(personaje){
        return personaje.position().right(1)
    }

    override method limite(){
        return game.width()
    }

    override method condicion(personaje){
        return personaje.position().x() >= game.width()
    }
}
object izquierda inherits Direccion{
    override method nombre(){
        return "Izquierda"
    }

    override method direccion(personaje){
        return personaje.position().left(1)
    }

    override method limite(){
        return 0
    }

    override method condicion(personaje){
        return personaje.position().x() < 0
    }
}

class AutoFactory {
    //const property autosDerecha = [new AutoAmarillo(direccion = derecha), new AutoNegro(direccion = derecha), new AutoPolicia(direccion = derecha), new AutoVerde(direccion = derecha)]
    //const property autosIzquierda = [new AutoAmarillo(direccion = izquierda), new AutoNegro(direccion = izquierda), new AutoPolicia(direccion = izquierda), new AutoVerde(direccion = izquierda)]
    const autoDerecha = new Automovil(position = self.inicioRandom(iniciosDerecha), direccion = derecha, tipo = self.tipoRamdom())
    const property iniciosDerecha = #{game.at(0,14), game.at(0,10), game.at(0,6)}
    const property iniciosIzquierda = #{game.at(14,15), game.at(14,11), game.at(14,7)}
    const property tipos = [amarillo, verde, negro, policia]
    
    method generarAutosDerecha() {
        game.addVisual(autoDerecha.image())
    }
    
    method generarAutosIzquierda() {
        new Automovil(direccion = izquierda, tipo=self.tipoRamdom())
    }

    method inicioRandom(inicios) {
        return inicios.anyOne()
    }

    method tipoRamdom(){
        return tipos.anyOne()
    }
}

class Tipo{
    method caracteristica()
    method aplicarEfecto(personaje){
        personaje.down(1)
    }
    method ramdom(){
        return (0.. (game.width()-1)).anyOne()
    }
}

object amarillo inherits Tipo{
    override method caracteristica(){
        return "Amarillo"
    }

    override method aplicarEfecto(personaje){
        personaje.up(2)
        
    }
}

object negro inherits Tipo{
    override method caracteristica(){
        return "Negro"
    }
}

object policia inherits Tipo{
    override method caracteristica(){
        return "Policia"
    }

    override method aplicarEfecto(personaje){
        personaje.position(0,self.ramdom())
    }
}

object verde inherits Tipo{
    override method caracteristica(){
        return "Verde"
    }

    override method aplicarEfecto(personaje){
        super(personaje)
        if(personaje.position().x() + self.ramdom() >= game.width()){
            self.reasignarX(personaje, 14)
        }else{
            self.reasignarX(personaje, personaje.position().x() + self.ramdom())
        }
    }

    method reasignarX(personaje, posicion){
        personaje.position().x(posicion)
    }
}