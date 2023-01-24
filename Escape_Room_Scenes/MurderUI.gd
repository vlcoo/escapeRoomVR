extends Control

onready var focuseable_holder = $GridContainer


func _ready():
	$GridContainer/Heidi.grab_focus()


func _on_Nathan_button_up():
	print("You Failed!")
	 

func _on_Heidi_button_up():
	print("You Failed!")


func _on_Nicole_button_up():
	print("You Failed!")


func _on_Isaas_button_up():
	print("You Failed!")


func _on_Pedro_button_up():
	print("You won!")
