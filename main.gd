extends Node3D

var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	
	if xr_interface and xr_interface.is_initialized():
		print("success")
		
		
		# Disable VSync for smoother VR streaming
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		# Enable XR for this viewport
		get_viewport().use_xr = true
	else:
		print("not working")
