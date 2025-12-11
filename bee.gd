extends Node3D

var center: Vector3
var radius := 2.0
var speed := 1.5
var angle := 0.0

var flying_to_target := false
var target_position: Vector3 = Vector3.ZERO

func _ready():
	center = global_transform.origin

func _process(delta):
	if flying_to_target:
		_fly_to_flower(delta)
	else:
		_circle(delta)

func _circle(delta):
	angle += speed * delta

	var orbit_pos = Vector3(
		center.x + radius * cos(angle),
		center.y,
		center.z + radius * sin(angle)
	)

	global_transform.origin = orbit_pos
	look_at(center, Vector3.UP)


func _fly_to_flower(delta):
	var dir := (target_position - global_transform.origin)
	var dist := dir.length()

	if dist < 0.2:
		# Arrived at the flower
		center = target_position
		flying_to_target = false
		return

	dir = dir.normalized()
	global_transform.origin += dir * speed * delta
	look_at(target_position, Vector3.UP)
