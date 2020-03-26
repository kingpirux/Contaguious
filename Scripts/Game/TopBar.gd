extends HBoxContainer

onready var label = $Label
onready var rect = $Bar/Rect
onready var info = $Info

func ActualizarPoblacion(num = 100):
	num = clamp(num,0,100)
	label.text = "Infectados: " + str(100-num) + "%"
	rect.rect_size.x = 96 - floor(96 * num/100)
	return num
