class_name SkinDB
extends RefCounted

const ID_DEFAULT = "default"

const IDLE_TEXTURE = preload("res://asset/character/Player/1769939379543.png")
const RECOLOR_SHADER = preload("res://asset/shader/skin_recolor.gdshader")

# "hue" 0.0 - 1.0, "sat" & "val" = pengali
const SKIN = {
	"default": {"nama": "Tapak", "harga": 0, "hue": 0.0, "sat": 1.0, "val": 1.0},
	"biru": {"nama": "Tapak Biru", "harga": 50, "hue": 0.5, "sat": 1.1, "val": 1.05},
	"ungu": {"nama": "Tapak Ungu", "harga": 150, "hue": 0.78, "sat": 1.15, "val": 1.0},
	"emas": {"nama": "Tapak Emas", "harga": 300, "hue": 0.08, "sat": 1.35, "val": 1.15},
}

static var _preview_frames: SpriteFrames

static func daftar() -> Array[String]:
	var ids: Array[String] = []
	for id in SKIN:
		ids.append(str(id))
	return ids

static func ada(id: String) -> bool:
	return SKIN.has(id)

static func info(id: String) -> Dictionary:
	return SKIN.get(id, SKIN[ID_DEFAULT])

static func nama(id: String) -> String:
	return str(info(id)["nama"])

static func harga(id: String) -> int:
	return int(info(id)["harga"])

static func terapkan(node: CanvasItem, id: String) -> void:
	var data := info(id)
	var hue := float(data["hue"])
	var sat := float(data["sat"])
	var val := float(data["val"])

	if is_equal_approx(hue, 0.0) and is_equal_approx(sat, 1.0) and is_equal_approx(val, 1.0):
		node.material = null
		return

	var material := ShaderMaterial.new()
	material.shader = RECOLOR_SHADER
	material.set_shader_parameter("hue_shift", hue)
	material.set_shader_parameter("saturation", sat)
	material.set_shader_parameter("brightness", val)
	node.material = material

# SpriteFrames khusus preview di toko (animasi idle saja).
static func preview_frames() -> SpriteFrames:
	if _preview_frames == null:
		_preview_frames = SpriteFrames.new()
		_preview_frames.remove_animation("default")
		_preview_frames.add_animation("idle")
		_preview_frames.set_animation_speed("idle", 2.5)
		_preview_frames.set_animation_loop("idle", true)

		var jumlah := int(IDLE_TEXTURE.get_width() / 32)
		for i in jumlah:
			var atlas := AtlasTexture.new()
			atlas.atlas = IDLE_TEXTURE
			atlas.region = Rect2(i * 32, 0, 32, 32)
			_preview_frames.add_frame("idle", atlas)

	return _preview_frames
