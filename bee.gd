extends Node3D

var center := Vector3.ZERO
var radius := 2.0
var speed := 1.5
var angle := 0.0

func _ready():
	center = global_transform.origin  # Bee orbits where it starts

func _process(delta):
	angle += speed * delta

	var x = center.x + radius * cos(angle)
	var z = center.z + radius * sin(angle)
	var y = center.y  # constant height

	global_transform.origin = Vector3(x, y, z)

	look_at(center, Vector3.UP)
