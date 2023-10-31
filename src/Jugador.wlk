import Excepciones.*
import Nave.*

class Jugador{
	var property nivelDeSospecha = 40
	const mochila = new List()
	var property estaEnLaNave = true
	
	/* Punto 1 */
	method esSospechoso(){
		return nivelDeSospecha > 50
	}
	
	/* Punto 2 */
	method buscar(unItem){
		mochila.add(unItem)
	}
	
	method completarAlgunaTarea()
	
	method aumentarNivelDeSospechaEn(unaCantidad){
		nivelDeSospecha += unaCantidad
	}
	
	method disminuirNivelDeSospechaEn(unaCantidad){
		nivelDeSospecha = 0.max(nivelDeSospecha - unaCantidad)
	}
	
	method tieneHerramienta(unaHerramienta){
		return mochila.contains(unaHerramienta)
	}
	/* Punto 6 -> De acá arranca */
	method llamarVotacionDeEmergencia(){
		nave.realizarVotacion()
	}
	
	method votar() // Depende de cada subclase
	
	method noTieneHerramientas() = mochila.isEmpty()
	
	method serEliminado(){
		estaEnLaNave = false
		if(self.noQuedanAliadosSuficientes()) throw self.perdimos()
	}
	
	method noQuedanAliadosSuficientes()
	
	method perdimos()
}

class Impostor inherits Jugador{
	/* Punto 3 */
	method completoTareas() = true
	
	/* Punto 4 */
	override method completarAlgunaTarea(){
		/* No hace nada */
	}
	
	method realizarSabotaje(unSabotaje){
		unSabotaje.serRealizadoPor(self)
	}
	
	override method votar(){
		return nave.algunJugador()
	}
	
	override method noQuedanAliadosSuficientes(){
		return not nave.quedaAlgunImpostor()
	}
	
	override method perdimos() = ganaronLosTripulantes
}

class Tripulante inherits Jugador{
	const property tareasPendientes = new Set()
	var estaImpugnado = false
	
	/* Punto 3 */
	method completoTareas() = tareasPendientes.isEmpty()
	
	/* Punto 4 */
	override method completarAlgunaTarea(){
		self.completar(tareasPendientes.anyOne())
		self.avisarNaveQueSeCompletoUnaTarea()
	}
	
	method completar(unaTarea){
		try{
			unaTarea.serCompletadaPor(self)
			self.eliminarTarea(unaTarea)
		}
		catch e : NoPudoRealizarLaTarea{
			/* Ver si tengo que avisar algo */
		}
	}
	
	method avisarNaveQueSeCompletoUnaTarea(){
		nave.chequearFinDeJuego()
	}
	
	method eliminarTarea(unaTarea){
		tareasPendientes.remove(unaTarea)
	}
	
	method eliminarHerramienta(unaHerramienta){
		mochila.remove(unaHerramienta)
	}
	
	/* Punto 6 */
	override method votar(){
		try{
			if(estaImpugnado) throw new EstaImpugnado()//Me pareció más fácil manejarlo con un booleano
			return self.votarSegun()
		}
		catch e : EstaImpugnado{
			estaImpugnado = false
			return blanco
		}
		
	}
	
	method votarSegun()
	
	override method noQuedanAliadosSuficientes(){
		return not nave.hayMasTripulantesQueAsesinos()
	}
	
	override method perdimos() = ganaronLosImpostores
}

/* Podría hacer una superclase y hacer un template method */

class TripulanteTroll inherits Tripulante{
	override method votarSegun(){
		return nave.algunJugadorQueNoSeaSospechoso()
	}
}

class TripulanteDetective inherits Tripulante{
	override method votarSegun(){
		return nave.elMasSospechoso()
	}
}

class TripulanteMaterialista inherits Tripulante{
	override method votarSegun(){
		return nave.algunoConMochilaVacia()
	}
}

object blanco{
	method serEliminado(){
		/*
		 * No hace nada
		 */
	}
}
