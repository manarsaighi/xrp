extends Node3D

func _on_area_3d_input_event(camera, event, click_pos, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Flower clicked:", name)
