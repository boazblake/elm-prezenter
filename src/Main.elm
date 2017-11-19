module Main exposing (..)

import Msgs exposing (Msg)
import Models.State exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Commands exposing (fetchPlayers)
import Navigation exposing (Location)
import Routing



---- INIT STATE ----

init : Location -> ( Model, Cmd Msg )
init location =
  let
      currentRoute =
        Routing.parseLocation location
  in
    ( initialModel currentRoute, fetchPlayers )


---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
