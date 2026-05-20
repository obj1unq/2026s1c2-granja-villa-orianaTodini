 import wollok.game.*
import personaje.*

class Maiz {

	var property position = personaje.position()
	var property estado = maizBebe
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return estado.image()
	}
	method sembrada(posicion) {
		position = posicion
	}
	method cosechar(){
		if(self.esCosechable()){
			game.removeVisual(self)
		}
	}
	method crecer(){ 
		self.cambiarEstado(maizAdulto)
		} 
	method cambiarEstado(_nuevoEstado){
		estado = _nuevoEstado
	}
	method costo() {
	  return 150
	}
	method esCultivo() {
		return true
	}
	method esCosechable() {
	  return estado.esCosechable()
	}
}

class Trigo {
	var property position = personaje.position()
	var property evolucion = 0
  method image(){
	return "wheat_" + evolucion + ".png"
  }
	method cosechar(){
		if(evolucion >= 2){
			game.removeVisual(self)
		}
	}
	method sembrada(posicion) {
		position = posicion
	}
	method crecer(){ 
		if(evolucion == 3){
			evolucion = 0
		} else {
			evolucion = evolucion + 1
		}

	}
	method costo() {
	  return (evolucion - 1 )* 100
	}
	method esCultivo() {
		return true
	}
	method esCosechable() {
	  return evolucion >= 2
	}
  
}

class Tomaco {
	var property position = personaje.position()
  method image() {
	return "tomaco_baby.png"
  }
	method cosechar(){
		game.removeVisual(self)
	}
	method sembrada(posicion) {
		position = posicion
	}
	method crecer() {
   if(position.y() == game.height()) {
    position = position.y(0) // COMO HACERLOOOOOOOOOOOOOOO.
   } else {
      position = position.up(1)
   }
}
	method costo() {
	  return 80
	} 
	method esCultivo() {
		return true
	}
	method esCosechable() {
	  return true
	}
  
}
object maizBebe{
  method esCosechable() {
	return false
  }
  method image() {
	return "corn_baby.png"
  }
}

object maizAdulto {
  method esCosechable() {
	return true
  }
  method image() {
	return "corn_adult.png"
  }
}

