extends Control

func _ready() -> void:
	$Button.connect("pressed", func(): get_tree().change_scene_to_file("res://scenes/scene_main.tscn"));

func _buttonExited() -> void:
	var tween: Tween = get_tree().create_tween();
	tween.parallel().tween_property($Button, "scale", Vector2(1, 1), 0.3);

func _buttonEntered() -> void:
	var tween: Tween = get_tree().create_tween();
	tween.parallel().tween_property($Button, "scale", Vector2(1.1, 1.1), 0.3);
