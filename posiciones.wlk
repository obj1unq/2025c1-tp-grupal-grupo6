
class Direccion{
    method nombre()
    method esLimite(position)
}
    
object arriba  inherits Direccion{
  method siguiente(position) = position.up(1)

  override method nombre() {
    return "Arriba"
  }

  override method esLimite(position){
    return position.y() >= game.height() -1
  }
}

object abajo  inherits Direccion{
  method siguiente(position) = position.down(1)

  override method nombre() {
    return "Abajo"
  }

  override method esLimite(position){
    return position.y() <= 0
  }
}

object derecha inherits Direccion {
  const property inicios = #{game.at(0,14), game.at(0,10), game.at(0,6)}
  
  method siguiente(position) = position.right(1)

  override method esLimite(position){
    return position.x() >= game.width()-1
  }

  override method nombre() {
    return "Derecha"
  }
}

object izquierda inherits Direccion {
  const property inicios = #{game.at(14,15), game.at(14,11), game.at(14,7)}

  method siguiente(position) = position.left(1)

  override method nombre() {
    return "Izquierda"
  }

  override method esLimite(position){
    return position.x() < 1
  }
}