extends CanvasLayer


var player


func _ready():
    player = get_node("/root/Main/Player")
    %Gem.play()


func _process(delta):
    %HealthBar.value = player.HP
