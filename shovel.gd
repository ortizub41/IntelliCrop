extends StaticBody2D

var selected = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		Global.toolselected = Global.tool_type.SHOVEL
		Global.plantselected = Global.seed_type.NONE
		selected = true

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			Global.toolselected = Global.tool_type.NONE
			selected = false
