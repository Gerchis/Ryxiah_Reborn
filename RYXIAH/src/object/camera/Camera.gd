extends Spatial

onready var arm: = $SpringArm
onready var player:Player = get_tree().get_nodes_in_group("player")[0]

export var cam_accel: = 5
export var player_heigh: = 5

func _unhandled_input(event):
	
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(-event.relative.x * GameManager.MOUSE_SENSITIVITY))
		rotation.y = clamp(rotation.y, deg2rad(GameManager.min_cam_angle_y), deg2rad(GameManager.max_cam_angle_y))
		
		arm.rotate_x(deg2rad(-event.relative.y * GameManager.MOUSE_SENSITIVITY))
		arm.rotation.x = clamp(arm.rotation.x, deg2rad(GameManager.min_cam_angle_x), deg2rad(GameManager.max_cam_angle_x))

func _physics_process(delta: float) -> void:
	move_to_target(player.global_transform.origin, delta)

func move_to_target(target: Vector3, delta: float)-> void:
	var old_pos = global_transform.origin
	target.y = player.floor_heigh + player_heigh
	
	var new_pos = old_pos.linear_interpolate(target, cam_accel * delta)
	
	global_transform.origin = new_pos
