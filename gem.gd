extends CharacterBody2D

@onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")

func _on_gem_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		Globals.gems += 1
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position-Vector2(0, 25), 1)
		tween1.tween_property(self, "modulate:a", 0, 1) 
		tween.tween_callback(queue_free)
