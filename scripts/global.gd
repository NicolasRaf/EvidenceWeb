extends Node2D

@onready var CRT: CanvasLayer = get_tree().root.get_node("/root/CanvasCrt");

var scenesDict: Dictionary = {
	"main": preload("res://scenes/scene_main.tscn"),
	"puzzle": preload("res://Scenes/Mini-games/Descubra_Pistas.tscn")
}

# Função para a transição de saída
func transition_out(effect: SubViewportContainer) -> Tween:
	var _tween_out := get_tree().create_tween()
	_tween_out.parallel().tween_property(effect.material, 
		"shader_parameter/static_noise_intensity", 1.0, 2.0)
	_tween_out.parallel().tween_property(effect.material, 
		"shader_parameter/brightness", 0.0, 2.0)
	return _tween_out

# Função para a transição de entrada
func transition_in(effect: SubViewportContainer) -> Tween:
	var _tween_in := get_tree().create_tween()
	_tween_in.parallel().tween_property(effect.material,
		"shader_parameter/static_noise_intensity", 0.06, 2.0).set_delay(1)
	_tween_in.parallel().tween_property(effect.material,
		"shader_parameter/brightness", 1.4, 2.0).set_delay(1)
	return _tween_in

# Função principal para transição de cenas
func transToScene(sceneKey: String) -> void:
	if get_node_or_null("fadein"): return
	var effect: SubViewportContainer = CRT.get_node("EffectCRT")
	
	# Transição de saída
	var _tween_out := transition_out(effect)
	await _tween_out.finished

	# Referência à cena atual
	var current_scene = get_tree().current_scene
	var new_scene = scenesDict[sceneKey].instantiate() 	# Instancia nova cena
	
	##TODO: Tentar remover flick entre a transição
	current_scene.queue_free()	# Remove a antiga
	get_tree().root.add_child(new_scene) 	# Adiciona nova cena na árvore
	get_tree().current_scene = new_scene

	await get_tree().process_frame  # Garante que a nova cena entrou antes do tween final

	# Transição de entrada
	var _tween_in := transition_in(effect)
	await _tween_in.finished
