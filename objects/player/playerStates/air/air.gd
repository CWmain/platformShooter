extends State

func enter()->void:
	pass

func update(delta: float)->void:
	pass

func physics_update(delta: float) -> void:
	player.velocity.y = player.velocity.y - (player.fall_acceleration * delta)
	if player.is_on_floor():
		tranistion.emit(self, get_parent().allStates["Grounded"])
