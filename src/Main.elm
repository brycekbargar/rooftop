module Main exposing (main)

import Html exposing (Html, program)
import Task
import Svg exposing (Svg, svg)
import Svg.Attributes as Svg
import Window
import Infrastructure.Pane as Pane exposing (Pane, attributify)


type alias Model =
    { pane : Pane
    , edit : EditPane
    }


type alias EditPane =
    { pane : Pane
    , legend : LegendPane
    , staff : StaffPane
    }


type alias StaffPane =
    { pane : Pane
    , lines : List StaffLine
    }


type alias StaffLine =
    { line : Line
    }


type alias LegendPane =
    { pane : Pane
    , lines : List LegendLine
    }


type alias LegendLine =
    { legend : String
    , line : Line
    }


type alias Line =
    { isLedger : Bool
    , isSpace : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model
        (Pane 0 0 0 0)
        (EditPane
            (Pane 0 0 0 0)
            (LegendPane
                (Pane 0 0 0 0)
                [ LegendLine "!" (Line False True)
                , LegendLine "1" (Line True False)
                , LegendLine "@" (Line False True)
                , LegendLine "2" (Line True False)
                , LegendLine "#" (Line False True)
                , LegendLine "3" (Line False False)
                , LegendLine "$" (Line False True)
                , LegendLine "4" (Line False False)
                , LegendLine "%" (Line False True)
                , LegendLine "5" (Line False False)
                , LegendLine "^" (Line False True)
                , LegendLine "6" (Line False False)
                , LegendLine "&" (Line False True)
                , LegendLine "7" (Line False False)
                , LegendLine "*" (Line False True)
                , LegendLine "8" (Line True False)
                , LegendLine "(" (Line False True)
                , LegendLine "9" (Line True False)
                , LegendLine ")" (Line False True)
                ]
            )
            (StaffPane
                (Pane 0 0 0 0)
                [ StaffLine (Line False True)
                , StaffLine (Line True False)
                , StaffLine (Line False True)
                , StaffLine (Line True False)
                , StaffLine (Line False True)
                , StaffLine (Line False False)
                , StaffLine (Line False True)
                , StaffLine (Line False False)
                , StaffLine (Line False True)
                , StaffLine (Line False False)
                , StaffLine (Line False True)
                , StaffLine (Line False False)
                , StaffLine (Line False True)
                , StaffLine (Line False False)
                , StaffLine (Line False True)
                , StaffLine (Line True False)
                , StaffLine (Line False True)
                , StaffLine (Line True False)
                , StaffLine (Line False True)
                ]
            )
        )
    , Task.perform ResizeMsg Window.size
    )


type Msg
    = ResizeMsg Window.Size


view : Model -> Html Msg
view { pane, edit } =
    svg
        (Pane.attributify pane)
        [ drawEditPane edit ]


drawEditPane : EditPane -> Svg Msg
drawEditPane { pane, legend, staff } =
    Svg.g (Pane.attributify pane)
        [ drawLegend legend
        , drawStaff staff
        ]


drawLegend : LegendPane -> Svg Msg
drawLegend { pane, lines } =
    Svg.rect (Pane.attributify pane ++ [ Svg.fill "#fed528" ]) []


drawStaff : StaffPane -> Svg Msg
drawStaff { pane, lines } =
    Svg.rect (Pane.attributify pane ++ [ Svg.fill "#993232" ]) []


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

                legendPane =
                    Pane (max 100 (min 200 (appPane.width * 0.2))) appPane.height 0 0

                oldLegend =
                    model.edit.legend

                legend =
                    { oldLegend | pane = legendPane }

                staffPane =
                    Pane (appPane.width - legendPane.width) appPane.height legendPane.width 0

                oldStaff =
                    model.edit.staff

                staff =
                    { oldStaff | pane = staffPane }

                oldEdit =
                    model.edit

                edit =
                    { oldEdit | pane = appPane, legend = legend, staff = staff }
            in
                ( { model | pane = appPane, edit = edit }, Cmd.none )


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
