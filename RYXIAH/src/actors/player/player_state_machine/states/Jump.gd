extends PlayerState

class_name Jump

func enter():
	.enter()
	
	player.velocity.y = player.jump_force
	player.jump_counter += 1

func physics_logic(delta):
	.physics_logic(delta)
	
	face_point(player.dir + player.global_transform.origin, delta)
	
	apply_gravity(delta)
	update_snap_vector()
	
	var speed = player.air_speed
	var target_vel = player.dir * speed
	
	player.current_velocity = player.current_velocity.linear_interpolate(target_vel, (player.accel * delta) if player.dir != Vector3.ZERO else (player.friction * delta))
	
	player.velocity.x = player.current_velocity.x
	player.velocity.z = player.current_velocity.z
	
	player.velocity = player.move_and_slide(player.velocity, Vector3.UP, true, 4, deg2rad(45))
	
	if Input.is_action_just_pressed("jump") and player.jump_counter < player.max_jumps:
		player.velocity.y = player.jump_force
		player.jump_counter += 1
	
	if player.is_on_floor():
		player.jump_counter = 0
		next_state = states["Idle"]
