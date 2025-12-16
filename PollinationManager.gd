extends Node

@export var counter_label_path: NodePath
var counter_label: Label
var pollination_count: int = 0

func _ready():
	counter_label = get_node(counter_label_path)
	_update_label()

func increment_count():
	pollination_count += 1
	_update_label()

func _update_label():
	if counter_label:
		counter_label.text = "Flowers Pollinated: %d" % pollination_count
