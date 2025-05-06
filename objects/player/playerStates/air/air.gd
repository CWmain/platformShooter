extends State

@onready var coyote_time: Timer = $coyoteTime
var canJump: bool = true

func _ready() -> void:
	coyote_time.timeout.connect(_on_coyote_time_timeout)

func enter()->void:
	canJump = true
	coyote_time.start()

func update(delta: float)->void:
	pass

func physics_update(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (player.pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x += direction.x * player.air_acceleration
		player.velocity.z += direction.z * player.air_acceleration 
	player.velocity.y = max(-player.air_max_fall_speed, player.velocity.y - (player.air_fall_acceleration * delta))
	
	#TODO Issue with coyote time logic
	# Coyote time should only apply to the first jump, when leaving grounded, not sure how to resolve
	if Input.is_action_just_pressed("jump") and ((player.remainingJumps == 1 and canJump) or (player.remainingJumps > 1)):
		tranistion.emit(self, get_parent().allStates["Jump"])
	
	if player.is_on_floor():
		tranistion.emit(self, get_parent().allStates["Grounded"])

func _on_coyote_time_timeout() -> void:
	canJump = false
	
