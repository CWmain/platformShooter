extends State


func enter()->void:
	print("Entered grounded state")
	
func update(delta: float)->void:
	pass

func physics_update(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (player.pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * player.speed
		player.velocity.z = direction.z * player.speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
		player.velocity.z = move_toward(player.velocity.z, 0, player.speed)

	# Vertical Velocity
	if not player.is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		player.velocity.y = player.velocity.y - (player.fall_acceleration * delta)
	else:
		if Input.is_action_pressed("jump"):
			player.velocity.y = 30
