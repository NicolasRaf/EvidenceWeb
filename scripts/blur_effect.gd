extends Node2D

@onready var blur_viewport := $BlurViewport
@onready var blur_rect := $BlurCanvas/BlurRect

func _ready():
	blur_viewport.size = get_viewport().size
	blur_rect.texture = blur_viewport.get_texture()
