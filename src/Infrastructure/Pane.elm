module Infrastructure.Pane exposing (Pane, attributify)

import Svg exposing (Attribute)
import Svg.Attributes as Svg exposing (x, y, width, height)


type alias Pane =
    { width : Float
    , height : Float
    , x : Float
    , y : Float
    }


attributify : Pane -> List (Attribute msg)
attributify pane =
    size pane ++ position pane ++ transform pane


size : Pane -> List (Attribute msg)
size pane =
    [ width <| toString (pane.width), height <| toString (pane.height) ]


position : Pane -> List (Attribute msg)
position pane =
    [ x <| toString (pane.x), y <| toString (pane.y) ]


transform : Pane -> List (Attribute msg)
transform pane =
    [ Svg.transform ("translate (" ++ toString (pane.x) ++ " " ++ toString (pane.y) ++ ")") ]
