extends HSlider


func _on_value_changed(value: float) -> void:
	Global.evapo_transpiration = value
