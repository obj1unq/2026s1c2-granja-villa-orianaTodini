import wollok.game.*

class Maiz {

	var property position  
	var property estado = maizBebe
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "corn_baby.png"
	}
	method sembrar() {
	  
	}
	method cosechar(){

	}
	method crecer(){ 

	}
	method costo() {
	  
	}
}

class Trigo {
	var property position 
  method image(){
	return "wheat_0.png"
  }
  method sembrar() {
	  
	}
	method cosechar(){

	}
	method crecer(){ 

	}
	method costo() {
	  
	}
  
}

class Tomaco {
	var property position 
  method image() {
	return "tomaco_baby.png"
  }
  method sembrar() {
	  
	}
	method cosechar(){

	}
	method crecer(){ 

	}
	method costo() {
	  
	}    
  
}
object maizBebe{
  method esCosechable() {
	return false
  }
}
object maizAdulto {
  method esCosechable() {
	return true
  }
}

