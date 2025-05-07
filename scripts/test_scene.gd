extends CanvasLayer

signal success;
signal failed;

func _on_sucess_button_pressed() -> void:
	print("== Sucesso!")
	emit_signal("success")
	queue_free();


func _on_fail_button__pressed() -> void:
	print("== Falhou")
	emit_signal("failed")
	queue_free();
