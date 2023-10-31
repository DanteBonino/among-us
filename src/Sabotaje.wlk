import Nave.*
import Excepciones.*

/* Punto 5 */

object reducirElOxigeno inherits Sabotaje{
	override method serRealizadoPor(unImpostor, unaVictima){
		if(self.validarPosibilidadDeLlevarACabo()){
			nave.reducirOxigenoEn(10)
			super(unImpostor, unaVictima)
		}
	}
	
	method validarPosibilidadDeLlevarACabo(){
		return nave.algunJugadorTieneUnTuboDeOxigeno()
	}
}

object impugnarAUnJugador inherits Sabotaje{
	override method serRealizadoPor(unImpostor, unaVictima){
		unaVictima.votarEnBlancoLaProximaVotacion()
		super(unImpostor, unaVictima)
	}
}

class Sabotaje{
	method serRealizadoPor(unImpostor, unaVictima){
		unImpostor.aumentarNivelDeSospechaEn(5)
	}
}