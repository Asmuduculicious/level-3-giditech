extends Node3D

var move_x = 0
var move_z = 0
var current: Vector3 = Vector3(0.0, 0.0, 0.0)
var previous: Vector3 = Vector3(0.0, 0.0, 0.0)
var absolute = false

func _process(delta: float) -> void:
	$Camera3D.position.y = clamp($Camera3D.position.y, 30.748, 30.748)

func _input(event):
	if Input.is_mouse_button_pressed(1):
		previous.x = event.position.x
		previous.z = event.position.y
		if absolute == false:
			absolute = true
			current.x = event.position.x
			current.z = event.position.y
		else:
			absolute = false
			previous.x = event.position.x
			previous.z = event.position.y
		move_x = current.x - previous.x
		move_z = current.z - previous.z
		$Camera3D.position.x += move_x
		$Camera3D.position.z += move_z
		
		
	
