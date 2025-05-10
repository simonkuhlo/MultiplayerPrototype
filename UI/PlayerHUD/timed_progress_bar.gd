extends ProgressBar
class_name TimedProgressBar

var timer:Timer:
	set(new):
		timer = new
		if timer:
			show()
		else:
			hide()

func _process(delta):
	if timer:
		value = timer.time_left
