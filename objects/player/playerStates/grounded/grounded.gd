extends State


func enter()->void:
	if player != null:
		player.remainingJumps = player.jump_max 
	
func update(delta: float)->void:
	pass

func physics_update(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (player.pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = move_toward(player.velocity.x, direction.x * player.grounded_speed, player.grounded_acceleration) 
		player.velocity.z = move_toward(player.velocity.z, direction.z * player.grounded_speed, player.grounded_acceleration) 
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.grounded_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, player.grounded_speed)

	# Vertical Velocity
	if not player.is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		tranistion.emit(self, get_parent().allStates["Air"])
	else:
		if Input.is_action_pressed("jump"):
			tranistion.emit(self, get_parent().allStates["Jump"])
			
