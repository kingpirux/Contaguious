extends CanvasLayer

onready var anim = $AnimationPlayer

func _ready():
	anim.play_backwards("StartGame")
	$Main/Days.text += str(Global.days)
	
	if Global.infected:
		$Main/Infected.text += "Si"
		
		if Global.infectedBy == "":
			$Main/InfectedBy.text += "Nadie"
		else:
			$Main/InfectedBy.text += Global.infectedBy
	
		if Global.infectedByYou.size() == 0:
			$Main/InfectedByYou.text += "Nadie"
		else:
			for infected in Global.infectedByYou.size():
				$Main/InfectedByYou.text += infected + ", "
			$Main/InfectedByYou.text -=  ", "
	else:
		$Main/Infected.text += "No"
		$Main/InfectedBy.text += "Nadie"
		$Main/InfectedByYou.text +=  "Nadie"

func RetryPressed():
	anim.play("StartGame")
	Global.NewGame()
	yield( anim, "animation_finished" )
	get_tree().change_scene("res://Screens/Game.tscn")

func BackPressed():
	anim.play("BackToMenu")
	yield( anim, "animation_finished" )
	get_tree().change_scene("res://Screens/Title.tscn")
