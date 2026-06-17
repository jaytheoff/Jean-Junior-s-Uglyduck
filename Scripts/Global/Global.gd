extends Node

@export var text_scroll_speed: float = 1.0
@export var record_mode: bool = false

var first_game_phase: GamePhase = GamePhase.post_prologue
var sec_game_phase: GamePhase = GamePhase.early_game
var third_game_phase: GamePhase = GamePhase.mid_game
var fourth_game_phase: GamePhase = GamePhase.late_game
var fifth_game_phase: GamePhase = GamePhase.finale

enum GamePhase {
    cutscene,
    post_prologue,
    early_game,
    mid_game,
    late_game,
    finale,
    none
}
