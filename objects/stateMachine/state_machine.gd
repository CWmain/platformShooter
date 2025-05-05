extends Node
class_name StateMachine

@export var player: Player
@export var initialState: State

## Generates a dictionary of all States which exist in the state machine, so 
## the child states can simply reference the name of the state they wish to become
var allStates: Dictionary[String, State]

var currentState: State:
	set(value):
		if (currentState != null):
			print("%s: Change state %s -> %s" % [get_parent().name, currentState.name, value.name])
		value.enter()
		currentState = value

func _ready() -> void:
	currentState = initialState
	await owner.ready
	
	for child: State in get_children():
		child.tranistion.connect(transistionState)
		allStates[child.name] = child
		child.player = player
	print(allStates)
	
func _process(delta: float) -> void:
	currentState.update(delta)
	
func _physics_process(delta: float) -> void:
	currentState.physics_update(delta)

func transistionState(from: State, to: State)->void:
	if from != currentState:
		printerr("Attempting to transition from %s when current state is %s" % [from.name, currentState.name])
		return
	if to == null:
		printerr("Attempting to transition from %s to NULL" % [from.name])
		return
	currentState = to
