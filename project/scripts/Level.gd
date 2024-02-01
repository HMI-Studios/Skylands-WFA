extends Node2D


var level


func _ready():
    reset()
    
    
func reset():
    set_level("TileTest")


func _process(delta):
    pass
    
    
func set_level(path, exit_pos=null):
    for child in get_children():
        remove_child(child)
        child.queue_free()
    var scene = load("res://scenes/levels/%s.tscn" % path)
    level = scene.instantiate()
    add_child(level)
    var spawn_offset
    if exit_pos == null:
        spawn_offset = Vector2(0, 0)
    else:
        spawn_offset = %Player.position - exit_pos
    var spawn = get_spawn_pos() + spawn_offset
    %Player.position = spawn
    %Camera.position = spawn
    %Player.reset()
    
    
func get_spawn_pos():
    return level.get_node("Spawn").position * level.scale
