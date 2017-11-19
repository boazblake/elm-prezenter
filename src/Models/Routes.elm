module Models.Routes exposing (..)
import Models.Slide exposing (SlideId)

type Route
  = SlidesRoute
  | EditSlideRoute SlideId
  | ShowSlideRoute SlideId
  | NotFoundRoute

