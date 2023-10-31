import Excepciones.*
import Jugador.*

object nave{
	var property nivelDeOxigeno = 100
	const jugadores = new Set()
	
	/* Punto 4 */
	method aumentarNivelDeOxigenoEn(unaCantidad){
		self.modificarNivelDeOxigeno(unaCantidad)
	}
	
	method chequearFinDeJuego(){
		if(self.jugadoresCompletaronTodasLasTareas()) throw ganaronLosTripulantes
	}
	
	method jugadoresCompletaronTodasLasTareas(){
		return jugadores.all{unJugador=> unJugador.completoTareas()}
	}
	
	method agregarJugador(unJugador){
		jugadores.add(unJugador)
	}
  
    /* Punto 5 */
	method reducirOxigenoEn(unaCantidad){
		if(nivelDeOxigeno <= unaCantidad) throw ganaronLosImpostores
		self.modificarNivelDeOxigeno(-unaCantidad)
	}
	
	method modificarNivelDeOxigeno(unaCantidad){
		nivelDeOxigeno += unaCantidad
	}
	
	method algunJugadorTieneUnTuboDeOxigeno(){
		return jugadores.any{unJugador=> unJugador.tieneHerramienta("tuboDeOxigeno")}
	}
	
	/* Punto 6 */
	method realizarVotacion(){
		const votos = self.jugadoresEnLaNave().map{unJugador => unJugador.votar()} //Cada voto devuelve unJugador en la nave o blanco
		self.eliminarJugador(self.elQueMasVotosTiene(votos))
	}
	
	method elQueMasVotosTiene(unosVotos){
		return jugadores.max{unJugador => unosVotos.occurrencesOf(unJugador)}
	}
	
	method eliminarJugador(unJugador){
		unJugador.serEliminado()
	}
	
	method algunJugador(){
		return self.jugadoresEnLaNave().anyOne()
	}
	
	method jugadoresEnLaNave(){
		return jugadores.filter{unJugador => unJugador.estaEnLaNave()}
	}
	
	method algunJugadorQueNoSeaSospechoso(){
		return self.jugadoresEnLaNave().findOrDefault({unJugador => not unJugador.esSospechoso()}, blanco)
	}
	
	method elMasSospechoso(){
		return self.jugadoresEnLaNave().max{unJugador => unJugador.nivelDeSospecha()}
	}
	
	method algunoConMochilaVacia(){
		return self.jugadoresEnLaNave().findOrDefualt({unJugador => unJugador.noTieneHerramientas()}, blanco)
	}
	
	method algunJugadorCumpleCriterioSegun(unVotante){/* Se podría usar para que no se repita tanto el findOrDefault, pero implicaría ir y volver */
		return self.jugadoresEnLaNave().findOrDefualt({unJugador => unVotante.cumpleCriterio(unJugador)}, blanco)
	}
	
	method quedaAlgunImpostor() = self.jugadoresEnLaNave().any{unJugador => unJugador.esImpostor()}
	
	method hayMasTripulantesQueAsesinos() = self.cantidadTripulantes() > self.cantidadImpostores()
	
	method cantidadTripulantes() = self.jugadoresEnLaNave().count{unJugador => not unJugador.esImpostor()}
	
	method cantidadImpostores() = self.jugadoresEnLaNave() - self.cantidadTripulantes()
}
