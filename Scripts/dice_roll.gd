extends Node2D
signal set_bet

@onready var amount_input := $Input
@onready var display_text := $Display

var rng = RandomNumberGenerator.new()
var cost := 5
var amount_bet := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	amount_input.text_submitted.connect(_on_set_bet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func roll():	
	print("Current money: ", Global_Player_Variables.money)
	print("Amount bet: ", amount_bet)
	
	if Global_Player_Variables.money < cost or amount_bet <= 0 or amount_bet > 6 :
		display_text.text = "Invalid bet! Need $%d and bet 1-6" % cost
		print("Failed validation!")
		return
	
	else:
		Global_Player_Variables.money -= cost
		Global_Player_Variables.casino_game_stats["dice_roll"]["games_played"] += 1
		print("Bet accepted! Rolling dice...")
	# Roll the dice
	rng.randomize()
	var result = rng.randi_range(1, 6)
	$Dice.frame = result  # Assuming Dice is a Sprite with frames 1-6
	
	# Check result
	if result == amount_bet:
		var winnings = cost * 5  # Or whatever multiplier you want
		Global_Player_Variables.money += winnings
		Global_Player_Variables.casino_game_stats["dice_roll"]["total_won"] += 1
		print("Rolled %d! You win $%d!" %[result, winnings])
	else:
		Global_Player_Variables.casino_game_stats["dice_roll"]["total_lost"] += 1
		print("Rolled %d. You lost $%d." %[result, cost])

func _on_set_bet(text: String) -> void:
	amount_bet = int(text)
	display_text.text = "Bet Amount: %d" % amount_bet


func _on_roll_pressed() -> void:
	if Global_Player_Variables.casino_games_unlocked["dice_roll"]:
		roll()
		$Roll.disabled = true
		await get_tree().create_timer(2.0).timeout
		$Roll.disabled = false
	else:
		print("Dice Roll game not unlocked!")
	
	
