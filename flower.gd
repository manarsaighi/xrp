extends XRToolsInteractableBody

@export var particle_scene: PackedScene

func _ready():
	call_deferred("_connect_signals")

func _connect_signals():
	if has_signal("pointer_event"):
		connect("pointer_event", Callable(self, "_on_pointer_event"))

func _on_pointer_event(event):
	print("Pointer event! pressed=", event.pressed)  # Debug
	if event.pressed:
		_emit_particles()

func _emit_particles():
	if particle_scene:
		var particles = particle_scene.instantiate()
		particles.global_transform.origin = global_transform.origin + Vector3(0, 0.3, 0)
		add_child(particles)
		particles.emitting = true
