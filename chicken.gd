extends CharacterBody2D

var speed = 50
var motion = Vector2.ZERO

func _walk(direction, sideways = false):
	$AnimatedSprite2D.play(direction)
	$AnimatedSprite2D.flip_h = sideways
