extends Node

class_name Clock

var time = 0.0
var stopped = true

func _process(delta):
	if (stopped):
		return
	time += delta
	
func reset():
	time = 0.0
	
func stop():
	stopped = true

func on():
	stopped = false

func time_to_string() -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minutes = time / 60
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [minutes, sec, msec]	
	return actual_string
