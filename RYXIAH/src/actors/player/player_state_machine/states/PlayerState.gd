extends Node

class_name PlayerState

onready var player: Player
onready var states: Dictionary={}

var next_state: PlayerState

func enter():
	next_state = null

func get_input():
	
	player.jump = Input.is_action_just_pressed("jump")
	
	var input_dir = Vector3.ZERO
	
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.z = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	
	input_dir = input_dir.normalized() if input_dir.length() else input_dir
	
	player.dir = (input_dir.x * player.cam.global_transform.basis.x) + (input_dir.z * player.cam.global_transform.basis.z)

func physics_logic(delta):
	get_input()

func get_transition():
	return next_state

func face_point (point: Vector3, delta: float):
	var l_point = player.graphics.to_local(point)
	l_point.y = 0
	
	var turn_dir = sign(Vector3.RIGHT.dot(l_point))
	var turn_amnt = deg2rad(player.turn_speed * delta)
	var angle = Vector3.FORWARD.angle_to(l_point)
	
	if angle < turn_amnt:
		player.graphics.rotate_object_local(Vector3.UP, -angle * turn_dir)
	else:
		player.graphics.rotate_object_local(Vector3.UP, -turn_amnt * turn_dir)

func apply_gravity(delta: float):
	player.velocity.y += GameManager.GRAVITY * delta
	player.velocity.y = clamp(player.velocity.y, GameManager.GRAVITY * 10, player.jump_force)

func update_snap_vector():
	player.snap_vector = -player.get_floor_normal() if player.is_on_floor() else Vector3.ZERO
