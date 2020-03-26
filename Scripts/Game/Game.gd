extends CanvasLayer

const PATHEVENTS = "res://Data/Events.json"
const PATHNAMES = "res://Data/Names.json"
const OPTIONSSCENE = preload("res://Escenas/Options2.tscn")

onready var mainContainer = $MainContainer
onready var topBar = $MainContainer/TopBar
onready var information = $MainContainer/Information
onready var statsMenu = $MainContainer/StatsMenu
onready var newDayScreen = $NewDayScreen
onready var bgMusic = $BGMusic
onready var animPlayer = $AnimPlayer

var concequenses = []
var options

# Days
var eventsThisDay = 0
var eventsPerDay = 3
var todayEvents = []
# Event Creation
var totalEvents = 6
var numberOfRepetitions = {}
var maxEventRepetitions = 6
# Event
var eventText = ""
var optionsText = ["",""]
var statsResults =[[0,0,0,0,0,0],
					[0,0,0,0,0,0]]
var resultsText = ["",""]
var resultsPopulation = [0,0]
var personsInvolved = []
#Stats
var healthyPopulation = 100
var stats = [100,40,80,100,35,0]
var statsMax = [100,100,100,100,2000,1000000]

func _ready():
	randomize()
	PickRandomEvent()
	topBar.ActualizarPoblacion(90)
	StartEvent()
	SetStats(stats)

func PickRandomEvent():
	var json = File.new()
	json.open(PATHEVENTS, File.READ)
	var listOfEvents = parse_json(json.get_as_text())
	json.close()
	var eventNumber = GetEventNumber()
	
	var event = listOfEvents[eventNumber]
	
	eventText = event["eventText"]
	
	var optionsVariables
	
	if IsDesperateTriggered(event["desperateTrigger"]):
		optionsVariables = [event["optionsText"][1],
							event["optionsText"][2]]
	else:
		optionsVariables = [event["optionsText"][0],
							event["optionsText"][1]]
	
	if rand_range(0,1) < 0.5:
		optionsVariables = [optionsVariables[1],optionsVariables[0]]
	
	optionsText = [optionsVariables[0][0],optionsVariables[1][0]]
	resultsText = [optionsVariables[0][1],optionsVariables[1][1]]
	statsResults = [[optionsVariables[0][2],optionsVariables[0][3],
				optionsVariables[0][4],optionsVariables[0][5],
				optionsVariables[0][6],optionsVariables[0][7]],
				[optionsVariables[1][2],optionsVariables[1][3],
				optionsVariables[1][4],optionsVariables[1][5],
				optionsVariables[1][6],optionsVariables[1][7]]]
	resultsPopulation = [optionsVariables[0][8],optionsVariables[1][8]]

func IsDesperateTriggered(desperateTrigger):
	for statNumber in range(stats.size()):
		return true
	
	return false

func GetEventNumber():
	var eventNumber = GenerateRandomEventNumber()
	
	if not numberOfRepetitions.has(eventNumber):
		numberOfRepetitions[eventNumber] = 0
	
	while (numberOfRepetitions[eventNumber] >= maxEventRepetitions or todayEvents.has(eventNumber)):
		eventNumber = GenerateRandomEventNumber()
	
	todayEvents.append(eventNumber)
	numberOfRepetitions[eventNumber] += 1
	return eventNumber

func GenerateRandomEventNumber():
	var number = str(randi() % totalEvents + 1)
	
	match (number.length()):
		1:
			number = "00" + number
		2:
			number = "0" + number
		3:
			pass

	return number

func StartEvent():
	ShowEvent()
	ShowOptions()

# TopBar

# Stats

func SetStats(newValues = [0,0,0,0,0,0]):
	for i in range(stats.size()):
		stats[i] = clamp(newValues[i],0,statsMax[i])
	statsMenu.SetStatsText(stats)
	
func ChangeStats(deltaValues = [0,0,0,0,0,0]):
	stats[0] = 1 + floor(stats[0] * (100 - deltaValues)/100)
	stats[0] = clamp(stats[0],0,statsMax[0])
	for i in range(1,stats.size()):
		stats[i] += deltaValues[i]
		stats[i] = clamp(stats[i],0,statsMax[i])
	statsMenu.SetStatsText(stats)
	
	if not Global.infected:
		return
	
	if stats[0] > randi()%statsMax[0]:
		Global.infected = true
		

# Information

func ShowEvent():
	information.ShowEvent(eventText)

# Options

func ShowOptions():
	if options != null:
		options.queue_free()
	options = OPTIONSSCENE.instance()
	mainContainer.add_child(options)
	options.ConnectSignals(self, "OptionChosen", "OptionCheck", "ShowEvent")

func OptionChosen(number):
	print("seleccionada la opción " + str(number) + ".")
	
	eventsThisDay += 1
	if eventsThisDay == eventsPerDay:
		Nextday()

func OptionCheck(number):
	information.ShowResoult(optionsText[number-1], statsResults[number-1])

# NewDayScreen

func Nextday():
	Global.days += 1
	todayEvents = []
	newDayScreen.get_node("Yesterday").text = "Día " + str(Global.days - 1) + " de cuarentena"
	newDayScreen.get_node("Today").text = "Día " + str(Global.days) + " de cuarentena"
	animPlayer.play("NewDay")

# Music

func BGMusicFinished():
	bgMusic.play()