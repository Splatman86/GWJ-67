extends Node2D

# Keep this below 100 to win
var MedicineLevel = 0
# Parasite counts in each part

var ClipboardShowing = false
# Sleep variable, decides if the parasites go up or not when sleeping
var SleepParasite

# When these timers go off every half a second, add 1 parasite to each parasite count variable
func _on_legs_timer_timeout():
	Global.LegParasites += 3
	$"Parasite Timers/Legs Timer".start()
func _on_torso_timer_timeout():
	Global.TorsoParasites += 3
	$"Parasite Timers/Torso Timer".start()
func _on_head_timer_timeout():
	Global.HeadParasites += 3
	$"Parasite Timers/Head Timer".start()
func _ready():
	var LegWaitTime = randi_range(1, 4)
	var TorsoWaitTime = randi_range(1, 4)
	var HeadWaitTime = randi_range(1, 4)
	$"Parasite Timers/Legs Timer".wait_time = LegWaitTime
	$"Parasite Timers/Torso Timer".wait_time = TorsoWaitTime
	$"Parasite Timers/Head Timer".wait_time = HeadWaitTime
	$"Clipboard/Parasite Count/Legs".set_text("Legs: 0")
	$"Clipboard/Parasite Count/Torso".set_text("Torso: 0")
	$"Clipboard/Parasite Count/Head".set_text("Legs: 0")
	$Clipboard.hide()

func _process(_delta):
	$"Clipboard/Parasite Count/Legs".set_text("Legs: " + str(Global.LegParasites))
	$"Clipboard/Parasite Count/Torso".set_text("Torso: " + str(Global.TorsoParasites))
	$"Clipboard/Parasite Count/Head".set_text("Head: " + str(Global.HeadParasites))
	$"Clipboard/Med Level".set_text("Med Level: " + str(MedicineLevel))
	if Global.LegParasites < 0:
		Global.LegParasites = 0
	elif Global.TorsoParasites < 0:
		Global.TorsoParasites = 0
	elif Global.HeadParasites < 0:
		Global.HeadParasites = 0
	if MedicineLevel >= 100:
		GameOver()
	elif MedicineLevel < 0:
		MedicineLevel = 0
	if 0 >= Global.Health:
		GameOver()
	if Global.Health > 100:
		Global.Health = 100
		
		# Keyboard controls, checked every frame
	if Input.is_action_just_pressed("Use Leg Meds"):
		_on_leg_meds_pressed()
		
	if Input.is_action_just_pressed("Use Torso Meds"):
		_on_torso_meds_pressed()
		
	if Input.is_action_just_pressed("Use Head Meds"):
		_on_head_meds_pressed()
		
	if Input.is_action_just_pressed("Drink Water"):
		_on_water_pressed()
		
	if Input.is_action_just_pressed("Sleep"):
		_on_sleep_pressed()

	if ClipboardShowing == false:
		$Clipboard.hide()
	if ClipboardShowing == true:
		$Clipboard.show()

func _on_leg_meds_pressed():
	MedicineLevel += 10
	Global.LegParasites -= 7
	Global.Heal()

func _on_torso_meds_pressed():
	MedicineLevel += 10
	Global.TorsoParasites -= 7
	Global.Heal()

func _on_head_meds_pressed():
	MedicineLevel += 10
	Global.HeadParasites -= 7
	Global.Heal()

func _on_sleep_pressed():
	Global.Heal()
	SleepParasite = randi_range(1, 5)
	if SleepParasite == 1:
		MedicineLevel -= 30
		SleepParasite = 0
	elif SleepParasite == 5:
		MedicineLevel -= 30
		Global.LegParasites += 3
		Global.TorsoParasites += 3
		Global.HeadParasites += 3
	SleepParasite = 0

func _on_water_pressed():
	MedicineLevel -= 5
	Global.Heal()

func GameOver():
	get_tree().change_scene_to_file("res://Scenes/Game Over.tscn")

func _on_button_pressed():
	if ClipboardShowing == false:
		ClipboardShowing = true
	elif ClipboardShowing == true:
		ClipboardShowing = false

# POLISH OF THE BUTTONS

func _on_leg_meds_mouse_entered():
	$"Med Buttons/Legs".scale = Vector2(0.8, 0.8)

func _on_leg_meds_mouse_exited():
	$"Med Buttons/Legs".scale = Vector2(0.859, 0.859)

func _on_torso_meds_mouse_entered():
	$"Med Buttons/Torso".scale = Vector2(0.8, 0.8)

func _on_torso_meds_mouse_exited():
	$"Med Buttons/Torso".scale = Vector2(0.859, 0.859)

func _on_head_meds_mouse_entered():
	$"Med Buttons/Head".scale = Vector2(0.8, 0.8)

func _on_head_meds_mouse_exited():
	$"Med Buttons/Head".scale = Vector2(0.859, 0.859)
