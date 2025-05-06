extends ColorRect

var inArea: bool = false;
var active: bool = true;
var tweenDuration: float = 0.2;

@export var spawnScene: PackedScene;

func _ready() -> void:
	connect("mouse_entered", handleMouseEntered);
	connect("mouse_exited", handleMouseExited);
	
func _process(delta: float) -> void:
	if active and inArea and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		active = false;
		print("Spawnando cena...");
		get_tree().root.add_child(spawnScene.instantiate());
		
func handleMouseEntered() -> void:
	var tween: Tween = get_tree().create_tween();
	tween.parallel().tween_property(self, "scale", Vector2(1.3, 1.3), tweenDuration);
	tween.parallel().tween_property(self, "color", Color(0.949,0.94,0.536, 1), tweenDuration);
	tween.set_trans(Tween.TRANS_SINE);
	
	inArea = true;

func handleMouseExited() -> void:
	var tween: Tween = get_tree().create_tween();
	tween.parallel().tween_property(self, "scale", Vector2(1, 1), tweenDuration);
	tween.parallel().tween_property(self, "color", Color(1,1,1,1), tweenDuration);
	tween.set_trans(Tween.TRANS_SINE);

	inArea = false;
