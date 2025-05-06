extends State



func enter() -> void:
	player.velocity.y = player.jump_speed
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (player.pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x += direction.x * player.air_acceleration
		player.velocity.z += direction.z * player.air_acceleration 

	player.velocity.y = player.velocity.y - (player.air_fall_acceleration * 0.5 * delta)
	if Input.is_action_just_released("jump") or player.velocity.y < 0:
		tranistion.emit(self, get_parent().allStates["Air"])
