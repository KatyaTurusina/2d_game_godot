extends Area2D

func _ready() -> void:
	pass
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameStats.add_eggs(1)
		queue_free()
	pass 
