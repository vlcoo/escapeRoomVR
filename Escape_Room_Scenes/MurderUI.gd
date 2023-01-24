extends Control

onready var focuseable_holder = $GridContainer
var tried_to_solve = false


func _process(delta):
	if !tried_to_solve:
		$Mask.visible = Global.clues_solved.size() < 3


func _ready():
	$GridContainer/Heidi.grab_focus()


func reveal_solution(is_correct: bool):
	tried_to_solve = true
	$Mask.visible = true
	$Mask/Label.text = "Congratulations!\nYou solved the mystery." if is_correct else "Sorry. That's not correct."


func _on_Nathan_button_up():
	Global.solve_mystery(false)
	reveal_solution(false)

func _on_Heidi_button_up():
	Global.solve_mystery(false)
	reveal_solution(false)

func _on_Nicole_button_up():
	Global.solve_mystery(false)
	reveal_solution(false)

func _on_Isaas_button_up():
	Global.solve_mystery(false)
	reveal_solution(false)

func _on_Pedro_button_up():
	Global.solve_mystery(true)
	reveal_solution(true)
