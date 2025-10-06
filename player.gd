extends CharacterBody2D
const LEFT = 'ui_left'
const RIGHT = 'ui_right'
const UP = 'ui_up'
const DOWN = 'ui_down'
const SIDE = 'sidewalk'
const WALK_DOWN = 'downwalk'
const WALK_UP = 'upwalk'

var speed = 50
var motion = Vector2.ZERO
	
func get_input():
	var input_direction = Input.get_vector(LEFT, RIGHT, UP, DOWN)
	velocity = input_direction * speed
	if Input.is_action_pressed(LEFT):
		_walk(SIDE)
	elif Input.is_action_pressed(RIGHT):
		_walk(SIDE, true)
	elif Input.is_action_pressed(UP):
		_walk(WALK_UP)
	elif Input.is_action_pressed(DOWN):
		_walk(WALK_DOWN)
	else:
		$AnimatedSprite2D.stop()

func _walk(direction, sideways=false):
	$AnimatedSprite2D.play(direction)
	$AnimatedSprite2D.flip_h = sideways

func _physics_process(delta):
	get_input()
	move_and_slide()
