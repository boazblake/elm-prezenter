module Routing exposing (..)

import Navigation exposing (Location)
import Models.Player exposing (PlayerId)
import Models.Routes exposing (Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
  oneOf
    [ map PlayersRoute top
    , map PlayerRoute (s "players" </> string)
    , map PlayersRoute (s "players")
    ]

parseLocation : Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route

    nothing ->
      NotFoundRoute

playersPath : String
playersPath =
  "#players"

playerPath : PlayerId -> String
playerPath id =
  "#players/" ++ id

