extends Node2D

@onready var fadeIn = preload("res://scenes/fade_in_crv.tscn");

## It serves to call the transition
signal transitioned;

#battery level
var batteryValue: float = 1000.0
var canPause: bool

var scenesDict: Dictionary = {
}

func transToScene(sceneKey:String):
	if get_node("fadein") : return
	
	var _destinyScene = scenesDict.get(sceneKey)
	var _trans = fadeIn.instantiate()
	_trans.destinyScene = _destinyScene
	add_child(_trans)
	print("Transicionado para a Cena: ", sceneKey) 
