module Update exposing (..)

import Commands exposing (saveSlideCmd)
import Routing exposing (parseLocation)
import Msgs exposing (Msg(..))
import Models.State exposing (Model)
import Models.Slide exposing (Slide)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchSlides response ->
          ( { model | slides = response}, Cmd.none )

        Msgs.OnLocationChange location ->
          let
              newRoute =
                parseLocation location
          in
              ( {model | route = newRoute }, Cmd.none )
        
        Msgs.ChangeLevel slide howMuch ->
          let
              updatedSlide =
                { slide | position = slide.position + howMuch }
          in
              (model, saveSlideCmd updatedSlide )
        
        Msgs.OnSlideSave (Ok slide) ->
          ( updateSlide model slide, Cmd.none)
        
        Msgs.OnSlideSave (Err error) ->
          (model, Cmd.none)

        Msgs.ChangeTitle slide newTitle ->
          let
              updatedSlide slide =
                { slide | title = newTitle }
          in
              (model, saveSlideCmd (updatedSlide slide) )


        Msgs.ChangeContent slide newContent ->
          let
              updatedSlide slide =
                { slide | content = newContent }
          in
              (model, saveSlideCmd (updatedSlide slide) )

updateSlide : Model -> Slide -> Model
updateSlide model updatedSlide =
  let
      pick currentSlide =
        if updatedSlide.id == currentSlide.id
          then
            updatedSlide
        else
          currentSlide
      
      updateSlideList slides =
        List.map pick slides

      updateSlides =
        RemoteData.map updateSlideList model.slides
  in
      { model | slides = updateSlides }