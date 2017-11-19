module Models.Slide exposing (..)

type alias SlideId =
  String

type alias Slide =
  { id : SlideId
  , title : String
  , position : Int
  , content : String
  }

