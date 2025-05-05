extends State

func enter() -> void:
	player.velocity.y = 30
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	player.velocity.y = player.velocity.y - (player.fall_acceleration * 0.1 * delta)
	if Input.is_action_just_released("jump") or player.velocity.y < 0:
		tranistion.emit(self, get_parent().allStates["Air"])
