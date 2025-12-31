extends Node

var money: float = 25.00
var luck: float = 0.5
var charisma: float = 0.5

# Casino Variables
var casino_unlocked: bool = false

#Checking if you unlocked Casino Yet
var casino_games_unlocked: Dictionary = {
	"slot_machine": false,
	"blackjack": false,
	"poker": false,
	"roulette": false,
}

# able to track casino game statistics
# Just in Case i forget how to update tables, here is an example:
# Global_Player_Variables.casino_game_stats["slot_machine"]["games_played"] += 1

var casino_game_stats: Dictionary = {
	"slot_machine": {
		"games_played": 0,
		"total_won": 0.0,
		"total_lost": 0.0,
	},
	"blackjack": {
		"games_played": 0,
		"total_won": 0.0,
		"total_lost": 0.0,
	},
	"poker": {
		"games_played": 0,
		"total_won": 0.0,
		"total_lost": 0.0,
	},
	"roulette": {
		"games_played": 0,
		"total_won": 0.0,
		"total_lost": 0.0,
	},
}
