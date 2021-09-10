extends Node2D


export var SpikeInterval = 3.0
export var SpikeDuration = 1.0
#var timeCounter = 0.0
var spikesUp = false

var SpikeRiseTimer
export var riseTime = 0.2

var SpikeUpTimer
export var upTime = 1.0

var SpikeRetractTimer
export var retractTime = 1.0

var SpikeDownTimer
export var downTime = 3.0

var Spikes
export var spikeHeight = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	SpikeRiseTimer = get_node("Spikes/SpikeRiseTimer")
	SpikeRiseTimer.wait_time = riseTime
	SpikeUpTimer = get_node("Spikes/SpikeUpTimer")
	SpikeUpTimer.wait_time = upTime
	SpikeRetractTimer = get_node("Spikes/SpikeRetractTimer")
	SpikeRetractTimer.wait_time = retractTime
	SpikeDownTimer = get_node("Spikes/SpikeDownTimer")
	SpikeDownTimer.wait_time = downTime
	Spikes = get_node("Spikes")
	SpikeRetractTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !SpikeRetractTimer.is_stopped():
		Spikes.position.y = (SpikeRetractTimer.get_time_left()/retractTime) * -spikeHeight
	elif !SpikeRiseTimer.is_stopped():
		Spikes.position.y = (1 - (SpikeRiseTimer.get_time_left()/riseTime)) * -spikeHeight
	elif !SpikeUpTimer.is_stopped():
		Spikes.position.y = -spikeHeight
	else:
		Spikes.position.y = 0



func _on_Spikes_body_entered(body):
	if body.name == "Player":
		body.takeDamage()




func _on_SpikeRiseTimer_timeout():
	SpikeUpTimer.start()


func _on_SpikeUpTimer_timeout():
	SpikeRetractTimer.start()


func _on_SpikeRetractTimer_timeout():
	SpikeDownTimer.start()


func _on_SpikeDownTimer_timeout():
	SpikeRiseTimer.start()
