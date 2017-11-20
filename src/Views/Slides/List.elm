module Views.Slides.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models.Slide exposing (Slide)
import Routing exposing (editSlidePath, showSlidePath)
import RemoteData exposing (WebData)

view : WebData(List Slide) -> Html Msg
view response =
  div []
    [ nav
    , maybeList response
    ]

maybeList : WebData (List Slide ) -> Html Msg
maybeList response =
  case response of
    RemoteData.NotAsked ->
      text ""
    
    RemoteData.Loading ->
      text "Loading ...."
    
    RemoteData.Success slides ->
      list slides
    
    RemoteData.Failure error ->
      text (toString error)

nav : Html Msg
nav =
  div [ class "clearfix mb2 white bg-black"]
      [ div [ class "left p2" ] [ text "Slides" ] ]

list : List Slide -> Html Msg
list slides =
  div [ class "p2"]
      [ table []
        [ thead []
            [ tr []
              [ th [] [ text "Position"]
              , th [] [ text "Title"]
              , th [] [ text "Actions"]
              ]
            ]
            , tbody [] (List.indexedMap slideRow slides)
        ]
      ]

slideRow : Int -> Slide -> Html Msg
slideRow index slide =
  tr []
    [ td [] [ text (toString index)]
    , td [] [ text slide.title ]
    , td [] 
        [ editBtn slide
        , showBtn slide]
    ]

editBtn : Slide -> Html.Html Msg
editBtn slide =
  let
      path =
        editSlidePath slide.id
  in
      a
        [ class "btn regular"
        , href path
        ]
        [ i [class "fa fa-pencil mr1" ] []]

showBtn : Slide -> Html.Html Msg
showBtn slide =
  let
    path =
      showSlidePath slide.id
  
  in
    a [ class "btn regular"
      , href path
      ]
      [ i [ class "fa fa-eye mr1"] []]