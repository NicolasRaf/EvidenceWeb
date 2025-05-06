extends ColorRect

var to_dentro: bool = false

func _process(delta: float) -> void:
	if to_dentro and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/vertice.tscn")

func _on_mouse_entered() -> void:
	to_dentro = true

func _on_mouse_exited() -> void:
	to_dentro = false
