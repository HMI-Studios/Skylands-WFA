extends Camera2D

 
func _ready():
    position = %Player.position


func _process(delta):
    var diff = %Player.position - position
    position += diff * 0.1
