import tablero.*
import posiciones.*

class Automovil inherits Visual{

  var property position
  //const property image = ""
  const property sentido = #{sentidoDerecha, sentidoIzquierdo}.anyOne()  //en direccion derecha o izquierda

  method aparecerEnInicioCalle(){

  }

  
  //method sentidoCirculacion()
 // method choque()

  method advertencia() = "correte, que te choco"

  //method efecto()
  //method aplicarEfectO()


  
}

object sentidoDerecha{

   const property iniciosDeCalle = #{game.at(0,6),game.at(0,7),game.at(0,10),game.at(0,11),game.at(0,14),game.at(0,15)}

}

object sentidoIzquierdo{
    const property iniciosDeCalle = #{game.at(14,6),game.at(14,7),game.at(14,10),game.at(14,11),game.at(14,14),game.at(14,15)}
    
}

/*
class AutoFactory{
    
    method crearAutoHaciaDerecha(){
        return new Automovil(position = ))
    }
    
    method crearAutoHaciaIzquierda(){
        return new Automovil(position = )
    }
}


object autos{

}
*/