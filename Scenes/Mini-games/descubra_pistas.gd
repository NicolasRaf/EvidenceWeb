extends CanvasLayer

func _ready():
	pass
	
func mudandoCursor(caminho):
	var textura_original = load(caminho)
	var imagem = textura_original.get_image()
	imagem.resize(32, 32, Image.INTERPOLATE_LANCZOS)  # redimensiona a imagem diretamente
	var textura_nova = ImageTexture.create_from_image(imagem)
	Input.set_custom_mouse_cursor(textura_nova)

func _on_area_2d_mouse_entered() -> void:
	mudandoCursor("res://assets/UI/lupa-removebg-preview.png")
	
func _on_area_2d_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(null)
