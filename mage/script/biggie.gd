extends CanvasLayer

@export var button1:Node 

@export var button2:Node 

@export var button3:Node 

@export var button4:Node 

@export var button5:Node 



func _on_button_pressed() -> void:
	if button2.visible == true:
		button2.visible = false
	else:
		button2.visible = true
	


func _on_button_pressed_1() -> void:
	if button3.visible == true:
		button3.visible = false
	else:
		button3.visible = true


func _on_button_2_pressed() -> void:
	if button4.visible == true:
		button4.visible = false
	else:
		button4.visible = true
