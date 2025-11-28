fn add_grass(pos : @math.Vec2D,sprite_id:String) -> Unit {
  let entity:@system.Entity =@system.Entity::new()
  @position.positions[entity]=pos
  let offset = match sprite_id {
    "2" => @math.Vec2D::new(96.0, 0.0)
    "0" => @math.Vec2D::new(112.0, 0.0)
    "1" => @math.Vec2D::new(128.0, 0.0)
    "145" => @math.Vec2D::new(96.0, 16.0)
    "146" => @math.Vec2D::new(112.0, 16.0)
    "147" => @math.Vec2D::new(128.0, 16.0)
    "4" => @math.Vec2D::new(96.0,32.0)
    "3" => @math.Vec2D::new(112.0,32.0)
    "5" => @math.Vec2D::new(128.0,32.0)
    _ => panic()
  }
  let animation: @sprite.Animation = @sprite.Animation::new(
      "./Free/Terrain/Terrain (16x16).png",
      max_frame=1,
      height=16,
      width=16,
      offset=offset,
    )
  
  let sprite:@sprite.Sprite =@sprite.Sprite::new_animation(animation,20)
  @sprite.sprites[entity]=sprite
  let collide =@collision.Collide::{
    shape:@collision.CollisionShape::Rect(
      size=@math.Vec2D::new(16.0,16.0),
      offset=@math.Vec2D::new(0.0,0.0),
    ),
    layer:terrain_collision_layer,
    mask:@collision.CollisionMask::empty(),
  }
  @collision.collides[entity] =collide
}


fn add_background(b_w:Double,b_h:Double) ->Unit{
  let picture :@sprite.Picture =@sprite.Picture::new(
    @math.Vec2D::new(b_w,b_h),
    "./Free/Background/Green.png",
    repeat=true,
  )
  let sprite=@sprite.Sprite::new_picture(picture,0)
  let entity=@system.Entity::new()
  @sprite.sprites[entity] =sprite
  @position.positions[entity]=@math.Vec2D::new(0.0,0.0)
}


fn add_map() ->Unit{
    let tilemap :@tilemap.TileMap =@tilemap.TileMap::from_json(tilemap)
    for grass in tilemap.get_tiles("Layer_0"){
      add_grass(
        @math.Vec2D::new(grass.x.to_double()*tilemap.tile_size.to_double(),grass.y.to_double()*tilemap.tile_size.to_double()),
        grass.id
      )
    }
    add_background(tilemap.map_width.to_double()*tilemap.tile_size.to_double(),tilemap.map_height.to_double()*tilemap.tile_size.to_double())
}