import wollok.game.*
import nivel.*

class Automovil inherits Visual{
    var property position
    const direccion
    const tipo
    
    method image(){
        return "auto" + self.tipo() + self.direccion()
    }

    method tipo(){
        return tipo.caracteristica()
    }

    method direccion(){
        return direccion.nombre()
    }

    method mover(){
        direccion.mover(self)
    }

    method aplicarEfecto(personaje){
        personaje.down(1)
    }
}

class Direccion{
    method nombre()
    method condicion(auto)

    method mover(auto){
        if(self.condicion(auto)){
            game.removeVisual(auto)
        }
    }   
}

object derecha inherits Direccion{
    override method nombre(){
        return "Derecha"
    } //derecha no entiende mover(arg 0)

    override method mover(auto){
        super(auto)
        auto.position().right(1)
    }

    override method condicion(auto){
        return auto.position().x() >= game.width()-1
    }
}

object izquierda inherits Direccion{
    override method nombre(){
        return "Izquierda"
    }

    override method mover(auto){
        super(auto)
        auto.position().left(1)
    }

    override method condicion(auto){
        return auto.position().x() < 1
    }
}

object autoFactory {
    const property iniciosDerecha = #{game.at(0,14), game.at(0,10), game.at(0,6)}
    const property iniciosIzquierda = #{game.at(14,15), game.at(14,11), game.at(14,7)}
    const property tipos = [amarillo, verde, negro, policia]
    const property autos = []
    
    method spawnAuto(auto){
        autos.add(auto)
        game.addVisual(auto)
    }

    method generarAutos(_direccion) {
        if(_direccion.toString() == "derecha"){
            self.spawnAuto(new Automovil(position = self.inicioRandom(iniciosDerecha), direccion = _direccion, tipo = self.tipoRamdom()))
        }else if(_direccion.toString() == "izquierda"){
            self.spawnAuto(new Automovil(position = self.inicioRandom(iniciosIzquierda), direccion = _direccion, tipo = self.tipoRamdom()))
        }
    }

    method avanzar(){
        autos.forEach({auto => auto.mover()})
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
        personaje.position(self.ramdom(),4)
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
            self.reasignarX(personaje, self.ramdom())
        }
    }

    method reasignarX(personaje, posicion){
        personaje.position().x(posicion)
    }
}