extends State

@export var animationTransition : AnimationPlayer
@export var nextState : String = "MainMenu"
var enteringfinished : bool = true
var isExiting : bool = false

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	if enteringfinished: #No ejecutes esto hasta que se haya preparado por completo el estado
		if(isExiting):
			print("exiting transition " + name)
			animationTransition.play_backwards("start_level")
			await animationTransition.animation_finished
			finished.emit(nextState)
		else:
			print("current state " + name)
			isExiting = Input.is_action_pressed("ui_accept");
	else:
		print("entering transition")
			
	pass


## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	visible = true
	$Transition.visible = true
	enteringfinished = false
	if animationTransition and animationTransition.has_animation("start_level"):
		animationTransition.play("start_level")
		for children  in get_children():
			children.visible = true
			pass
		await animationTransition.animation_finished
		enteringfinished = true
		isExiting = false
	else:
		print("Warning: animationTransition is null or 'start_level' doesn't exist")

	pass

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	visible = false
	print("exiting " + name)
	pass
