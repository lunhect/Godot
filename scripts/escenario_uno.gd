extends Node2D

static var ya_iniciado := false


func _ready() -> void:
	if ya_iniciado:
		$Menu.queue_free()
	else:
		get_tree().paused = true  
