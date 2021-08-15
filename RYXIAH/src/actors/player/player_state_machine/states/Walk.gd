extends PlayerState

class_name Walk

func enter():
	.enter()

func physics_logic(delta):
	.physics_logic(delta)
	
	var speed = player.speed
	var target_vel = player.dir * speed
	
	player.current_velocity = player.current_velocity.linear_interpolate(target_vel, player.accel * delta)
	
	player.velocity.x = player.current_velocity.x
	player.velocity.z = player.current_velocity.z
	
	face_point(player.dir + player.global_transform.origin, delta)
	
	apply_gravity(delta)
	
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vector, Vector3.UP, true, 4, deg2rad(45))
	
	if player.dir == Vector3.ZERO:
		next_state = states["Idle"]
