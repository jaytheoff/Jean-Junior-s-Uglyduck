extends Node2D
var cost := 10.0

var random:= RandomNumberGenerator.new()
enum Symbols {
	CHERRY,
	LEMON,
	ORANGE
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#this function will spin the reels and then like return the results
func spin_reels() -> Array:
	var results := []
	for i in range(3):
		var symbol := random.randi_range(0, 2) # Assuming 6 symbols
		results.append(symbol)
	evaluate_spin(results)
	return results

#this one checks the results of the spin and returns rewards
func evaluate_spin(results: Array) -> int:
	#checks if all three symbols match, Just incase i get confused 0 is cherry, 1 is lemon, 2 is orange
	if results[0] == results[1] and results[1] == results[2] and results[0] == results[2]:
		#adds one game played
		Global_Player_Variables.casino_game_stats["slot_machine"]["games_played"] += 1
		#adds one win
		Global_Player_Variables.casino_game_stats["slot_machine"]["total_won"] += 1
		#adds 100 dollars to your money
		Global_Player_Variables.money += 25.00
		print("Jackpot! You won 25!")
		return 25 # Jackpot

	elif results[0] == results[1] and results[1] == results[2] or results[0] == results[2]:
		#adds one game played
		Global_Player_Variables.casino_game_stats["slot_machine"]["games_played"] += 1
		#adds one win
		Global_Player_Variables.casino_game_stats["slot_machine"]["total_won"] += 1
		#gives you 20 dollars
		Global_Player_Variables.money += 15.00

		print("You won a small prize!, added 15 to your money")
		return 15 # Small win
	else:
		Global_Player_Variables.casino_game_stats["slot_machine"]["games_played"] += 1
		Global_Player_Variables.casino_game_stats["slot_machine"]["total_lost"] += 1
		print("You Lost your money lol")
		return 0 # No win

# Triggered when the player presses the "Gamble" button
func _on_gamble_pressed() -> void:
	if Global_Player_Variables.money < cost or not Global_Player_Variables.casino_games_unlocked["slot_machine"]:
		print("Not enough money to play!, or game not unlocked!")
		return

	else:
		Global_Player_Variables.money -= cost 
		Global_Player_Variables.casino_game_stats["slot_machine"]["games_played"] += 1
		random.randomize()
		spin_reels()
		$Gamble.disabled = true
		await get_tree().create_timer(5.0).timeout
		$Gamble.disabled = false
