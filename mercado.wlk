import wollok.game.game
import direcciones.*
import personaje.*
import cultivos.*

class Mercado {
    var property position 
    var property cantidadDeMonedas = 1000
    var property mercaderiaComprada = []
    method image(){
        return "market.png"
    }
    method inventario(){
        return mercaderiaComprada
    }
    method esMercado(){
        return true
    }
    method comprar(cultivos,monto){
        self.validarSiHaySuficienteDineroParaComprar(monto)
        cantidadDeMonedas = cantidadDeMonedas - monto
        mercaderiaComprada.addAll(cultivos)
    }
    method validarSiHaySuficienteDineroParaComprar(monto) {
       if (!self.puedeComprar(monto)) {
         self.error("No tienes suficiente dinero para comprar tus cosechas")
       }
    }
    method puedeComprar(precio){
        return cantidadDeMonedas >= precio
    }
}

