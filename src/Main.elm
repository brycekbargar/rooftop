module Main exposing (..)

import Html
import Svg exposing (..)
import Svg.Attributes exposing (..)


main =
    svg
        [ width "120", height "120", viewBox "0 0 120 120" ]
        [ rect [ x "10", y "10", width "100", height "100" ] [] ]
