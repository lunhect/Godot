extends Node


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS  # suena aunque el juego esté en pausa


func play(nombre: String) -> void:
	var p := AudioStreamPlayer.new()
	p.stream = load("res://assets/sonidos/%s.wav" % nombre)
	p.finished.connect(p.queue_free)
	add_child(p)
	p.play()
