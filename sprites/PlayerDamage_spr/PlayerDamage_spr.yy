{
  "$GMSprite":"",
  "%Name":"PlayerDamage_spr",
  "bboxMode":0,
  "bbox_bottom":25,
  "bbox_left":3,
  "bbox_right":19,
  "bbox_top":4,
  "collisionKind":1,
  "collisionTolerance":0,
  "DynamicTexturePage":false,
  "edgeFiltering":false,
  "For3D":false,
  "frames":[
    {"$GMSpriteFrame":"","%Name":"f5c88ccb-fdf7-42d1-8ffa-d194bdf25413","name":"f5c88ccb-fdf7-42d1-8ffa-d194bdf25413","resourceType":"GMSpriteFrame","resourceVersion":"2.0",},
    {"$GMSpriteFrame":"","%Name":"1c7c8a0d-9b45-4a6a-b548-99d043d04cb5","name":"1c7c8a0d-9b45-4a6a-b548-99d043d04cb5","resourceType":"GMSpriteFrame","resourceVersion":"2.0",},
    {"$GMSpriteFrame":"","%Name":"8d474084-1726-4f02-beb0-f8aa5a0f58c7","name":"8d474084-1726-4f02-beb0-f8aa5a0f58c7","resourceType":"GMSpriteFrame","resourceVersion":"2.0",},
  ],
  "gridX":0,
  "gridY":0,
  "height":28,
  "HTile":false,
  "layers":[
    {"$GMImageLayer":"","%Name":"35a8a6b8-2d6d-4535-b3bd-55adb65d1541","blendMode":0,"displayName":"default","isLocked":false,"name":"35a8a6b8-2d6d-4535-b3bd-55adb65d1541","opacity":100.0,"resourceType":"GMImageLayer","resourceVersion":"2.0","visible":true,},
  ],
  "name":"PlayerDamage_spr",
  "nineSlice":null,
  "origin":9,
  "parent":{
    "name":"Player",
    "path":"folders/Sprites/Player.yy",
  },
  "preMultiplyAlpha":false,
  "resourceType":"GMSprite",
  "resourceVersion":"2.0",
  "sequence":{
    "$GMSequence":"",
    "%Name":"PlayerDamage_spr",
    "autoRecord":true,
    "backdropHeight":768,
    "backdropImageOpacity":0.5,
    "backdropImagePath":"",
    "backdropWidth":1366,
    "backdropXOffset":0.0,
    "backdropYOffset":0.0,
    "events":{
      "$KeyframeStore<MessageEventKeyframe>":"",
      "Keyframes":[
        {"$Keyframe<MessageEventKeyframe>":"","Channels":{
            "0":{"$MessageEventKeyframe":"","Events":[
                "Respira",
              ],"resourceType":"MessageEventKeyframe","resourceVersion":"2.0",},
          },"Disabled":false,"id":"ca9d7cab-fb41-40fc-ae54-855cfa9ce114","IsCreationKey":false,"Key":1.0,"Length":1.0,"resourceType":"Keyframe<MessageEventKeyframe>","resourceVersion":"2.0","Stretch":false,},
        {"$Keyframe<MessageEventKeyframe>":"","Channels":{
            "0":{"$MessageEventKeyframe":"","Events":[
                "StopTakingDamage",
              ],"resourceType":"MessageEventKeyframe","resourceVersion":"2.0",},
          },"Disabled":false,"id":"7c7ebed2-ca5b-4866-9a43-391672f7b2aa","IsCreationKey":false,"Key":2.0,"Length":1.0,"resourceType":"Keyframe<MessageEventKeyframe>","resourceVersion":"2.0","Stretch":false,},
      ],
      "resourceType":"KeyframeStore<MessageEventKeyframe>",
      "resourceVersion":"2.0",
    },
    "eventStubScript":null,
    "eventToFunction":{},
    "length":3.0,
    "lockOrigin":false,
    "moments":{
      "$KeyframeStore<MomentsEventKeyframe>":"",
      "Keyframes":[],
      "resourceType":"KeyframeStore<MomentsEventKeyframe>",
      "resourceVersion":"2.0",
    },
    "name":"PlayerDamage_spr",
    "playback":1,
    "playbackSpeed":7.0,
    "playbackSpeedType":0,
    "resourceType":"GMSequence",
    "resourceVersion":"2.0",
    "showBackdrop":true,
    "showBackdropImage":false,
    "timeUnits":1,
    "tracks":[
      {"$GMSpriteFramesTrack":"","builtinName":0,"events":[],"inheritsTrackColour":true,"interpolation":1,"isCreationTrack":false,"keyframes":{"$KeyframeStore<SpriteFrameKeyframe>":"","Keyframes":[
            {"$Keyframe<SpriteFrameKeyframe>":"","Channels":{
                "0":{"$SpriteFrameKeyframe":"","Id":{"name":"f5c88ccb-fdf7-42d1-8ffa-d194bdf25413","path":"sprites/PlayerDamage_spr/PlayerDamage_spr.yy",},"resourceType":"SpriteFrameKeyframe","resourceVersion":"2.0",},
              },"Disabled":false,"id":"346f33b3-77ee-449f-adf1-c445ce0ff321","IsCreationKey":false,"Key":0.0,"Length":1.0,"resourceType":"Keyframe<SpriteFrameKeyframe>","resourceVersion":"2.0","Stretch":false,},
            {"$Keyframe<SpriteFrameKeyframe>":"","Channels":{
                "0":{"$SpriteFrameKeyframe":"","Id":{"name":"1c7c8a0d-9b45-4a6a-b548-99d043d04cb5","path":"sprites/PlayerDamage_spr/PlayerDamage_spr.yy",},"resourceType":"SpriteFrameKeyframe","resourceVersion":"2.0",},
              },"Disabled":false,"id":"3d60737e-5493-440e-bcea-4556f65c5c3e","IsCreationKey":false,"Key":1.0,"Length":1.0,"resourceType":"Keyframe<SpriteFrameKeyframe>","resourceVersion":"2.0","Stretch":false,},
            {"$Keyframe<SpriteFrameKeyframe>":"","Channels":{
                "0":{"$SpriteFrameKeyframe":"","Id":{"name":"8d474084-1726-4f02-beb0-f8aa5a0f58c7","path":"sprites/PlayerDamage_spr/PlayerDamage_spr.yy",},"resourceType":"SpriteFrameKeyframe","resourceVersion":"2.0",},
              },"Disabled":false,"id":"df73e37d-af16-4c79-91e5-268a8a66c61b","IsCreationKey":false,"Key":2.0,"Length":1.0,"resourceType":"Keyframe<SpriteFrameKeyframe>","resourceVersion":"2.0","Stretch":false,},
          ],"resourceType":"KeyframeStore<SpriteFrameKeyframe>","resourceVersion":"2.0",},"modifiers":[],"name":"frames","resourceType":"GMSpriteFramesTrack","resourceVersion":"2.0","spriteId":null,"trackColour":0,"tracks":[],"traits":0,},
    ],
    "visibleRange":null,
    "volume":1.0,
    "xorigin":11,
    "yorigin":11,
  },
  "swatchColours":null,
  "swfPrecision":0.5,
  "textureGroupId":{
    "name":"Default",
    "path":"texturegroups/Default",
  },
  "type":0,
  "VTile":false,
  "width":23,
}