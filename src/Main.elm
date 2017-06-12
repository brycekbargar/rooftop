module Main exposing (..)

import Html exposing (Html, program)
import Task
import Svg as Svg exposing (Svg, svg)
import Svg.Attributes exposing (x, y, width, height, fillOpacity)
import Window as W


type alias Model =
    { window : W.Size
    , staff : Staff
    }


type alias Staff =
    { lines : List Line
    }


type alias Line =
    { isLedger : Bool
    , isSpace : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model
        (W.Size 100 1000)
        (Staff
            [ Line False True
            , Line True False
            , Line False True
            , Line True False
            , Line False True
            , Line False False
            , Line False True
            , Line False False
            , Line False True
            , Line False False
            , Line False True
            , Line False False
            , Line False True
            , Line False False
            , Line False True
            , Line True False
            , Line False True
            , Line True False
            , Line False True
            ]
        )
    , Task.perform ResizeMsg W.size
    )


type Msg
    = ResizeMsg W.Size


view : Model -> Html Msg
view model =
    let
        createLine =
            createWindowedLine model.window
    in
        model.staff.lines
            |> List.indexedMap createLine
            |> svg [ width <| toString (model.window.width), height <| toString (model.window.width) ]


createWindowedLine : W.Size -> Int -> Line -> Svg Msg
createWindowedLine size i line =
    Svg.rect
        [ x "0"
        , y <| toString (i * 10)
        , height "10"
        , width <|
            if line.isLedger then
                toString (toFloat (size.width) * 0.05)
            else
                toString (size.width)
        , fillOpacity <|
            if line.isSpace then
                "0.0"
            else
                "1.0"
        ]
        []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ResizeMsg size ->
            ( { model | window = size }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    W.resizes ResizeMsg


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
