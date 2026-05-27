 import wollok.game.*
import personaje.*
import mercado.*
class Maiz {

	var property position 
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
	method esMercado(){
		return false
	}
}

class Trigo {
	var property position 
	var property estado = 0
  method image(){
	return "wheat_" + estado + ".png"
  }
	method cosechar(){
		if(estado >= 2){
			game.removeVisual(self)
		}
	}
	method sembrada(posicion) {
		position = posicion
	}
	method crecer(){ 
		if(estado == 3){
			estado = 0
		} else {
			estado = estado + 1
		}

	}
	method costo() {
	  return (estado - 1 )* 100
	}
	method esCultivo() {
		return true
	}
	method esCosechable() {
	  return estado >= 2
	}
	method esMercado(){
		return false
	}
  
}

class Tomaco {
	var property position 	
	var property estado = tomacoBebe
    method image() {
	    return estado.image()
    }
	method cosechar(){
		game.removeVisual(self)
	}
	method sembrada(posicion) {
		position = posicion
	}
	method crecer() {
	    self.hacerMaduro() 
	}
	method cambiarImagen(_nuevaImagen) {
		estado = _nuevaImagen
	}
	method hacerMaduro() {
        if (self.estaAlBordeSuperior()) {
			self.replantarEnElBordeInferior()
        } else {
           self.replantarTomacoUnaParcelaArriba()
        }
    }
    method estaAlBordeSuperior(){
	    return self.position().y() == game.height() - 1
    }
    method replantarEnElBordeInferior(){
	    self.position(game.at(self.position().x(), 0))
	    self.validarSiEsParcelaVacia()
		self.cambiarImagen(tomacoAdulto)
    }
    method replantarTomacoUnaParcelaArriba(){
	    self.position(self.position().up(1))
	    self.cambiarImagen(tomacoAdulto)
    }
    method validarSiEsParcelaVacia(){
        if (!self.cultivosEnParcela().isEmpty()) {
            personaje.error("Hay un cultivo plantado en la parte inferior")
        }
    
	}
    method cultivosEnParcela() {
        return game.getObjectsIn(self.position()).filter({objeto => objeto != self && objeto.esCultivo()})
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
	method esMercado(){
		return false
	}
  
}
object tomacoBebe{
	  method image() {
	return "tomaco_baby.png"
  }
  method esCosechable() {
	return false
  }
}
object tomacoAdulto {
  method image() {
	return "tomaco.png"
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

