extends CanvasLayer

const COLOR_ENABLED = "#f8eebf"
var TEXTURE_CHECKED = load("res://Visuales/Check.png")
var TEXTURE_UNCHECKED = load("res://Visuales/Uncheck.png")
const defaultStats = [100,100,100,20,100,20000]

export var statsMax = [100,100,100,1000,100,1000000]

onready var anim = $AnimationPlayer
onready var labels = $Tutorial2/Labels
onready var bgMusic = $BGMusic
onready var infectedChecker = $GameConfig/Config/Infected/Checker

var stats = []

func _ready():
	$Thanks/Options/Exit.disabled = OS.get_name() == "HTML5"
	
	if not Global.cameFromGame:
		Global.cameFromGame = true
		$Main.visible = true
		Global.initialStats = defaultStats.duplicate()
	else:
		anim.play("BackToTitle")
		stats = Global.initialStats.duplicate()
	######################################
	# sacar despues
	HabilitateStartButtom()
	
	if Global.startInfected:
		infectedChecker.texture_normal = TEXTURE_CHECKED
	else:
		infectedChecker.texture_normal = TEXTURE_UNCHECKED
	
	stats = Global.initialStats.duplicate()
	ActualizeStats()

# THANKS

func ThanksBackPressed():
	if not anim.is_playing():
		anim.play("ThanksToMain")

func ThanksExitPressed():
	get_tree().quit()

#   MAIN

func MainStartPressed():
	if not anim.is_playing():
		anim.play("MainToGameConfig")

func MainContextPressed():
	if not anim.is_playing():
		anim.play("MainToTutorial1")

func MainExitPressed():
	if not anim.is_playing():
		anim.play_backwards("ThanksToMain")

func HabilitateStartButtom():
	if not get_node("Main/Start").disabled:
		return
	
	get_node("Main/Start").disabled = false
	get_node("Main/Start/Label").modulate = Color("#f8eebf")

#   TUTORIAL 1

func Tutorial1VolverPressed():
	SetVisibleText("Instruction")
	if not anim.is_playing():
		anim.play_backwards("MainToTutorial1")

func Tutorial1SiguientePressed():
	SetVisibleText("Instruction")
	if not anim.is_playing():
		anim.play("Tutorial1ToTutorial2")

#   TUTORIAL 2

func Tutorial2AnteriorPressed():
	HabilitateStartButtom()
	if not anim.is_playing():
		anim.play_backwards("Tutorial1ToTutorial2")

func Tutorial2VolverPressed():
	HabilitateStartButtom()
	if not anim.is_playing():
		anim.play("Tutorial2ToMain")

func SetVisibleText(label_name):
	for label in labels.get_children():
		if label.name == label_name:
			label.visible = true
		else:
			label.visible = false

func HealthPressed():
	SetVisibleText("Health")

func HappinessPressed():
	SetVisibleText("Happiness")

func SocialPressed():
	SetVisibleText("Social")

func CleanessPressed():
	SetVisibleText("Cleaness")

func FoodPressed():
	SetVisibleText("Food")

func MoneyPressed():
	SetVisibleText("Money")

func _on_BGMusic_finished():
	$BGMusic.play()

# Game Config

func GameConfigBackPressed():
	if not anim.is_playing():
		anim.play_backwards("MainToGameConfig")

func GameConfigDefaultPressed():
	Global.infected = false
	infectedChecker.texture_normal = TEXTURE_UNCHECKED
	
	stats = defaultStats.duplicate()
	ActualizeStats()

func GameConfigStartPressed():
	if not anim.is_playing():
		anim.play("StartGame")
		Global.NewGame()
		yield( anim, "animation_finished" )
		get_tree().change_scene("res://Screens/Game.tscn")

func InfectedCheckerPressed():
	Global.startInfected = !Global.startInfected
	if Global.startInfected:
		infectedChecker.texture_normal = TEXTURE_CHECKED
	else:
		infectedChecker.texture_normal = TEXTURE_UNCHECKED

func StatValueChange(value, number, emitter):
	stats[number] += value
	stats[number] = clamp(stats[number], 0, statsMax[number])
	emitter.ChangeValue(stats[number])

func ActualizeStats():
	for i in range(stats.size()):
		get_node("GameConfig/Config/Stat" + str(i)).ChangeValue(stats[i])
