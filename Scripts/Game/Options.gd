extends HBoxContainer

func ConnectSignals(target, clicMethod, mouseEnterMethod, mouseExitedMethod):
	for i in range(get_children().size()):
		var value = str(i + 1)
		get_node("Option"+value).connect("pressed",target,clicMethod,[i+1])
		get_node("Option"+value).connect("mouse_entered",target,mouseEnterMethod,[i+1])
		get_node("Option"+value).connect("mouse_exited",target,mouseExitedMethod)
	pass
