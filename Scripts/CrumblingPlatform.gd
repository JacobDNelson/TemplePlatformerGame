extends Sprite

var CrumbleTimer
var VanishTimer
var CrumbleTime

var defaultMod = Color(1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	CrumbleTimer = get_node("CrumbleTimer")
	CrumbleTime = CrumbleTimer.wait_time
	VanishTimer = get_node("VanishTimer")
	
func _process(delta):
	if !CrumbleTimer.is_stopped():
		modulate = Color(CrumbleTimer.get_time_left()/CrumbleTime,CrumbleTimer.get_time_left()/CrumbleTime,CrumbleTimer.get_time_left()/CrumbleTime)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if CrumbleTimer.is_stopped():
			CrumbleTimer.start()


func _on_Timer_timeout():
	FallApart()


func FallApart():
	
	get_node("StaticBody2D/CollisionShape2D").disabled = true
	get_node("Area2D/CollisionShape2D").disabled = true
	self.visible = false
	VanishTimer.start()


func _on_VanishTimer_timeout():
	get_node("StaticBody2D/CollisionShape2D").disabled = false
	get_node("Area2D/CollisionShape2D").disabled = false
	self.visible = true
	modulate = defaultMod
