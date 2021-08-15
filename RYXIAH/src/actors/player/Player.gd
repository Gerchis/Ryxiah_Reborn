extends KinematicBody

class_name Player

onready var cam_root = $CameraRoot
onready var arm:SpringArm = $CameraRoot/SpringArm
onready var cam:Camera = $CameraRoot/SpringArm/Camera
onready var graphics = $Graphics

var jump: bool = false
var dir: Vector3 = Vector3.ZERO
var velocity: Vector3 = Vector3.ZERO
var current_velocity: Vector3 = Vector3.ZERO
var snap_vector: Vector3 = Vector3.ZERO

export var speed = 10
export var accel = 15
export var turn_speed = 300
export var jump_force = 20.0
export var air_speed = 8.0
export var air_run_speed = 16.0
export var air_accel = 9.0
export var max_jumps = 1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		cam_root.rotate_y(deg2rad(-event.relative.x * GameManager.MOUSE_SENSITIVITY))
		cam_root.rotation.y = clamp(cam_root.rotation.y, deg2rad(GameManager.MIN_CAM_ANGLE_Y), deg2rad(GameManager.MAX_CAM_ANGLE_Y))
		
		arm.rotate_x(deg2rad(-event.relative.y * GameManager.MOUSE_SENSITIVITY))
		arm.rotation.x = clamp(arm.rotation.x, deg2rad(GameManager.MIN_CAM_ANGLE_X), deg2rad(GameManager.MAX_CAM_ANGLE_X))

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
