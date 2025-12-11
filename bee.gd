extends Node3D

var speed = 3.0
var wander_radius = 5.0
var target_position: Vector3

func _ready():
	pick_new_target()

func _process(delta):
	var direction = (target_position - global_transform.origin).normalized()
	global_translate(direction * speed * delta)
	look_at(target_position, Vector3.UP)
	if global_transform.origin.distance_to(target_position) < 0.5:
		pick_new_target()

func pick_new_target():
	var random_offset = Vector3(
		randf_range(-wander_radius, wander_radius),
		randf_range(0.5, wander_radius),
		randf_range(-wander_radius, wander_radius)
	)
	target_position = global_transform.origin + random_offset
