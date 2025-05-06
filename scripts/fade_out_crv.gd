extends CanvasLayer

var transitionDuration: float = 2.5;

func _ready() -> void:
	var _tween: Tween = get_tree().create_tween();
	
	_tween.tween_property( $ColorRect.material,"shader_parameter/static_noise_intensity", 0, transitionDuration)
