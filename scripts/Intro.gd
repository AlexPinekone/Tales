extends State

@export var animationTransition : AnimationPlayer
@export var nextState : String = "MainMenu" #Siguiente estado al que se pasara, se puede actualizar en update
var currentDialogue : Label
var enteringfinished : bool = true #
var isExiting : bool = false
@onready var dialoge : Node2D = $Dialogues

var dialoguePos : Vector2
var t : float = 0.0;

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	#Logica que queramos ejecutar durante todo el tiempo independientemente si la transicion ya acabo o no
	dialoge.position.y = 550 + sin(t)*5.0
	t+=5.0 * _delta
	#######################################
	if enteringfinished: #Ejecuta el codigo del estado actual una vez que se haya finalizado la animacion de transicion
		if(isExiting): #Si se activo la condicion de cambio de estado ejecutar transicion de cambio
			print("exiting transition " + name)
			animationTransition.play_backwards("start_level") #transicion de cambio o restart
			await animationTransition.animation_finished #Esperar a que la transicion acabe
			finished.emit(nextState) #cambiar al siguiente estado
		else:
			isExiting = Input.is_action_pressed("ui_accept");
			print("current state " + name)
	else:
		print("entering transition")
			
	pass

func enter(previous_state_path: String, data := {}) -> void:
	var dialoguePos = dialoge.position
	enteringfinished = false
	visible = true
	currentDialogue = $Dialogues/Dialogue1 #Dialogo de escena
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
