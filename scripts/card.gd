extends Node2D

@export var angle_x_max: float = 16.0
@export var angle_y_max: float = 16.0
@onready var sub_viewport_container: SubViewportContainer = $SubViewportContainer
var tween_hover: Tween
var size = Vector2(250,150)

func _ready() -> void:
	sub_viewport_container.material = sub_viewport_container.material.duplicate()

func _on_sub_viewport_container_gui_input(event: InputEvent) -> void:
	var mouse_pos: Vector2 = get_local_mouse_position()

	var lerp_val_x: float = remap(mouse_pos.x+size.x/2, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y+size.y/2, 0.0, size.y, 0, 1)
	#print("Lerp val x: ", lerp_val_x)
	#print("lerp val y: ", lerp_val_y)

	var rot_x: float = rad_to_deg(lerp_angle(angle_x_max, -angle_x_max, lerp_val_x))
	var rot_y: float = rad_to_deg(lerp_angle(angle_y_max, -angle_y_max, lerp_val_y))
	#print("Rot x: ", rot_x)
	#print("Rot y: ", rot_y)
	
	sub_viewport_container.material.set_shader_parameter("x_rot", rot_y)
	sub_viewport_container.material.set_shader_parameter("y_rot", rot_x)


func _on_sub_viewport_container_mouse_exited() -> void:
	rotation = deg_to_rad(0)
	#Reset shader
	sub_viewport_container.material.set_shader_parameter("x_rot", 0)
	sub_viewport_container.material.set_shader_parameter("y_rot", 0)
	# Reset scale
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2.ONE, 0.55)


func _on_sub_viewport_container_mouse_entered() -> void:
	rotation = deg_to_rad(180)
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(1.2, 1.2), 0.5)
