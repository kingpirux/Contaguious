extends HBoxContainer

const MINVALUE = 0
const COLOR_NORMAL = "#f8eebf"
const COLOR_LOW = "#a95a3f"

export(Texture) var iconTextureNormal
export(Texture) var iconTextureHover
export(Texture) var iconTexturePressed
export var index = 0

onready var icon = $Icon
onready var label = $Label

var statIsLow = [0,50,80,0,50,0]

func _ready():
	if iconTextureNormal != null:
		icon.texture_normal = iconTextureNormal
	if iconTextureHover != null:
		icon.texture_hover = iconTextureHover
	if iconTexturePressed != null:
		icon.texture_pressed = iconTexturePressed

func NewValueLabel(value):
	label.text = str(value)
	if value <= statIsLow[index]:
		label.modulate = Color(COLOR_LOW)
	else:
		label.modulate = Color(COLOR_NORMAL)
	
