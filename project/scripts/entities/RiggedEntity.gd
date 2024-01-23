extends "Entity.gd"


@onready var rig = get_node("Rig")


func _physics_process(delta):
    super._physics_process(delta)
    
    rig.update_direction(velocity)
