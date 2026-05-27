import wollok.game.*
import cultivos.*
import direcciones.*
import mercado.*
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
      self.validarSiEsParcelaVacia()
          game.addVisual(cultivo)
      }
   method validarSiEsParcelaVacia(){
      return self.cultivosEnParcela().isEmpty()
   }
   

   method regar() {
	  self.validarSiEsParcelaVacia()
     self.cultivosEnParcela().forEach({cultivo => cultivo.crecer()})
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
         self.validarSiHayCosechas()
         self.validarSiHayMercado()
         self.valorDeCosechas()
         self.venderCosechasAlMercado()
   }
   method validarSiHayCosechas() {
      if(self.cosechas().isEmpty()) {
         self.error("No tengo nada para vender")
      }
   }
      method valorDeCosechas(){
       monedas = monedas + cosechas.sum({cultivo => cultivo.costo()})
   }
      method venderCosechasAlMercado() {
         const mercado= game.uniqueCollider(self)
            mercado.comprar(cosechas,monedas)
            cosechas.clear()
   }
   method validarSiHayMercado(){
     return game.getObjectsIn(self.position()).find({objeto => objeto.esMercado()})
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
   method activar(objeto){
      objeto.activar()
   }
   method esCultivo() {
      return false
   }
   method esMercado(){
      return false
   }
   method acciones(){
   keyboard.m().onPressDo({self.sembrar(new Maiz(position= self.position()))}) 
   keyboard.t().onPressDo({self.sembrar(new Trigo(position= self.position())) })
	keyboard.o().onPressDo({self.sembrar(new Tomaco(position= self.position()))})
	keyboard.r().onPressDo({self.regar()})
	keyboard.c().onPressDo({self.cosechar()})
   keyboard.v().onPressDo({self.vender()})
   keyboard.space().onPressDo({self.mostrarEstado()})
   keyboard.a().onPressDo({self.activar(new Aspersor(position= self.position()))})
   }
}
class Aspersor{ 
   var property position 
   var property posicionesLimitrofes =[
   position.up(2),
   position.down(2),
   position.left(2),
   position.right(2)
]
   const property image = "aspersor.png"
   method estaActivado(){
      return true
   }
   method activar(){
      game.addVisual(self)
      self.regarCultivosAlrededor()
   }
   method regarCultivosAlrededor(){
      game.onTick(1000, "Regar las plantas ", {self.regarCultivos()}) 
   }
   method regarCultivos(){
      self.cultivosAlrededor().forEach({cultivo => cultivo.crecer()}) // Para cada cultivo que hay alrededor, lo hago crecer.
   }
   method cultivosAlrededor(){
     return self.posicionesLimitrofes().flatMap({posicion => self.cultivosEnPosicion(posicion)}) // Agarro todas las posiciones de alrededor, busco los cultivos que hay en cada una y junto todo en una sola lista.
   }
   method cultivosEnPosicion(posicion){
      return game.getObjectsIn(posicion).filter({objeto => objeto.esCultivo()}) // Busco todos los objetos que hay en esa posición y me quedo solamente con los cultivos.
   }
   method esCultivo() {
      return false
   }
}
