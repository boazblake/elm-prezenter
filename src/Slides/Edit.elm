module Slides.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href, placeholder)
import Html.Events exposing (onClick, onInput)
import Msgs exposing (Msg)
import Models.Slide exposing (Slide)
import Routing exposing (slidesPath)

view : Slide -> Html Msg
view model =
  div []
    [ nav model
    , form model
    ]

nav : Slide -> Html Msg
nav model =
  div [ class "clearfix mb2 white bg-black p1" ]
      [ listBtn ]

listBtn : Html Msg
listBtn =
  a
    [ class "btn regular"
    , href slidesPath
    ]
    [ i [ class "fa fa-chevron-left mr1"] [], text "List"]





form : Slide -> Html Msg
form slide =
  div [ class "m3" ]
      [ h1 [] [text slide.title]
      , formLevel slide
      , formTitle slide
      , formContent slide
      ]

formLevel : Slide -> Html Msg
formLevel slide =
  div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-5" ] [ text "Slide Position" ]
    , div [ class "col col-7" ]
        [ span [ class "h2 bold" ] [ text (toString slide.position) ]
        , btnLevelDecrease slide
        , btnLevelIncrease slide
        ]
    ]

btnLevelDecrease : Slide -> Html Msg
btnLevelDecrease slide =
  let
    message = Msgs.ChangeLevel slide -1      
  in
      a [ class "btn ml1 h1", onClick message ]
        [ i [ class "fa fa-minus-circle"  ] []  ]

btnLevelIncrease : Slide -> Html Msg
btnLevelIncrease slide =
  let
      message = Msgs.ChangeLevel slide 1
  in
    a [ class "btn ml1 h1", onClick message ]
      [ i [ class "fa fa-plus-circle" ] [] ]

formTitle : Slide -> Html Msg
formTitle slide =
  div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-5" ] [ text "Title" ]
    , div [ class "col col-7" ]
        [ span [] [ updateTitle slide ]
        ]
    ]

updateTitle : Slide -> Html Msg
updateTitle slide =
  let
    message = Msgs.ChangeTitle slide 
  in
    div []
      [ input [ placeholder "Update Slide Title", onInput message ] []
      ]


formContent : Slide -> Html Msg
formContent slide =
    div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-5" ] [ text "CONTENT" ]
    , div [ class "col col-7" ]
        [ updateContent slide ]
        , (text slide.content)
    ]

updateContent : Slide -> Html Msg
updateContent slide =
  let
      message = Msgs.ChangeContent slide
  in
          div []
      [ textarea [ placeholder "Update Slide Content", onInput message ] [] 
      ]
      