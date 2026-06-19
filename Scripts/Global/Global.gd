extends Node

@export var text_scroll_speed: float = 1.0
@export var record_mode: bool = false

enum GamePhase {
	start,
	post_prologue,
	early_game,
	mid_game,
	late_game,
	end,
	none
}

var current_game_phase : GamePhase = GamePhase.post_prologue
