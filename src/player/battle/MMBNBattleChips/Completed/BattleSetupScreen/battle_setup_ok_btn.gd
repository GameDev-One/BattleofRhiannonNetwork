extends Button

func play():
	$Selector.show()
	$Selector/AnimationPlayer.play("blink")

func stop():
	$Selector.hide()
	$Selector/AnimationPlayer.stop()
