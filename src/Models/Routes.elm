module Models.Routes exposing (..)
import Models.Player exposing (PlayerId)

type Route
  = PlayersRoute
  | PlayerRoute PlayerId
  | NotFoundRoute

