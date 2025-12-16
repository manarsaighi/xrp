extends XRController3D

@export var pointer: NodePath 
var pointer_node

func _ready():
	
	button_pressed.connect(_on_button_pressed)

	
	if pointer != null:
		pointer_node = get_node(pointer)

func _on_button_pressed(name: String):
	print("Button pressed: ", name)
	if name == "trigger_click":
		print("Trigger click detected!")
