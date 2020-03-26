extends Label

export var deltaValue = 5
export var index = 0

export(Texture) var icon
signal valueChange(value, number, emitter)

func _ready():
	$Icon.texture = icon

func MinusPressed():
	emit_signal("valueChange", -deltaValue, index, self)

func PlusPressed():
	emit_signal("valueChange", deltaValue, index, self)

func ChangeValue(value):
	$Value.text = str(value)
