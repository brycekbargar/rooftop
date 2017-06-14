module Main exposing (main)

import Html exposing (Html, program)
import Task
import Svg exposing (Svg, svg)
import Window
import Infrastructure.Msg as Msg exposing (..)
import Infrastructure.Pane as Pane exposing (Pane)
import Editor.Model as Editor exposing (EditPane)
import Editor.View as Editor
import Editor.Update as Editor


type alias Model =
    { pane : Pane
    , edit : EditPane
    }


init : ( Model, Cmd Msg )
init =
    ( Model
        (Pane 0 0 0 0)
        Editor.init
    , Task.perform ResizeMsg Window.size
    )


view : Model -> Html Msg
view { pane, edit } =
    svg
        (Pane.attributify pane)
        [ Editor.view edit ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ResizeMsg size ->
            let
                width =
                    toFloat size.width

                height =
                    toFloat size.height

                appPane =
                    Pane (width * 0.98) (height * 0.98) 0 0

                ( edit, editCmd ) =
                    Editor.resizeMsg appPane model.edit
            in
                ( { model | pane = appPane, edit = edit }, Cmd.batch [ editCmd ] )


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes ResizeMsg


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
