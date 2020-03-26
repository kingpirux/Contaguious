extends Node

var cameFromGame = false

var days = 0
var infected = false
var infectedBy = ""
var infectedByYou = []

var startInfected = false
var initialStats = []
var statsMax = []

func NewGame():
	days = 0
	
	infected = startInfected
	if infected:
		infectedBy = "?"
	else:
		infectedBy = ""
	infectedByYou = []
