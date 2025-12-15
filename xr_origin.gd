extends XROrigin3D

# === Settings ===
@export var speed: float = 1.0               # Movement speed
@export var mouse_sensitivity: float = 0.1  # Mouse look sensitivity
@export var height: float = 1.6             # Camera height for emulator

# Internal
var rotation_x: float = 0.0
@onready var xr_camera: XRCamera3D = $XRCamera3D

func _ready() -> void:
	# Center the origin once for emulator
	XRServer.center_on_hmd(XRServer.RESET_BUT_KEEP_TILT, true)
	# Lock camera height
	global_position.y = height
	# Capture mouse for FPS-style look
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	var input_dir: Vector3 = Vector3.ZERO

	# WASD input
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
		# Move relative to camera facing
		var forward: Vector3 = -xr_camera.global_transform.basis.z
		var right: Vector3 = xr_camera.global_transform.basis.x
		global_translate(forward * input_dir.z + right * input_dir.x)

	# Keep height locked
	global_position.y = height

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Vertical look
		rotation_x -= event.relative.y * mouse_sensitivity
		rotation_x = clamp(rotation_x, -90.0, 90.0)

		var cam_rot: Vector3 = xr_camera.rotation
		cam_rot.x = deg_to_rad(rotation_x)
		xr_camera.rotation = cam_rot

		# Horizontal rotation (rotate origin)
		rotate_y(-deg_to_rad(event.relative.x * mouse_sensitivity))
