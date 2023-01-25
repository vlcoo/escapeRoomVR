extends RichTextLabel


export(Array) var buttonAudioStream: Array
export(Array) var resultsAudioStream: Array
#export (int) var input = 0
		

var buttonAudioIndex: int = 0;

func updateAudioButtonIndex():
	buttonAudioIndex = (buttonAudioIndex+1)%buttonAudioStream.size()

func play_button_audio():
	$ButtonsAudio.stop()
	$ButtonsAudio.stream = buttonAudioStream[buttonAudioIndex]
	$ButtonsAudio.play()
	updateAudioButtonIndex()
	

func _on_Eliminate_pressed():
	text = text.left(text.length() - 1)
	$"../Warning".text = str("")


func fix_text_length():
	if(text.length() >= 4):
		text = text.substr(0, 4)
func _on_Button_pressed():
	text+= str("1")
	play_button_audio()
	fix_text_length()


func _on_Button2_pressed():
	text+= str("2")
	play_button_audio()
	fix_text_length()


func _on_Button3_pressed():
	text+= str("3")
	play_button_audio()
	fix_text_length()


func _on_Button4_pressed():
	text+= str("4")
	play_button_audio()
	fix_text_length()


func _on_Button5_pressed():
	text+= str("5")
	play_button_audio()
	fix_text_length()


func _on_Button6_pressed():
	text+= str("6")
	play_button_audio()
	fix_text_length()


func _on_Button7_pressed():
	text+= str("7")
	play_button_audio()
	fix_text_length()


func _on_Button8_pressed():
	text+= str("8")
	play_button_audio()
	fix_text_length()


func _on_Button9_pressed():
	text+= str("9")
	play_button_audio()
	fix_text_length()

func _on_Button10_pressed() -> void:
	text+= str("0")
	play_button_audio()
	fix_text_length()
	pass # Replace with function body.

func play_result_audio(win: bool):
	$ResultsAudio.stop()
	if(win):
		$ResultsAudio.stream = resultsAudioStream[0]
	else:
		$ResultsAudio.stream = resultsAudioStream[1]
	$ResultsAudio.play()
	

func _on_Enter_pressed():
		if(text == get_parent().password):
			Global.open_door(get_parent().door_to_open)
			play_result_audio(true)
		elif(text.length() == 4):
			play_result_audio(false)
			text = ""
			$"../Warning".visible = true
			$"../Warning".text = str("Incorrect!")
			yield(get_tree().create_timer(1), "timeout")
			$"../Warning".visible = false
			


