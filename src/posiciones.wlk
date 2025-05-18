object arriba {
  method siguiente(position) = position.up(1)

  method nombre() {
    return "arriba"
  }
}

object abajo {
  method siguiente(position) = position.down(1)

  method nombre() {
  return "abajo"
  }
}

object derecha {
  method siguiente(position) = position.right(1)

  method nombre() {
  return "derecha"
  }
}

object izquierda {
  method siguiente(position) = position.left(1)

  method nombre() {
  return "izquierda"
  }
}