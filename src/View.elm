module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (Msg)
import Models.State exposing (Model)
import Models.Slide exposing (SlideId)
import Models.Routes exposing (Route(..))
import Slides.List
import Slides.Edit
import Slides.Show
import RemoteData

view : Model -> Html Msg
view model =
  div []
    [ page model]

page : Model -> Html Msg
page model =
  case model.route of
    Models.Routes.SlidesRoute ->
      Slides.List.view model.slides
    
    Models.Routes.EditSlideRoute id ->
      slideEditPage model id
    
    Models.Routes.ShowSlideRoute id ->
      slideShowPage model id

    Models.Routes.NotFoundRoute ->
      notFoundView

slideShowPage : Model -> SlideId -> Html Msg
slideShowPage model slideId =
  case model.slides of
    RemoteData.NotAsked ->
      text ""

    RemoteData.Loading ->
      text "Slide is loading ..."
    
    RemoteData.Success slides ->
      let
          maybeSlide =
            slides
              |> List.filter (\slide -> slide.id == slideId)
              |> List.head
      in
        case maybeSlide of
          Just slide ->
            Slides.Show.view slide

          Nothing ->
            notFoundView

    RemoteData.Failure err ->
      text (toString err)

slideEditPage : Model -> SlideId -> Html Msg
slideEditPage model slideId =
  case model.slides of
    RemoteData.NotAsked ->
      text ""
    
    RemoteData.Loading ->
      text "Data is Loading ..."

    RemoteData.Success slides ->
      let
          maybeSlide =
          slides
            |> List.filter (\slide -> slide.id == slideId)
            |> List.head
      in
        case maybeSlide of
          Just slide ->
            Slides.Edit.view slide
          
          Nothing ->
            notFoundView
    
    RemoteData.Failure err ->
      text (toString err)

notFoundView : Html msg
notFoundView = 
  div []
    [ text "Not Found"
    ]