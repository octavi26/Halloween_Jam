extends Area2D


@export var speed = 300
var direction = Vector2(0, 0)

func _physics_process(delta):
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.owner and body.owner.has_method("Hit"): 
		body.owner.Hit(1)
	self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.owner and area.owner.has_method("Hit"): 
		area.owner.Hit(1)
	self.queue_free()
