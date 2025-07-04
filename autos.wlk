import wollok.game.*
import nivel.*
import objetos.*

class Automovil inherits Visual{
    var property position
    const direccion
    const tipo
    
    override method nombre(){
        return "auto" + tipo.caracteristica() + direccion.nombre()
    }

    method choque(){
        position.down(1)
    }

    method mover(){
        if(direccion.esLimite(position)){
            autoFactory.quitar(self)
        } else {
            position = direccion.siguiente(position)
        }
    }

    override method aplicarEfecto(personaje){
        tipo.aplicarEfecto(personaje)
    }
}

object autoFactory {
    //const property iniciosDerecha = #{game.at(0,14), game.at(0,10), game.at(0,6)}
    //const property iniciosIzquierda = #{game.at(14,15), game.at(14,11), game.at(14,7)}
    const property tipos = [amarillo, verde, negro, policia]
    const property autos = []
    
    method quitar(auto){
        game.removeVisual(auto)
        autos.remove(auto)
    }

    method spawnAuto(auto){
        autos.add(auto)
        game.addVisual(auto)
        alumno.redibujar()
    }

    method generarAutos(direccion) {
        self.spawnAuto(new Automovil(position = self.inicioRandom(direccion.inicios()), direccion = direccion, tipo = self.tipoRamdom()))
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
        personaje.choque()
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
        const ramdom = self.ramdom()
        if(personaje.position().x() + ramdom >= game.width()){
            self.reasignarX(personaje, 14)
        }else{
            self.reasignarX(personaje, ramdom)
        }
    }

    method reasignarX(personaje, posicion){
        const pos = personaje.position()
        personaje.position(posicion,pos.y())
    }
}