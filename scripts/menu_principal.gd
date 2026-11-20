extends Control


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS  
	$CenterContainer/VBoxContainer/BotonJugar.pressed.connect(_on_jugar)
	$CenterContainer/VBoxContainer/BotonSalir.pressed.connect(get_tree().quit)
	$CenterContainer/VBoxContainer/BotonJugar.grab_focus()


func _on_jugar() -> void:
	Sonido.play("click")
	var capa := get_parent()
	if capa is CanvasLayer:  
		get_tree().paused = false
		capa.queue_free()
	else: 
		get_tree().change_scene_to_file("res://escenas/escenario_uno.tscn")
