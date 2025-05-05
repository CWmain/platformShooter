extends Node
class_name State

signal tranistion(from: State, to: State)

@export var player: Player

func enter()->void:
	printerr("Enter not implemented")
	
func update(delta: float)->void:
	printerr("%s update not implemented" % name)

func physics_update(delta: float) -> void:
	printerr("%s physics update not implemented" % name)
