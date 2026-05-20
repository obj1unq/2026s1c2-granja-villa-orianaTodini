import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
   var property monedas = 0
   var property  cosechas= []
	const property image = "fplayer.png"
   
   method mover(direccion) {
		const nuevaPosition = direccion.siguiente(position) 
		position = nuevaPosition 

   }
   method sembrar(cultivo){ 
      if(self.esParcelaVacia()){ 
          game.addVisual(cultivo)
	       cultivo.sembrada(self.position())
      }
   }

   method regar() {
	  self.validarQueHayCultivo()
     self.cultivosEnParcela().forEach({cultivo => cultivo.crecer()})
   }
   method validarQueHayCultivo() {
     if(self.esParcelaVacia()) {
        self.error("No hay nada para regar")
     }
   }
   method cosechar() {
	 self.validarQueHayCultivoParaCosechar()
    self.cosechasListasParaSerVendidas()
    self.cultivosCosechables()
   }
   method cultivosCosechables() {
      self.cosechas().forEach({cultivo => self.cosecharCultivo(cultivo)})
   }
   method cosechasListasParaSerVendidas() {
     cosechas= cosechas + self.cultivosEnParcela().filter({cultivo => cultivo.esCosechable()})
   }
   method cosecharCultivo(cultivo){
         cultivo.cosechar()
   }
   method validarQueHayCultivoParaCosechar() {
    if(!self.hayCultivoCosechableEnMiParcela()) {
        self.error("No tengo nada para cosechar")
    }
   }
   method hayCultivoCosechableEnMiParcela() {
      return self.cultivosEnParcela().any({cultivo => cultivo.esCosechable()})
   }
   method vender(){
      if(cosechas.isEmpty()){
         self.error("no tengo nada para vender")
      } else {
         monedas = monedas + cosechas.sum({cultivo => cultivo.costo()})
         cosechas.clear()
      }
   }
   method mostrarEstado() {
    return game.say(self,
        "tengo " + monedas.toString() +" monedas, y " + cosechas.size().toString() +
        " plantas para vender"
    )
}
   method cultivosEnParcela() {
    return game.getObjectsIn(self.position())
        .filter({objeto => objeto != self && objeto.esCultivo()})
}
   method esParcelaVacia(){
      return self.cultivosEnParcela().isEmpty()
   }
   method acciones(){
   keyboard.m().onPressDo({self.sembrar(new Maiz())}) 
   keyboard.t().onPressDo({self.sembrar(new Trigo()) })
	keyboard.o().onPressDo({self.sembrar(new Tomaco())})
	keyboard.r().onPressDo({self.regar()})
	keyboard.c().onPressDo({self.cosechar()})
   keyboard.v().onPressDo({self.vender()})
   keyboard.space().onPressDo({self.mostrarEstado()})
   }
}

