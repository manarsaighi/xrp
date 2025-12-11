extends Node3D

func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Flower clicked:", name)

		var bees = get_tree().get_nodes_in_group("Bee")
		if bees.size() == 0:
			return

		var closest_bee = null
		var closest_dist = INF
		var click_pos = global_transform.origin

		for bee in bees:
			var dist = bee.global_transform.origin.distance_to(click_pos)
			if dist < closest_dist:
				closest_dist = dist
				closest_bee = bee

		if closest_bee:
			closest_bee.target_position = click_pos
