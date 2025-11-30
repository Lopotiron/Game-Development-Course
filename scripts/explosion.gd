extends Node3D

@onready var debris = $Debris
@onready var smoke = $Smoke
@onready var fire = $Fire
@onready var shot_audio = $PistolShot

func explode():
	debris.emitting = true
	smoke.emitting = true
	fire.emitting = true
	shot_audio.play()
	await get_tree().create_timer(2.0).timeout
	queue_free()
