module Editor.View exposing (view)

import Svg exposing (Svg)
import Svg.Attributes as Svg exposing (x, y, width, height)
import Infrastructure.Msg exposing (Msg)
import Infrastructure.Pane as Pane
import Editor.Model exposing (EditPane, StaffPane, StaffLine, LegendPane, LegendLine)


view : EditPane -> Svg Msg
view { pane, legend, staff } =
    Svg.g (Pane.attributify pane)
        [ drawLegend legend
        , drawStaff staff
        ]


drawLegend : LegendPane -> Svg Msg
drawLegend { pane, lines } =
    let
        createLegendRow =
            createSizedLegendRow { width = pane.width, height = pane.height / (toFloat (List.length lines)) }
    in
        Svg.g
            (Pane.attributify pane)
            (List.indexedMap createLegendRow lines)


createSizedLegendRow : { width : Float, height : Float } -> Int -> LegendLine -> Svg Msg
createSizedLegendRow size index line =
    Svg.rect
        [ width <| toString size.width
        , height <| toString size.height
        , x "0"
        , y <| toString (toFloat (index) * size.height)
        , Svg.fill <|
            if index % 2 == 0 then
                "#fed528"
            else
                "#993232"
        ]
        []


drawStaff : StaffPane -> Svg Msg
drawStaff { pane, lines } =
    let
        createStaffRow =
            createSizedStaffRow { width = pane.width, height = pane.height / (toFloat (List.length lines)) }
    in
        Svg.g
            (Pane.attributify pane)
            (List.indexedMap createStaffRow lines)


createSizedStaffRow : { width : Float, height : Float } -> Int -> StaffLine -> Svg Msg
createSizedStaffRow size index line =
    Svg.rect
        [ width <| toString size.width
        , height <| toString size.height
        , x "0"
        , y <| toString (toFloat (index) * size.height)
        , Svg.fill <|
            if index % 2 == 0 then
                "#993232"
            else
                "#fed528"
        ]
        []
