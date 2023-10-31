import Nave.*
import Excepciones.*

/* Punto 4 */
class Tarea{
	method serCompletadaPor(unJugador){
		self.validarQuePuedaCompletarla(unJugador)
		self.efectoFinal(unJugador)
	}
	
	method validarQuePuedaCompletarla(unJugador){
		if(not self.condicionParaCumplirla(unJugador)) throw new NoPudoRealizarLaTarea()
	}
	
	method efectoFinal(unJugador)
	
	method condicionParaCumplirla(unJugador)
}

class TareaQueRequiereHerramientas inherits Tarea{
	method herramientasNecesarias()
	
	override method condicionParaCumplirla(unJugador){
		return self.herramientasNecesarias().all{unaHerramienta => unJugador.tieneHerramienta(unaHerramienta)}
	}
	
	override method efectoFinal(unJugador){
		self.eliminarHerramientasUsadasPor(unJugador)
	}
	
	
	method eliminarHerramientasUsadasPor(unJugador){
		self.herramientasNecesarias().forEach{unaHerramienta => unJugador.eliminarHerramienta(unaHerramienta)}
	}
}

object arreglarTableroElectrico inherits TareaQueRequiereHerramientas{
	override method herramientasNecesarias () = ["llaveInglesa"]
	
	override method efectoFinal(unJugador){
		unJugador.aumentarNivelDeSospechaEn(10)
		super(unJugador)
	}
}


object sacarLaBasura inherits TareaQueRequiereHerramientas{
	override method herramientasNecesarias () = ["escoba", "bolsa"]
	
	override method efectoFinal(unJugador){
		unJugador.disminuirNivelDeSospechaEn(4)
		super(unJugador)
		/* La otra alternativa es usar template method */
	}
}

object ventilarLaNave inherits Tarea{
	override method condicionParaCumplirla(_unJugador) = true
	
	override method efectoFinal(_unJugador){
		nave.aumentarNivelDeOxigenoEn(5)
	}
}

