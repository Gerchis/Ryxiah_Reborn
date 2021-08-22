extends WorldEnvironment

onready var directional_light: DirectionalLight = $DirectionalLight

export var color_gradient: Gradient
export var day_length: = 60.0
export var sun_min_energy: = 0.2
export var sun_max_energy: = 1

var current_time: = 0.0
var am: = true

func _process(delta: float) -> void:
	if am:
		current_time += delta
	else:
		current_time -= delta
	
	if current_time > day_length and am or current_time < 0 and not am:
		am = not am
	
	var weight = current_time / day_length
	
	environment.ambient_light_color = color_gradient.interpolate(weight)
	
	var light_intensity = lerp(sun_max_energy, sun_min_energy, weight)
	
	environment.ambient_light_energy = light_intensity
	directional_light.light_energy = light_intensity
	
	var light_dir = lerp(0, 360, weight)
	
	directional_light.rotation.y = deg2rad(light_dir)

