extends RichTextLabel


#export (int) var input = 0
func _process(delta):
	if(text.length()>=4):
		text = text.substr(0,4)
		



	

func _on_Eliminate_pressed():
	text = text.left(text.length() - 1)
	$"../Warning".text = str("")

func _on_Button_pressed():
	text+= str("1")


func _on_Button2_pressed():
	text+= str("2")


func _on_Button3_pressed():
	text+= str("3")


func _on_Button4_pressed():
	text+= str("4")


func _on_Button5_pressed():
	text+= str("5")


func _on_Button6_pressed():
	text+= str("6")


func _on_Button7_pressed():
	text+= str("7")


func _on_Button8_pressed():
	text+= str("8")


func _on_Button9_pressed():
	text+= str("9")



func _on_Enter_pressed():
		if(text == str(1551)):
			Global.open_door("Garage")
			
		if(text.length()==4):
			if(text != str(1551)):
				$"../Warning".text = str("Incorrect!")
