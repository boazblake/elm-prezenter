module Models.Routes exposing (..)
import Models.Slide exposing (SlideId)

type Route
  = SlidesRoute
  | EditSlideRoute SlideId
  | ShowSlideRoute SlideId
  | NextSlideRoute SlideId
  | PrevSlideRoute SlideId
  | NotFoundRoute

