extends ProgressBar

var Damage1 = Global.LegParasites / 15
var Damage2 = Global.TorsoParasites / 15
var Damage3 = Global.HeadParasites / 15
var FinalDamage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var color = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", color)
	color.bg_color = Color("31f70a")
	value = Global.Health

func _on_damage_timer_timeout():
	FinalDamage = Damage1 + Damage2 + Damage3
	Take_Damage()
	
func _process(delta):
	Damage1 = Global.LegParasites / 10
	Damage2 = Global.TorsoParasites / 10
	Damage3 = Global.HeadParasites / 10
	value = Global.Health
	print(Global.Health)
	if value < 67 and value > 33:
		var color = StyleBoxFlat.new()
		add_theme_stylebox_override("fill", color)
		color.bg_color = Color("edf505")
	elif value >= 68:
		var color = StyleBoxFlat.new()
		add_theme_stylebox_override("fill", color)
		color.bg_color = Color("31f70a")
	elif value <= 33:
		var color = StyleBoxFlat.new()
		add_theme_stylebox_override("fill", color)
		color.bg_color = Color("f50505")


func Take_Damage():
	Global.Health -= FinalDamage
	$"../Damage Timer".start()
