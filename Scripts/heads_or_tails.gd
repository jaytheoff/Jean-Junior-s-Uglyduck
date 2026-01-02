extends Node2D
var cost := 35.0
var random:= RandomNumberGenerator.new()
var selected:String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _flip():

	var outcome := random.randi_range(0, 1) # 0 = Heads, 1 = Tails
	var result := "Heads" if outcome == 0 else "Tails"

	Global_Player_Variables.money -= 10.00

	Global_Player_Variables.casino_game_stats["heads_or_tails"]["games_played"] += 1

	if result == selected:
		Global_Player_Variables.money += 25.00
		# Player wins
		Global_Player_Variables.casino_game_stats["heads_or_tails"]["total_won"] += 1
		
		print("It's %s! You win $25!" % result)
	else:
		# Player loses
		Global_Player_Variables.casino_game_stats["heads_or_tails"]["total_lost"] += 1
		print("It's %s! You lose!" % result)

	return result




func _on_heads_pressed() -> void:
	if Global_Player_Variables.money >= cost and Global_Player_Variables.casino_games_unlocked["heads_or_tails"]:
		selected = "Heads"
		_flip()
		$Heads.disabled = true
		await get_tree().create_timer(0.8).timeout
		$Heads.disabled = false
	else:
		print("Not enough money to play or game not unlocked!")

func _on_tails_pressed() -> void:
	if Global_Player_Variables.money >= cost and Global_Player_Variables.casino_games_unlocked["heads_or_tails"]:
		selected = "Tails"
		_flip()
		$Tails.disabled = true
		await get_tree().create_timer(0.8).timeout
		$Tails.disabled = false
	else:
		print("Not enough money to play or game not unlocked!")