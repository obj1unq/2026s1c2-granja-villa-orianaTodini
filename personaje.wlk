import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
   
   method mover(direccion) {
		const nuevaPosition = direccion.siguiente(position) 
		position = nuevaPosition 

   }
   method sembrar(){  
	
	 
   }
   method regar() {
	 
   }
   method cosechar() {
	 
   }
   method vender(){
	
   }
   method acciones(){ 
	//method cultivar(personaje){
	keyboard.m().onPressDo({self.sembrar(new Maiz(position=self.position()))})
	keyboard.t().onPressDo({self.sembrar(new Trigo(position=self.position()))})
	keyboard.o().onPressDo({self.sembrar(new Tomaco(position=self.position()))})

}}
