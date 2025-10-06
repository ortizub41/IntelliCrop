extends StaticBody2D

var selected = false

@onready var layer1: Area2D = $Area2D
@onready var layer2: Area2D = $Area2D2

func _ready():
	$AnimatedSprite2D.play("default")
	layer1.area_entered.connect(_on_layer1_area_entered)

func _on_layer1_area_entered(area: Area2D) -> void:
	pass
	#print("Layer1")

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		if not Global.toolselected:
			Global.plantselected = Global.seed_type.CARROT
		else:
			Global.toolselected = Global.seed_type.NONE
		selected = true
	if Input.is_action_just_released("click"):
		Global.plantselected = Global.seed_type.NONE
		selected = false

func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
