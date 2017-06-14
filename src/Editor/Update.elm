module Editor.Update exposing (resizeMsg)

import Infrastructure.Msg exposing (Msg)
import Infrastructure.Pane exposing (Pane)
import Editor.Model exposing (EditPane)


resizeMsg : Pane -> EditPane -> ( EditPane, Cmd Msg )
resizeMsg editPane oldEdit =
    let
        legendPane =
            Pane (max 100 (min 200 (editPane.width * 0.2))) editPane.height 0 0

        oldLegend =
            oldEdit.legend

        legend =
            { oldLegend | pane = legendPane }

        staffPane =
            Pane (editPane.width - legendPane.width) editPane.height legendPane.width 0

        oldStaff =
            oldEdit.staff

        staff =
            { oldStaff | pane = staffPane }
    in
        ( { oldEdit | pane = editPane, legend = legend, staff = staff }, Cmd.none )
