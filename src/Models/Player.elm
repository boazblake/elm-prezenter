module Models.Player exposing (..)

type alias PlayerId =
  String

type alias Player =
  { id : PlayerId
  , name : String
  , level : Int
  }

