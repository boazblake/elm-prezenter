module Routing exposing (..)

import Navigation exposing (Location)
import Models.Slide exposing (SlideId)
import Models.Routes exposing (Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
  oneOf
    [ map SlidesRoute top
    , map EditSlideRoute (s "edit-slides" </> string)
    , map ShowSlideRoute (s "show-slides" </> string)
    , map SlidesRoute (s "slides")
    ]

parseLocation : Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route

    nothing ->
      NotFoundRoute

slidesPath : String
slidesPath =
  "#slides"

editSlidePath : SlideId -> String
editSlidePath id =
  "#edit-slides/" ++ id

showSlidePath : SlideId -> String
showSlidePath id =
  "#show-slides/" ++ id

nextSlidePath : SlideId  -> String
nextSlidePath id =
  let
      newId =
        toString (Result.withDefault 0 (String.toInt id) + 1)
  in
  "#show-slides/" ++ newId

prevSlidePath : SlideId  -> String
prevSlidePath id =
  let
    newId =
        toString (Result.withDefault 0 (String.toInt id) - 1)
  in
    "#show-slides/" ++ newId