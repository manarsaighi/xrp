extends XRToolsInteractableBody

@export var particles_path: NodePath  # Assign CPUParticles3D node here

var right_hand: XRController3D = null
var was_trigger_pressed: bool = false
#var pollination_manager: Node = null 

func _ready():
	# Deferred lookup to ensure RightHand exists
	call_deferred("_find_right_hand")
	call_deferred("_connect_signals")


func _find_right_hand():
	var hands = get_tree().get_nodes_in_group("RightHand")
	if hands.size() > 0:
		right_hand = hands[0]
	else:
		push_error("RightHand XRController3D not found in group 'RightHand'")

func _connect_signals():
	if has_signal("pointer_event"):
		connect("pointer_event", Callable(self, "_on_pointer_event"))

func _on_pointer_event(event):
	if right_hand == null:
		return  # Safety check

	if event.pressed:
		var trigger_pressed = right_hand.is_button_pressed("trigger_click")

		# Fire once per trigger press
		if trigger_pressed and not was_trigger_pressed:
			print("Flower clicked!")
			_emit_particles()

		was_trigger_pressed = trigger_pressed
	else:
		# Pointer moved away, reset trigger state
		was_trigger_pressed = false

func _emit_particles():
	var particles = get_node_or_null(particles_path)
	if particles:
		particles.emitting = false
		particles.emitting = true
