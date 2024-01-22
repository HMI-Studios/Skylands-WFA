extends Node2D


var level


func _ready():
    reset()
    
    
func reset():
    set_level("TileTest")


func _process(delta):
    pass
    
    
func set_level(path):
    for child in get_children():
        remove_child(child)
        child.queue_free()
    var scene = load("res://scenes/levels/%s.tscn" % path)
    level = scene.instantiate()
    add_child(level)
    var spawn = get_spawn_pos()
    %Player.position = spawn
    %Camera.position = spawn
    
    
func get_spawn_pos():
    return level.get_node("Spawn").position * level.scale
