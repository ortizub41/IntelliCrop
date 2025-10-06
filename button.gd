extends Button

@onready var menu:= preload("res://main_menu.tscn").instantiate()

func _ready():
	add_child(menu)
	menu.hide()

func _on_environmental_factor_pressed() -> void:
	menu.show()
