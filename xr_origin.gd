extends XROrigin3D

# === Settings ===
@export var speed: float = 1.0               # Movement speed
@export var mouse_sensitivity: float = 0.1   # Mouse look sensitivity
@export var emulator_height: float = 1     # Camera height for emulator

# Internal
var rotation_x: float = 0.0
@onready var xr_camera: XRCamera3D = $XRCamera3D

func _ready() -> void:
	# If XR is already enabled on the main viewport, we treat this as VR
	var in_vr: bool = get_viewport().use_xr

	# In emulator, lock camera height
	if not in_vr:
		global_position.y = emulator_height

	# Capture mouse for FPS‑style look in emulator
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	var input_dir := Vector3.ZERO

	# WASD input for movement (in both modes)
	if Input.is_action_pressed("move_forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_backward"):
		input_dir.z += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1

	if input_dir != Vector3.ZERO:
		input_dir = input_dir.normalized() * speed * delta
		var forward := -xr_camera.global_transform.basis.z
		var right := xr_camera.global_transform.basis.x
		global_translate(forward * input_dir.z + right * input_dir.x)

	# Only lock Y in emulator
	if not get_viewport().use_xr:
		global_position.y = emulator_height

func _input(event: InputEvent) -> void:
	# Handle mouse look for emulator
	if event is InputEventMouseMotion:
		rotation_x -= event.relative.y * mouse_sensitivity
		rotation_x = clamp(rotation_x, -90.0, 90.0)

		var cam_rot := xr_camera.rotation
		cam_rot.x = deg_to_rad(rotation_x)
		xr_camera.rotation = cam_rot

		rotate_y(-deg_to_rad(event.relative.x * mouse_sensitivity))
