extends TextureRect

var IMAGE_X = 500
var IMAGE_Y = 500
var IMAGE_SIZE = Vector2i(IMAGE_X,IMAGE_Y)

@export_range(0.1,1,0.02) var wobble = 0.2
@export_range(0,200,1) var coreSize = 30
@export_range(0,1,0.01) var frequency = 0.033
@export_range(1,100,1) var sineThickness = 30

var SEED = "1"

func _generate():
	var Generated : Image = Image.create(IMAGE_X,IMAGE_Y,false,Image.FORMAT_RGBA8)
	Generated.fill(Color.WHITE)
	
	var noise = FastNoiseLite.new()
	noise.seed = int(SEED)
	
	for X in range(IMAGE_X):
		for Y in range(IMAGE_Y):
			
			Generated.set_pixel(X,Y,getPixelColor(X,Y,noise))
	
	return Generated

func getPixelColor(X : int ,Y : int, noise : FastNoiseLite) -> Color:
	
	var color := Color.WHITE
	
	var middlepoint = IMAGE_SIZE/2
	var distMiddlePoint = Vector2i(X,Y).distance_to(middlepoint)
	
	# STEP 0 -- centerdistortion
	if distMiddlePoint >= coreSize + 5 and distMiddlePoint <= coreSize * 2.0:
		X += 3
		Y += 3
	
	# STEP 1 --- BACKGROUND
	
	var xwaveYlevel = (sin(X*frequency) * (IMAGE_X/3.0)) + (IMAGE_X/2)
	
	if abs(xwaveYlevel - Y) <= sineThickness and noise.get_noise_2d(X,Y) >= 0.1:
		color = Color.PURPLE
	
	
	
	
	# STEP 2 ----- CORE GENERATION
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
	
