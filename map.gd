extends Node2D
var nodes_in_range = []

func _on_h_slider_value_changed(value: float) -> void:
	Global.snow = value

#func _ready():
	#connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	#connect("body_exited", Callable(self, "_on_Area2D_body_exited"))
#
#func _on_Area2D_body_entered(body):
	#nodes_in_range.append(body)
	#print("Node entered: ", body.name)
#
#func _on_Area2D_body_exited(body):
	#nodes_in_range.erase(body)
	#print("Node exited: ", body.name)
#
#func get_nodes_within_circle():
	#return nodes_in_range
