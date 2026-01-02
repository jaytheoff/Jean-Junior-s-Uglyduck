extends Node2D
signal set_bet

@onready var amount_input := $Input
@onready var display_text := $Display

var rng = RandomNumberGenerator.new()
var cost := 5
var amount_bet := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	amount_input.text_submitted.connect(set_bet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func roll():
	if Global_Player_Variables.money < cost and amount_bet < 0 and amount_bet > 7:
		return -cost
	rng.randomize()
	return rng.randi_range(1, 6)

func _on_set_bet() -> void:
	amount_bet = int(amount_input.text)
	display_text.text = "Bet Amount: %d" % amount_bet
	roll()
