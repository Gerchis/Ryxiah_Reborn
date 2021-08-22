extends PlayerState

class_name Idle

func enter():
	.enter()

func physics_logic(delta):
	.physics_logic(delta)
	
	var target_vel = player.dir * 0
	
	player.current_velocity = player.current_velocity.linear_interpolate(target_vel, player.friction * delta)
	
	player.velocity.x = player.current_velocity.x
	player.velocity.z = player.current_velocity.z
	
	face_point(player.dir + player.global_transform.origin, delta)
	
	apply_gravity(delta)
	update_snap_vector()
	
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector3.UP, true, 4, deg2rad(45))
	
	if player.dir != Vector3.ZERO:
		next_state = states["Walk"]
	elif Input.is_action_just_pressed("jump"):
		next_state = states["Jump"]
