module Main exposing (..)

import Html exposing (Html, program)
import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Model =
    { staff : Staff
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
    , Cmd.none
    )


type Msg
    = NA


view : Model -> Html Msg
view model =
    model.staff.lines
        |> List.indexedMap createLine
        |> svg [ width "1000", height "1000", viewBox "0 0 1000 1000" ]


createLine : Int -> Line -> Svg Msg
createLine i line =
    rect
        [ x "0"
        , y <| toString (i * 10)
        , height "10"
        , width <|
            if line.isLedger then
                "50"
            else
                "1000"
        , fillOpacity <|
            if line.isSpace then
                "0.0"
            else
                "1.0"
        ]
        []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
