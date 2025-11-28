fn view() ->Unit {
  let tilemap :@tilemap.TileMap =@tilemap.TileMap::from_json(tilemap)
  @camera.camera.limit_bottom =Some(tilemap.map_height.to_double()*tilemap.tile_size.to_double())
  @camera.camera.limit_right =Some(tilemap.map_width.to_double()*tilemap.tile_size.to_double())
  @camera.camera.limit_left=Some(0.0)
  @camera.camera.limit_top=Some(0.0)
}