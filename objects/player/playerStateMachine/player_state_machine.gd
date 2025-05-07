extends StateMachine
class_name PlayerStateMachine

@export var player: Player

func _ready() -> void:
	currentState = initialState
	await owner.ready
	
	for child: State in get_children():
		child.tranistion.connect(transistionState)
		allStates[child.name] = child
		child.player = player
	print("H3ello ",allStates)
