extends Node

@export var text_scroll_speed: float = 1.0
@export var record_mode: bool = false
var current_game_phase: GamePhase = GamePhase.post_prologue

enum GamePhase {
    cutscene,
    post_prologue,
    early_game,
    mid_game,
    late_game,
    finale,
    none
}
