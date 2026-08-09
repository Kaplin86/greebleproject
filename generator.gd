extends TextureRect

var IMAGE_X = 500
var IMAGE_Y = 500
var IMAGE_SIZE = Vector2i(IMAGE_X,IMAGE_Y)

@export_range(0.1,1,0.02) var wobble = 0.2
@export_range(0,200,1) var coreSize = 30

func _generate():
	var Generated : Image = Image.create(IMAGE_X,IMAGE_Y,false,Image.FORMAT_RGBA8)
	Generated.fill(Color.WHITE)
	
	for X in range(IMAGE_X):
		for Y in range(IMAGE_Y):
			
			Generated.set_pixel(X,Y,getPixelColor(X,Y))
	
	return Generated

func getPixelColor(X : int ,Y : int) -> Color:
	var color := Color.WHITE
	
	var middlepoint = IMAGE_SIZE/2
	var distMiddlePoint = Vector2i(X,Y).distance_to(middlepoint)
	distMiddlePoint -= sin(X+Y * wobble) * (1/max(0.001,wobble))
	
	if distMiddlePoint <= coreSize:
		color = Color.BEIGE
	elif distMiddlePoint <= coreSize + 5:
		color = Color.BLACK
	
	return color

func _ready():
	_generate_full()

func _generate_full():
	var img : Image =  _generate()
	texture = ImageTexture.create_from_image(img)
	
