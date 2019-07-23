module ImgIX.Internals.Color exposing (Alpha, Color, toHex, toHexAlpha, toRgba)

import Color as Color exposing (Color, toRgba)


{-| The Color Type
-}
type alias Color =
    Color.Color


type alias Alpha =
    Float


{-| Converts a color to a rgba record.
-}
toRgba : Color -> { red : Float, green : Float, blue : Float, alpha : Float }
toRgba =
    Color.toRgba


{-| Converts a color to a hexadecimal string.
-}
toHex : Color -> String
toHex color =
    let
        { red, green, blue } =
            toRgba color
    in
    List.map intToHex [ round red, round green, round blue ]
        |> String.join ""


{-| Converts a color to a hexadecimal string maintaining the alpha channel.
-}
toHexAlpha : Color -> String
toHexAlpha color =
    let
        { red, green, blue, alpha } =
            toRgba color
    in
    List.map intToHex [ round (alpha * 255), round red, round green, round blue ]
        |> String.join ""



-- Helpers


intToHex : Int -> String
intToHex =
    intToRadix >> String.padLeft 2 '0'


intToRadix : Int -> String
intToRadix n =
    let
        getChr c =
            if c < 10 then
                String.fromInt c

            else
                String.fromChar <| Char.fromCode (87 + c)
    in
    if n < 16 then
        getChr n

    else
        intToRadix (n // 16) ++ getChr (modBy 16 n)
