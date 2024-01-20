extends CanvasLayer


var player
var container


func _ready():
    player = get_node("/root/Main/Player")
    container = get_child(0)
    get_viewport().connect("size_changed", self._on_viewport_size_changed)
    _resize_background()
    %Gem.play()


func _process(delta):
    %HealthBar.value = player.HP


func _resize_background():
    var viewport_size = get_viewport().size

    var scale_x = viewport_size.x / 480.0
    var scale_y = viewport_size.y / 330.0
    var ratio = scale_x / scale_y
    
    var s
    if ratio > 2:
        s = scale_y * 2
    elif ratio < 0.75:
        s = scale_x / 0.75
    else:
        s = max(scale_x, scale_y)
    for child in container.get_children():
        child.scale = Vector2(s, s)


func _on_viewport_size_changed():
    _resize_background()
