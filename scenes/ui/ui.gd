extends CanvasLayer
class_name UI

@onready var score_label = %Score
@onready var reload_progress: TextureProgressBar = %ReloadProgress

var score := 0 :
	set(_score):
		score = _score
		_update_score_label()


func _ready():
	_update_score_label()


func _on_collected(collectable) -> void:
	if collectable:
		score += 100


func _update_score_label():
	score_label.text = str(score)


func _on_reload_progress(progress) -> void:
	reload_progress.value = progress
	
	
func _on_reloaded() -> void:
	reload_progress.value = 1
	reload_progress
