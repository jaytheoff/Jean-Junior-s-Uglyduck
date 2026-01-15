extends Node

var currencies: Dictionary = {
	"dollars": 0.0,
	"euros": 0.0,
	"yen": 0.0,
	"pounds": 0.0,
}
var money: float = 12.10
var payout: float = 0.0
var luck: float = 0.5
var charisma: float = 0.5
var debt: float = 0.0

# Casino Variables
var casino_unlocked: bool = false

#Checking if you unlocked Casino Yet
var casino_games_unlocked: Dictionary = {
	"slot_machine": false,
	"heads_or_tails": false,
	"dice_roll": false,
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
	"heads_or_tails": {
		"games_played": 0,
		"total_won": 0.0,
		"total_lost": 0.0,
	},
	"dice_roll": {
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
