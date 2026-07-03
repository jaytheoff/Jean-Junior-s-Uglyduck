class_name GameProgress
extends Node

const save_file_path: String = "user://savegame.tres"

@export var game_progress: Dictionary = {
    "current_game_phase": Global.GamePhase.post_prologue,
    "first_time_playing": true,
    "prologue_completed": false,
    "early_game_completed": false,
    "mid_game_completed": false,
    "late_game_completed": false,
    "finale_completed": false,
}

@export var job_progress: Dictionary = {
    "current_job": null,
    "job_history": [],
    "jobs_completed": 0,
    "job_performance": {
        "last_job": null,
        "overall_rating": 0.0,
        "ratings_count": 0,
    },
}