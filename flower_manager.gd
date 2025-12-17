extends Node3D

@export var flower_scene: PackedScene
@export var number_of_flowers: int = 12
@export var area_size: Vector2 = Vector2(20, 20)  # XZ area size
@export var y_height: float = 0.0  # All flowers at the same height
@export var min_scale: float = 0.8
@export var max_scale: float = 1.2
@export var min_distance: float = 1.0  # Minimum distance between flowers

var placed_positions := []

func _ready():
	randomize()
	_generate_flowers()

func _generate_flowers():
	if not flower_scene:
		push_error("Flower scene not assigned!")
		return

	for i in number_of_flowers:
		var flower = flower_scene.instantiate()
		
		var tries = 0
		var max_tries = 50
		var spawn_position = Vector3.ZERO

		# Find a position that doesn’t overlap with existing flowers
		while tries < max_tries:
			var x = randf() * area_size.x - area_size.x / 2
			var z = randf() * area_size.y - area_size.y / 2
			spawn_position = Vector3(x, y_height, z)
			
			var too_close = false
			for pos in placed_positions:
				if pos.distance_to(spawn_position) < min_distance:
					too_close = true
					break

			if not too_close:
				placed_positions.append(spawn_position)
				break

			tries += 1

		if tries == max_tries:
			print("Could not place flower without overlap, skipping...")
			continue

		flower.position = spawn_position
		flower.rotation = Vector3(0, randf() * TAU, 0)

		var scale_factor = randf_range(min_scale, max_scale)
		flower.scale = Vector3.ONE * scale_factor

		add_child(flower)
		print("Spawned flower at ", flower.global_transform.origin)
