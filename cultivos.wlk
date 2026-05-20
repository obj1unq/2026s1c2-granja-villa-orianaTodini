 import wollok.game.*
import personaje.*

class Maiz {

	var property position 
	var property estado = maizBebe
	var property imagen = maizBebe.image()
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return imagen
	}
	method sembrada(posicion) {
		position = posicion
	}
	method cosechar(){
		if(estado.esCosechable()){
			game.removeVisual(self.image())
		}
	}
	method crecer(){ 
		if(estado.maizBebe()){
			estado= maizAdulto
		} else {
			estado= maizAdulto 
		}

	}
	method costo() {
	  
	}
	method esCultivo() {
		return true
	}
}

class Trigo {
	var property position 
	var property evolucion = 0
  method image(){
	return "wheat_+evolucion+.png"
  }
	method cosechar(){
		if(evolucion >= 2){
			game.removeVisual(self.image())
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
	  
	}
	method esCultivo() {
		return true
	}
  
}

class Tomaco {
	var property position 
  method image() {
	return "tomaco_baby.png"
  }
	method cosechar(){
		game.addVisual(self.image())
	}
	method sembrada(posicion) {
		position = posicion
	}
	method crecer() {
   if(position.y() != 10) {
      position = position.y(game.height() - 1)
   } else {
      position = position.up(1)
   }
}
	method costo() {
	  
	} 
	method esCultivo() {
		return true
	}
  
}
object maizBebe{
  method esCosechable() {
	return false
  }
  method image() {
	return "maiz_bebe.png"
  }
}
object maizAdulto {
  method esCosechable() {
	return true
  }
  method image() {
	return "maiz_adulto.png"
  }
}

