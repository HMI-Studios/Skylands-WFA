extends Node2D


var level


func _ready():
    set_level("Lab")


func _process(delta):
    pass
    
    
func set_level(path):
    var scene = load("res://scenes/levels/%s.tscn" % path)
    level = scene.instantiate()
    add_child(level)
    
    
func get_spawn_pos():
    return level.get_node("Spawn").position * level.scale
