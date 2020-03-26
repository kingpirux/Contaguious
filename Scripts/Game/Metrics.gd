extends TextureRect

onready var stats =[$Margin/Stats/Stat1/Health,
					$Margin/Stats/Stat1/Happiness,
					$Margin/Stats/Stat1/Cleaness,
					$Margin/Stats/Stat2/Food,
					$Margin/Stats/Stat2/Social,
					$Margin/Stats/Stat2/Money]

func SetStatsText(newValues = [0,0,0,0,0,0]):
	for i in range(stats.size()):
		stats[i].NewValueLabel(newValues[i])
