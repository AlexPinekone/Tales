extends State

@export var animationTransition : AnimationPlayer
@export var nextState : String = "MainMenu" #Siguiente estado al que se pasara, se puede actualizar en update
var enteringfinished : bool = true #
var isExiting : bool = false

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	if enteringfinished: #Ejecuta el codigo del estado actual una vez que se haya finalizado la animacion de transicion
		if(isExiting): #Si se activo la condicion de cambio de estado ejecutar transicion de cambio
			print("exiting transition " + name)
			animationTransition.play_backwards("start_level") #transicion de cambio o restart
			await animationTransition.animation_finished #Esperar a que la transicion acabe
			finished.emit(nextState) #cambiar al siguiente estado
		else: #Logica del estado actual va aqui
			print("current state " + name)
	else:
		print("entering transition")
			
	pass

func enter(previous_state_path: String, data := {}) -> void:
	enteringfinished = false
	if animationTransition and animationTransition.has_animation("start_level"):
		animationTransition.play("start_level")
		for children : Node2D in get_children(): #Hacer todos los nodos del estado acutal visible
			children.visible = true
			pass
		await animationTransition.animation_finished
		enteringfinished = true
		isExiting = false
	else:
		print("Warning: animationTransition is null or 'start_level' doesn't exist")

	pass

func exit() -> void:
	print("exiting " + name)
	for children : Node2D in get_children(): #Hacer invisibles todos los nodos del estado actual antes de pasar al siguiente estado
			children.visible = false
			pass
	pass
