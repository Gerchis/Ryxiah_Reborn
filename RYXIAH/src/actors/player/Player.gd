extends KinematicBody

class_name Player

onready var cam:Camera = get_tree().get_nodes_in_group("camera")[0]
onready var graphics = $Graphics
onready var ray_floor: RayCast = $RayFloor
onready var ray_checkpoint: RayCast = $CheckpointChecker
onready var fall_checkpoint: Vector3 = global_transform.origin

var jump: bool = false
var dir: Vector3 = Vector3.ZERO
var velocity: Vector3 = Vector3.ZERO
var current_velocity: Vector3 = Vector3.ZERO
var snap_vector: Vector3 = Vector3.ZERO
var jump_counter: = 0
var floor_heigh:float = 0.0


export var speed = 10
export var accel = 10
export var friction = 5
export var turn_speed = 300
export var jump_force = 20.0
export var air_speed = 8.0
export var air_run_speed = 16.0
export var air_accel = 9.0
export var max_jumps = 2
export var water_level = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if global_transform.origin.y <= water_level:
		global_transform.origin = fall_checkpoint

func _physics_process(delta: float) -> void:
	if is_on_floor():
		ray_floor.force_raycast_update()
		floor_heigh = ray_floor.get_collision_point().y


func _on_CheckpointSetter_timeout() -> void:
	ray_checkpoint.force_raycast_update()
	
	if is_on_floor() and ray_checkpoint:
		fall_checkpoint = global_transform.origin
