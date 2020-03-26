extends TextureRect

const COLOR_NEUTRAL = "#f8eebf"
const COLOR_BAD = "#a95a3f"
const COLOR_GOOD = "#7f9860"

onready var label = $Margin/information/Label
onready var results = $Results

func ShowEvent(text = ""):
	label.text = text
	results.visible = false

func ShowResoult(text = "", _results = [0,0,0,0,0,0]):
	label.text = text
	results.visible = true
	_results[0] *= -1
	for index in range(_results.size()):
		if _results[index] > 0:
			results.get_node("Stat" + str(index)).modulate = Color(COLOR_GOOD)
		elif _results[index] < 0:
			results.get_node("Stat" + str(index)).modulate = Color(COLOR_BAD)
		else:
			results.get_node("Stat" + str(index)).modulate = Color(COLOR_NEUTRAL)
