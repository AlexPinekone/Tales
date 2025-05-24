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
		else:

			print("current state " + name)
	else:
		print("entering transition")
			
	pass

func enter(previous_state_path: String, data := {}) -> void:
	enteringfinished = false
	visible = true
	$Transition.visible = true
	if animationTransition and animationTransition.has_animation("start_level"):
		animationTransition.play("start_level")
		await animationTransition.animation_finished
		enteringfinished = true
		isExiting = false
	else:
		print("Warning: animationTransition is null or 'start_level' doesn't exist")

	pass

func exit() -> void:
	print("exiting " + name)
	visible = false
	pass
