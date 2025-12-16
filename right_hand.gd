extends XRController3D

@export var pointer: NodePath  # Optional: your XRToolsFunctionPointer
var pointer_node

func _ready():
	# If you want to connect to the button_pressed signal:
	button_pressed.connect(_on_button_pressed)

	# Optional: cache the pointer node if assigned
	if pointer != null:
		pointer_node = get_node(pointer)

func _on_button_pressed(name: String):
	print("Button pressed: ", name)
	if name == "trigger_click":
		print("Trigger click detected!")
