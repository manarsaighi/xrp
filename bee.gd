extends Node3D

var center: Vector3
var radius_x := 3.0
var radius_z := 1.5
var speed := 1.0
var angle := 0.0

func _ready():
	center = global_transform.origin
	
	# Randomize the oblong size per bee
	radius_x = randf_range(2.0, 4.0)
	radius_z = randf_range(1.0, 2.5)
	speed = randf_range(0.8, 1.5)
	angle = randf_range(0, PI * 2)  # start at a random position in orbt

func _process(delta):
	_fly_ellipse(delta)

func _fly_ellipse(delta):
	angle += speed * delta

	var orbit_pos = Vector3(
		center.x + radius_x * cos(angle),
		center.y,
		center.z + radius_z * sin(angle)
	)

	global_transform.origin = orbit_pos
	look_at(center, Vector3.UP)
