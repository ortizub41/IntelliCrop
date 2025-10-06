extends Node2D

func _physics_process(delta: float) -> void:
	$oniontext.text = atr("= %.2f kg") % (Global.numofonions * Global.quality_score)
	$carrottext.text = atr("= %.2f kg") % (Global.numofcarrots * Global.quality_score)

func _on_menu_button_pressed() -> void:
	pass
