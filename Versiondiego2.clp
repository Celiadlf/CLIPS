(defclass Jugador
	(is-a USER)
	(slot id (type SYMBOL) (allowed-values J1 J2 J3 J4))
	;X que no poner dinero como numero y ya x que al final pueden tener la suma de estos
	(slot sestercios (type INTEGER))
	;El jugador empieza la partida con 7 cartas en la mano 
	;Hay que hacer de alguna manera que tenga más d euna a la vez puede ser con boolean
    ;Se queda esto como si o no ya que la puedes usar cuando usas una carta de prefecto
	(slot tiene-PM (type SYMBOL) (allowed-values SI NO) (default NO))
	(slot puntos (type INTEGER) (default 0))
	;Anadi esto es el numero de casas que le quedan al jugador por colocar
	(slot casas (type INTEGER) (range 0 15) (default 15))
	(slot colonos-tierra (type INTEGER) (allowed-values 0 1 2 3) (default 2))
	(slot colonos-mar (type INTEGER) (allowed-values 0 1 2 3) (default 2))
    (slot repartido (type SYMBOL) (allowed-values SI NO) (default NO))
	)

(defclass Carta
	(is-a USER)
	(slot id (type SYMBOL)(allowed-values T1 T2 T3 T4 T5 T6 T7 J1 J2 J3 J4 D1 D2 D3 D4 F)) ; Indica donde este es (T1,T2..) para posiciones tablero, (J1,J2,J3,J4) para un jugador , (D1, D2,D3,D4) para pilas de descartes de jugadores y (F) para fuera del tablero
	(slot tipo (type SYMBOL) (allowed-values tribuno arquitecto colonizador prefecto mercader diplomatico senador consul albañil granjero herrero vinatero tejedor ));LOS ESPECIALISTAS SON LAS 5 ULTIMAS ES UNA TONTERIA HACER APARTE
    ;hace falta poner acciones???
    ;(slot acciones (type SYMBOL)); hay que meter las acciones pero no se si como una regla o full con instancias 
    (slot dios (type SYMBOL) (allowed-values vesta jupiter saturno mercurio marte minerva));realmente no hace falta porque con el tipo de carta se sabe el dios pero lo dejo para saberlo 
    (slot precio1 (type SYMBOL) (allowed-values ladrillo comida herramienta vino tela nada)(default nada));Lo que cuesta en la carta comprarla en el caso de que este a la venta en el tablero
    (slot precio2 (type SYMBOL) (allowed-values ladrillo comida herramienta vino tela nada)(default nada))
    )

(defclass Recursos
	(is-a USER)
	(slot id (type SYMBOL) (allowed-values J1 J2 J3 J4)) ;id jugador que tiene los recursos 
	(slot tipo (type SYMBOL) (allowed-values ladrillo comida herramienta vino tela nada))
    (slot numero_tipo (type INTEGER))
    )
(defclass Colonos
	(is-a USER)
	(slot id (type SYMBOL) (allowed-values J1 J2 J3 J4))
	(slot tipo (type SYMBOL) (allowed-values mar tierra ))
	(slot posicion (type SYMBOL) (default roma))
    (slot tablero (type SYMBOL) (allowed-values SI NO) (default NO))
    )

;Esto se me ha ocurrido para representar todas las posiciones a la venta del tablero, su precio se sumara al de la carta en los casos necesarios. 
;Creo que es más facil crear una instancia de esta clase por posicion de venta e ir cammbiandola con semaforos, lo unico que la que pilla para ultima posición creo que será random 

(defclass Tablero_venta
	(is-a USER)
	(slot id (type SYMBOL) (allowed-values T1 T2 T3 T4 T5 T6 T7 )); posicion en el tablero 
	(slot precio1 (type SYMBOL) (allowed-values cualquiera tela nada)(default nada)) ; no se muy bien como implementar lo de que el precio sea cualquiera
    (slot precio2 (type SYMBOL) (allowed-values tela nada)(default nada))
    )

(definstances inicio
    ;Jugadores
    ([J1] of Jugador (id J1) (sestercios 5))
    ([J2] of Jugador (id J2) (sestercios 6)(tiene-PM SI))
    ;cartas iniciales
    ([C1] of Carta (id J1)(tipo tribuno)(dios marte))
    ([C2] of Carta (id J1)(tipo arquitecto)(dios jupiter))
    ([C3] of Carta (id J1)(tipo prefecto)(dios saturno))
    ([C4] of Carta (id J1)(tipo prefecto)(dios saturno))
    ([C5] of Carta (id J1)(tipo mercader)(dios mercurio))
    ([C6] of Carta (id J1)(tipo diplomatico)(dios jupiter))
    ([C7] of Carta (id J1)(tipo senador)(dios vesta))
    ;cartas iniciales j2
    ([C8] of Carta (id J2)(tipo tribuno)(dios marte))
    ([C9] of Carta (id J2)(tipo arquitecto)(dios jupiter))
    ([C10] of Carta (id J2)(tipo prefecto)(dios saturno))
    ([C11] of Carta (id J2)(tipo prefecto)(dios saturno))
    ([C12] of Carta (id J2)(tipo mercader)(dios mercurio))
    ([C13] of Carta (id J2)(tipo diplomatico)(dios jupiter))
    ([C14] of Carta (id J2)(tipo senador)(dios vesta))
    ;Recurso del J1 1
    ([R1T1] of Recursos (id J1)(tipo ladrillo)(numero_tipo 1)) 
    ([R1T2] of Recursos (id J1)(tipo comida)(numero_tipo 2))
    ([R1T3] of Recursos (id J1)(tipo herramienta)(numero_tipo 1)) 
    ([R1T4] of Recursos (id J1)(tipo vino)(numero_tipo 1))
    ([R1T5] of Recursos (id J1)(tipo tela)(numero_tipo 1)) 
    ([R1T6] of Recursos (id J1)(tipo nada)(numero_tipo 100000)) ;Recurso auxiliar, esto se una para comprar cosas que no tienen precio en alguna casilla, el numero es tan alto para que siempre se pueda
    ;Recurso del J2
    ([R12T1] of Recursos (id J2)(tipo ladrillo)(numero_tipo 1)) 
    ([R2T2] of Recursos (id J2)(tipo comida)(numero_tipo 2))
    ([R2T3] of Recursos (id J2)(tipo herramienta)(numero_tipo 1)) 
    ([R2T4] of Recursos (id J2)(tipo vino)(numero_tipo 1))
    ([R2T6] of Recursos (id J2)(tipo nada)(numero_tipo 100000)) ;Recurso auxiliar, esto se una para comprar cosas que no tienen precio en alguna casilla, el numero es tan alto para que siempre se pueda
    ;Colonos J1
    ([J1C1] of Colonos (id J1)(tipo tierra)(tablero SI))
    ([J1C2] of Colonos (id J1)(tipo tierra))
    ([J1C3] of Colonos (id J1)(tipo tierra))
    ([J1C4] of Colonos (id J1)(tipo mar)(tablero SI))
    ([J1C5] of Colonos (id J1)(tipo mar))
    ([J1C6] of Colonos (id J1)(tipo mar))
    ;Colonos J2
    ([J2C1] of Colonos (id J2)(tipo tierra)(tablero SI))
    ([J2C2] of Colonos (id J2)(tipo tierra))
    ([J2C3] of Colonos (id J2)(tipo tierra))
    ([J2C4] of Colonos (id J2)(tipo mar)(tablero SI))
    ([J2C5] of Colonos (id J2)(tipo mar))
    ([J2C6] of Colonos (id J2)(tipo mar))
    ;Inicializo los huecos en el tablero, luego a estos les asigno unas cartas por medio del id
    ([T1] of Tablero_venta (id T1)(precio1 nada)(precio1 nada))
    ([T2] of Tablero_venta (id T2)(precio1 cualquiera)(precio1 nada))
    ([T3] of Tablero_venta (id T3)(precio1 cualquiera)(precio1 nada))
    ([T4] of Tablero_venta (id T4)(precio1 tela)(precio1 nada))
    ([T5] of Tablero_venta (id T5)(precio1 tela)(precio1 nada))
    ([T6] of Tablero_venta (id T6)(precio1 cualquiera)(precio1 tela))
    ([T7] of Tablero_venta (id T7)(precio1 tela)(precio1 tela))
    ;Inicializo las cartas que van en cada posicion del tablero, estas las he sacado de un ejemplo 
    ([C15] of Carta (id T1)(tipo diplomatico)(dios jupiter)(precio1 herramienta))
    ([C16] of Carta (id T2)(tipo herrero)(dios minerva)(precio1 ladrillo)(precio2 herramienta))
    ([C17] of Carta (id T3)(tipo granjero)(dios minerva)(precio1 ladrillo)(precio2 comida))
    ([C18] of Carta (id T4)(tipo albañil)(dios minerva)(precio1 comida))
    ([C19] of Carta (id T5)(tipo colonizador)(dios marte)(precio1 comida))
    ([C20] of Carta (id T6)(tipo mercader)(dios mercurio)(precio1 vino))
    ([C21] of Carta (id T7)(tipo prefecto)(dios saturno)(precio1 vino))
    ;Inicializo un par de cartas extra que estarian en el mazo de robar, la idea es que se coloquen en el tablero despues de que compren una de las del tablero
    ([C22] of Carta (id F)(tipo tribuno)(dios marte))
    ([C23] of Carta (id F)(tipo prefecto)(dios saturno)(precio1 vino))
    )

;Este lo uso como semaforo para cuando se compre una carta del tablero, aun que se tendria que ajustar a cual compraran 
(deffacts hechos-iniciales 
    (posicion_primera T1)
    (siguiente T1 T2)
    (siguiente T2 T3)
    (siguiente T3 T4)
    (siguiente T4 T5)
    (siguiente T5 T6)
    (siguiente T6 T7)
    (turno J1 )
    (turno_siguiente J1 J2)
    (turno_siguiente J2 J1)
)

;Regla de ejemplo, en esta sera la de la carta SENADOR, la regla NO es correcta porque voy a poner que tan solo compre una carta y que esta sea la de la posición T4 
;es simplemente un ejemplo para que se vea como funcionaria el comprar cartas y el sustituir esa carta en el tablero
;luego habria que hacerlo para que se ajuste bien a la regla y para que pueda ser con cualquier carta

(defrule carta-senador
    ;aqui seleccionamos al jugador del turno que toca, se empieza por el 1  pero irá cambiando
	?turn <- (turno ?idj)
    (turno_siguiente ?idj ?idJ2)
    ;vemos si tiene una carta tipo senador
    ?c <- (Carta (id ?idj) (tipo senador))
    ;selecciono la carta 4 del tablero pero da igual cual fuera, esto es solo un ejemplo 
    ?cv <- (Carta (id T4) (precio1 ?p1 ) (precio2 ?p2))
    ?t <- (Tablero(id T4) (precio1 ?pp1 ) (precio2 ?pp2))
    ;ver los recurson del jugador que coinciden con estos precios
    ?r1 <- (Recursos (id ?idj) (tipo ?p1)(numero_tipo ?np1))
    ?r2 <- (Recursos (id ?idj) (tipo ?p2)(numero_tipo ?np2))
    ?r3 <- (Recursos (id ?idj) (tipo ?pp1)(numero_tipo ?np3))
    ?r4 <- (Recursos (id ?idj) (tipo ?pp2)(numero_tipo ?np4))
    ;el problema que veo en estos es cuando se repita el recurso en precio como hacer la comprobacion, porque seria -2 y no -1 como es aqui
    (test (>= (- ?np1 1 ) 0))
    (test (>= (- ?np2 1 ) 0))
    (test (>= (- ?np3 1 ) 0))
    (test (>= (- ?np4 1 ) 0))
    =>
    ;cambiamos de turno
    (retract ?turn)

    (assert (turno ?idj2))
    ;restamos 1 a los recursos usados, en el caso de no ser nada se le resta a nada
    (modify ?r1 (numero_tipo (- ?np1 1)))
    (modify ?r2(numero_tipo (- ?np2 1)))
    (modify ?r3 (numero_tipo (- ?np3 1)))
    (modify ?r4 (numero_tipo (- ?np4 1)))
    ;asignamos carta al jugador
    (modify ?cv (id ?idj))
)
