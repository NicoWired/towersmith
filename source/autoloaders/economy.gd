extends Node

@warning_ignore("unused_signal")
signal gold_changed

var _current_gold: int = 0
#var current_gold: int = 0
var current_gold: int:
	set(value):
		_current_gold = value
		gold_changed.emit()
	get:
		return _current_gold
