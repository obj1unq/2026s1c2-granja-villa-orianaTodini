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
	  cultivo.sembrada(cultivo)
	  game.addVisual(cultivo)
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
   keyboard.m().onPressDo({self.sembrar(new Maiz(self.position))}) // PREGUNTAR
   keyboard.t().onPressDo { self.sembrar(new Trigo(self.position)) }
	keyboard.o().onPressDo({self.sembrar(new Tomaco(self.position))})
	keyboard.r().onPressDo({self.regar()})
	keyboard.c().onPressDo({self.cosechar()})
   }
}

