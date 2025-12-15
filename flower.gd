extends Node3D

@export var particle_scene: PackedScene  # Assign your CPUParticles3D scene in the inspector

func _ready():
	_test_particles()

func _test_particles():
	if particle_scene:
		var particles = particle_scene.instantiate()
		particles.global_transform.origin = global_transform.origin
		add_child(particles)
		particles.emitting = true
		
		# Remove after lifetime
		var lifetime = particles.lifetime
		await get_tree().create_timer(lifetime).timeout
		if particles.is_valid():
			particles.queue_free()
