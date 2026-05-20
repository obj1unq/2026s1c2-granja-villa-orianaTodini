import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
   
   method mover(direccion) {
		const nuevaPosition = direccion.siguiente(position) 
		position = nuevaPosition 

   }
   method sembrar(cultivo){ 
      if(! self.hayCultivoPlantadoAca()){ 
	  cultivo.sembrada(cultivo)
	  game.addVisual(cultivo)
      }
   }
   method hayCultivoPlantadoAca() {
     return game.getObjectsIn(personaje.position).isEmpty() // Arreglar
   }

   method regar() {
	  self.validarQueHayCultivo()
     self.cultivosEnMiParcela().forEach({cultivo => cultivo.crecer()})
   }
   method validarQueHayCultivo() {
     if(!self.hayCultivoEnMiParcela()) {
        self.error("No hay cultivo en mi parcela")
     }
   }
   method cosechar() {
	 
   }
   method vender(){
	
   }
   method cultivosEnMiParcela(){
      return game.getObjectsIn(position)
   }
   method hayCultivoEnMiParcela(){
      return self.cultivosEnMiParcela().any({elemento => elemento.esCultivo()})
   }
   method acciones(){
   keyboard.m().onPressDo({self.sembrar(new Maiz(position= position))}) 
   keyboard.t().onPressDo {self.sembrar(new Trigo(position=position)) }
	keyboard.o().onPressDo({self.sembrar(new Tomaco(position= position))})
	keyboard.r().onPressDo({self.regar()})
	keyboard.c().onPressDo({self.cosechar()})
   }
}

