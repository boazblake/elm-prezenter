module Commands exposing (..)


import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models.Slide exposing (SlideId, Slide)
import RemoteData

-----FETCH----------------
fetchSlides : Cmd Msg
fetchSlides =
  Http.get fetchSlidesUrl slidesDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchSlides

fetchSlidesUrl : String
fetchSlidesUrl =
  "http://localhost:4000/slides"

slidesDecoder : Decode.Decoder (List Slide)
slidesDecoder = Decode.list slideDecoder

slideDecoder : Decode.Decoder Slide
slideDecoder =
  decode Slide
    |> required "id" Decode.string
    |> required "title" Decode.string
    |> required "position" Decode.int
    |> required "content" Decode.string


-----SAVE -----------------------------
saveSlideUrl : SlideId -> String
saveSlideUrl slideId =
  "http://localhost:4000/slides/" ++ slideId

saveSlideRequest : Slide -> Http.Request Slide
saveSlideRequest slide =
  Http.request
    { body = slideEncoder slide|> Http.jsonBody
    , expect = Http.expectJson slideDecoder
    , headers = []
    , method = "PATCH"
    , timeout = Nothing
    , url = saveSlideUrl slide.id
    , withCredentials = False
    }

saveSlideCmd : Slide -> Cmd Msg
saveSlideCmd slide =
  saveSlideRequest slide
    |>Http.send Msgs.OnSlideSave

slideEncoder : Slide -> Encode.Value
slideEncoder slide =
  let
      attributes =
        [ ("id", Encode.string slide.id)
        , ("title", Encode.string slide.title)
        , ("position", Encode.int slide.position)
        , ("content", Encode.string slide.content)
        ]
  in
      Encode.object attributes