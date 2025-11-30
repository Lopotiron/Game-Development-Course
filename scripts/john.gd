extends Node3D

@onready var animation_tree = %AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")
@onready var anim_player := %AnimationPlayer

func idle():
	state_machine.travel("Idle")

func hold_weapon():
	state_machine.travel("Pistol_Aim_Neutral")
	
func sprint():
	state_machine.travel("Sprint")

func jumpstart():
	state_machine.travel("Jump_start")
	

func fall():
	state_machine.travel("Fall")

func jumpend(next_state: String = "Idle") -> void:
	state_machine.travel("Jump_end")

	var dur: float = 0.25
	if anim_player and anim_player.has_animation("AnimPack/Jump_Land"):
		dur = anim_player.get_animation("AnimPack/Jump_Land").length

	await get_tree().create_timer(dur).timeout
	get_parent().is_landing = false
	state_machine.travel(next_state)

func punch_the_air():
	state_machine.travel("Punch")

	var dur: float = 0.25
	if anim_player and anim_player.has_animation("AnimPack/Punch_Cross"):
		dur = anim_player.get_animation("AnimPack/Punch_Cross").length
	await get_tree().create_timer(dur).timeout
	get_parent().is_punching = false
	
func walking():
	state_machine.travel("Walk")
