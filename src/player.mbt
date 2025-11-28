struct GameState{
  player_entity : @system.Entity
  mut player_state :PlayerState
  mut player_direction:Direction2
  mut volume_1:Double
  information_box:@sprite.Text
}

enum Direction2{
  Left
  Right
}
enum PlayerState{
    Idle
    Frog_Jump
    // Fall
    Bee
    Frog
}
let game_state :GameState ={ player_entity:@system.Entity::new(),
player_state:PlayerState::Idle,
player_direction:Direction2::Right,
volume_1:1,
information_box:@sprite.Text::new(
    "按J变身青蛙可以跳跃，按空格变身蜜蜂可以飞行",
    font="20px ThaleahFat",
    color="red",
  )}

let player_idle_animation:@sprite.Animation = @sprite.Animation::new(
      "./Free/Main Characters/Ninja Frog/Idle (32x32).png",
      max_frame=11,
      height=32,
      width=32,
      loop_=true,
    )

let player_run_animation:@sprite.Animation = @sprite.Animation::new(
      "./Free/Main Characters/Ninja Frog/Run (32x32).png",
      max_frame=12,
      height=32,
      width=32,
      loop_=true,
    )

// let player_jump_animation:@sprite.Animation = @sprite.Animation::new(
//       "./Free/Main Characters/Ninja Frog/Jump (32x32).png",
//       max_frame=1,
//       height=32,
//       width=32,
//       loop_=true,
//     )

// let player_fall_animation:@sprite.Animation = @sprite.Animation::new(
//       "./Free/Main Characters/Ninja Frog/Fall (32x32).png",
//       max_frame=1,
//       height=32,
//       width=32,
//       loop_=true,
//     )
let player_bee_animation:@sprite.Animation = @sprite.Animation::new(
      "./Free/bee/bee_d.png",
      max_frame=2,
      height=64,
      width=64,
      loop_=true,
    )
let player_frog_animation:@sprite.Animation = @sprite.Animation::new(
      "./Free/frog/frog_idle_1.png",
      max_frame=1,
      height=64,
      width=64,
      loop_=true,
    )
let player_frog_jump_animation:@sprite.Animation = @sprite.Animation::new(
      "./Free/frog/frog_jump_1.png",
      max_frame=1,
      height=64,
      width=64,
      loop_=true,
    )


fn add_player(pos_x:Double,pos_y:Double) -> Unit{
    
    let position: @math.Vec2D =@math.Vec2D::new(pos_x,pos_y)
    @position.positions[game_state.player_entity]=position
    let velocity :@math.Vec2D =@math.Vec2D::new(0.0,0.0)
    @velocity.velocities[game_state.player_entity] =velocity

    let sprite:@sprite.Sprite =@sprite.Sprite::new_animation(player_idle_animation,10)
    @sprite.sprites[game_state.player_entity]=sprite
    let collide:@collision.Collide=@collision.Collide::{
    shape :@collision.CollisionShape::Rect(
      size=@math.Vec2D::new(32.0,32.0),
      offset=@math.Vec2D::new(0.0,0.0),
    ),
    layer : player_collision_layer,
    mask:@collision.CollisionMask::new([terrain_collision_layer]),
  }
  @collision.collides[game_state.player_entity]=collide
  @camera.camera.attached_entity =Some(game_state.player_entity)
}
const GRAVITY :Double=0.5
const JUMP_V :Double=15.0

let player_collision_layer :@collision.CollisionLayer=@collision.CollisionLayer::new()

let terrain_collision_layer :@collision.CollisionLayer =@collision.CollisionLayer::new()

fn player_input_system(backend:&@system.Backend)-> Unit{

  let velocity:@velocity.Velocity =@velocity.velocities.get(game_state.player_entity).unwrap()
  
  if @system.is_pressed(@system.Code::KeyA){
       velocity.x=-5.0
       game_state.player_direction=Left
    }else if @system.is_pressed(@system.Code::KeyD){
       velocity.x=5.0
       game_state.player_direction=Right
    }else{
       velocity.x=0.0
    }


  
  
  let transform:@math.Transform? =Some(
    match game_state.player_direction{
      Left => @math.Transform::flip_x(32.0)
      Right =>@math.Transform::new()
    },
  )

  
  match game_state.player_state{
    Idle =>{
      if velocity.x ==0.0{
          @sprite.play_animation(game_state.player_entity,player_idle_animation,transform~)
      }else{
          @sprite.play_animation(game_state.player_entity,player_run_animation,transform~)
      }

      // if @collision.is_on_the_floor(game_state.player_entity)&&
      // @system.is_just_pressed(ArrowUp){
      //   game_state.player_state =Jump
      //   backend.play_audio("./brackeys_platformer_assets/sounds/jump.wav",volume=game_state.volume_1,loop_=false)
      //   velocity.y= -JUMP_V
      // }

      if @collision.is_on_the_floor(game_state.player_entity) &&  @system.is_just_pressed(Space){
        @position.positions[game_state.player_entity].y-=32
         game_state.player_state=Bee
         let collide:@collision.Collide=@collision.Collide::{
      shape :@collision.CollisionShape::Rect(
      size=@math.Vec2D::new(64.0,64.0),
      offset=@math.Vec2D::new(0.0,0.0),
      ),
      layer : player_collision_layer,
      mask:@collision.CollisionMask::new([terrain_collision_layer]),
      }
      @collision.collides[game_state.player_entity]=collide


      }

      if @collision.is_on_the_floor(game_state.player_entity) &&  @system.is_just_pressed(KeyJ){
        @position.positions[game_state.player_entity].y-=32
         game_state.player_state=Frog
         let collide:@collision.Collide=@collision.Collide::{
      shape :@collision.CollisionShape::Rect(
      size=@math.Vec2D::new(64.0,64.0),
      offset=@math.Vec2D::new(0.0,0.0),
      ),
      layer : player_collision_layer,
      mask:@collision.CollisionMask::new([terrain_collision_layer]),
      }
      @collision.collides[game_state.player_entity]=collide

      }

      
    }
    

    Frog_Jump => {
      @sprite.play_animation(
        game_state.player_entity,
        player_frog_jump_animation,
        transform~
      )
      // if velocity.y>0.0{
      //   game_state.player_state =Fall
      // }
      if @collision.is_on_the_floor(game_state.player_entity){
        game_state.player_state=Frog
        velocity.y=0.0
      } 
    }

    // Fall => {
    //   @sprite.play_animation(
    //     game_state.player_entity,
    //     player_fall_animation,
    //     transform~
    //   )
    //   if @collision.is_on_the_floor(game_state.player_entity){
    //     game_state.player_state=Idle
    //     velocity.y=0.0
    //   }
    // }
    
    Bee =>{
      @sprite.play_animation(
        game_state.player_entity,
        player_bee_animation,
        transform~,
      )
      velocity.y-=GRAVITY

      if @system.is_just_pressed(Space){
        game_state.player_state=Idle
        let collide:@collision.Collide=@collision.Collide::{
      shape :@collision.CollisionShape::Rect(
      size=@math.Vec2D::new(32.0,32.0),
      offset=@math.Vec2D::new(0.0,0.0),
      ),
      layer : player_collision_layer,
      mask:@collision.CollisionMask::new([terrain_collision_layer]),
      }
      @collision.collides[game_state.player_entity]=collide
      }
    }

    Frog =>{
      @sprite.play_animation(
        game_state.player_entity,
        player_frog_animation,
        transform~
      )
      if @collision.is_on_the_floor(game_state.player_entity)&&
      @system.is_just_pressed(KeyW){
        game_state.player_state = Frog_Jump
        backend.play_audio("./brackeys_platformer_assets/sounds/jump.wav",volume=game_state.volume_1,loop_=false)
        velocity.y= -JUMP_V
      }
     


      if @system.is_just_pressed(KeyJ){
        game_state.player_state=Idle
        let collide:@collision.Collide=@collision.Collide::{
      shape :@collision.CollisionShape::Rect(
      size=@math.Vec2D::new(32.0,32.0),
      offset=@math.Vec2D::new(0.0,0.0),
      ),
      layer : player_collision_layer,
      mask:@collision.CollisionMask::new([terrain_collision_layer]),
      }
      @collision.collides[game_state.player_entity]=collide
      }
    }

  }


  velocity.y+=GRAVITY
  
}




fn add_information_box()-> Unit {
  let entity:@system.Entity =@system.Entity::new()
  let position : @math.Vec2D=@math.Vec2D::new(60.0,60.0)
  @position.positions[entity]=position
  
  let sprite :@sprite.Sprite =@sprite.Sprite::new_text(game_state.information_box,100)
  @sprite.sprites[entity] =sprite
  @camera.uis[entity]=@camera.Ui::new()
}


fn add_player_1() ->Unit{
    let tilemap :@tilemap.TileMap =@tilemap.TileMap::from_json(tilemap)
    let player_pos:@tilemap.Tile =tilemap.get_tiles_leftcorner("player")[0]
    add_player(player_pos.x.to_double() * tilemap.tile_size.to_double(),player_pos.y.to_double() * tilemap.tile_size.to_double())
}