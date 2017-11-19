module Msgs exposing (..)

import Http
import Models.Slide exposing (Slide)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
  = OnFetchSlides (WebData (List Slide))
  | OnLocationChange Location
  | ChangeLevel Slide Int
  | ChangeTitle Slide String
  | ChangeContent Slide String
  | OnSlideSave (Result Http.Error Slide)