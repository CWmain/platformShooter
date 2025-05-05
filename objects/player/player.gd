extends CharacterBody3D
class_name Player
# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var mouseSensitivty: float = 0.005


@onready var pivot: Node3D = $Pivot
@onready var camera_3d: Camera3D = $Pivot/Camera3D
@onready var state_machine: StateMachine = $StateMachine

var target_velocity = Vector3.ZERO

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
	state_machine.currentState.physics_update(delta)

func _process(_delta: float) -> void:
	move_and_slide()
