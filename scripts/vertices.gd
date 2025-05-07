extends ColorRect

var inArea: bool = false;
var active: bool = true;
var used: bool = false
var tweenDuration: float = 0.2;
var tweenDurationTrack: float = 2.0;

@export var spawnScene: PackedScene;

func _ready() -> void:
	connect("mouse_entered", handleMouseEntered);
	connect("mouse_exited", handleMouseExited);
	
func _process(delta: float) -> void:
	if active and inArea and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		active = false;
		print("Spawnando cena...");
		get_tree().root.add_child(spawnScene.instantiate());
	
# Essa linha aqui serve pra fazer pra a "pista" ficar cinza depois de ser resolvida ">:)"
	if active == false and used == false:
		_fade_to_gray()
		used = true
		
func _fade_to_gray() -> void:
	var tween:= get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(self, "modulate", Color(0.35, 0.35, 0.35, 1), tweenDurationTrack)
	
func _fade_to_green() -> void:
	var tween:= get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(self, "modulate", Color(0.0, 10.6, 0.0, 1), tweenDurationTrack)
	
func handleMouseEntered() -> void:
	if active:
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
