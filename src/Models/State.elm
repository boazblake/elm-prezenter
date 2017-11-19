module Models.State exposing (..)
import Models.Slide exposing (Slide)
import Models.Routes exposing (Route(..))
import RemoteData exposing (WebData)

type alias Model =
    { slides : WebData (List Slide)
    , route : Route
    }

initialModel : Route -> Model
initialModel route =
  { slides = RemoteData.Loading
  , route = route
  }