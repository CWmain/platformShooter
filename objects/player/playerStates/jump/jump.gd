extends State

func enter() -> void:
	print("Jump")
	player.velocity.y = 30
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if Input.is_action_just_released("jump"):
		tranistion.emit(self, get_parent().allStates["Air"])
