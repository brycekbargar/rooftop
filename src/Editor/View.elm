module Editor.View exposing (view)

import Svg exposing (Svg)
import Svg.Attributes as Svg
import Infrastructure.Msg exposing (Msg)
import Infrastructure.Pane as Pane
import Editor.Model exposing (EditPane, StaffPane, LegendPane)


view : EditPane -> Svg Msg
view { pane, legend, staff } =
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
