extends CanvasLayer
func _on_texture_rect_pressed() -> void:
	print("Puzzle Resolvido");
	queue_free();
