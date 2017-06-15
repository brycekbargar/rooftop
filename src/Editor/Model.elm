module Editor.Model exposing (EditPane, init, StaffPane, LegendPane, StaffLine, LegendLine)

import Task exposing (Task, succeed)
import Infrastructure.Pane exposing (Pane)
import Infrastructure.Msg exposing (Msg)


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


init : EditPane
init =
    EditPane
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
