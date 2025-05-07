extends CharacterBody3D
class_name Player
@export_subgroup("Grounded", "grounded_")
# How fast the player moves in meters per second.
@export var grounded_speed: float = 14
@export var grounded_acceleration: float = 0.7
@export var grounded_deceleration: float = 1.0

@export_subgroup("Jump", "jump_")
## The initial force of the jump in meters per second
@export var jump_speed: float = 30
## The maximum number of jumps the player has before a reset must be hit
@export var jump_max: int = 1
# The downward acceleration when in the air, in meters per second squared.
@export_subgroup("Air", "air_")
@export var air_acceleration: float = 0.1
@export var air_fall_acceleration: float = 75
# The highest fall speed in meters per second
@export var air_max_fall_speed: float = 100


@export var mouseSensitivty: float = 0.005

@onready var pivot: Node3D = $Pivot
@onready var camera_3d: Camera3D = $Pivot/Camera3D
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var grapple_ray_cast_3d: RayCast3D = $Pivot/Camera3D/GrappleRayCast3D

var remainingJumps: int = 1
var target_velocity = Vector3.ZERO
var activateGraple: bool = false
var last_raycast_position: Vector3 = Vector3.ZERO
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			pivot.rotate_y(-event.relative.x * mouseSensitivty)
			camera_3d.rotate_x(-event.relative.y * mouseSensitivty)
			camera_3d.rotation.x = clampf(camera_3d.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	if Input.is_action_just_pressed("grapple") and grapple_ray_cast_3d.is_colliding():
		activateGraple = true
		last_raycast_position = grapple_ray_cast_3d.get_collision_point()
	if Input.is_action_just_released("grapple"):
		activateGraple = false
	
	#TODO Refactor perhaps into state machine or somewhere nicer
	#TODO Reimplement a nicer grapple
	if activateGraple:
		print("Grappling")
		var position_difference = position - last_raycast_position
		apply_force(position_difference.normalized(), -15)
		
	state_machine.currentState.physics_update(delta)

func apply_force(direction: Vector3, force: float):
	velocity += direction * force

func _process(_delta: float) -> void:
	move_and_slide()
