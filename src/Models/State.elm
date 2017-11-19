module Models.State exposing (..)
import Models.Player exposing (Player)
import Models.Routes exposing (Route(..))
import RemoteData exposing (WebData)

type alias Model =
    { players : WebData (List Player)
    , route : Route
    }

initialModel : Route -> Model
initialModel route =
  { players = RemoteData.Loading
  , route = route
  }