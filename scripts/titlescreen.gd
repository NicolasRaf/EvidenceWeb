extends Control

@onready var button: TextureButton = get_node("Button");
var buttonYStartPosition: float;

func _ready() -> void:
	buttonYStartPosition = button.position.y;
	
	button.connect("pressed", func(): get_tree().change_scene_to_file("res://scenes/scene_main.tscn"));
	button.pivot_offset = Vector2(button.size.x/2, button.size.y/2)

func _buttonExited() -> void:
	var _tween: Tween = get_tree().create_tween();
	
	_tween.parallel().tween_property(button, "scale", Vector2(1, 1), 0.3);
	_tween.set_trans(Tween.TRANS_SPRING);
	_tween.parallel().tween_property(button, "position:y", buttonYStartPosition, 0.5);
	
func _buttonEntered() -> void:
	var _tween: Tween = get_tree().create_tween();
	var yOffset: int = 30;
	
	_tween.parallel().tween_property(button, "scale", Vector2(1.05, 1.05), 0.3);
	_tween.set_trans(Tween.TRANS_SPRING);
	_tween.parallel().tween_property(button, "position:y", buttonYStartPosition - yOffset, 0.5);
	
