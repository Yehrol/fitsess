port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


port setStorage : Model -> Cmd msg



-- ========================================================================== --
--                                    MODEL                                   --
-- ========================================================================== --


type alias Flags =
    { maybeModel : Maybe Model }


type alias Model =
    { date : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Maybe.withDefault { date = "1970-01-01" } flags.maybeModel
    , Cmd.none
    )



-- ========================================================================== --
--                                   UPDATE                                   --
-- ========================================================================== --


type Msg
    = NoOp
    | SetStorage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SetStorage ->
            ( model, setStorage (Model "2025.04.25") )



-- ========================================================================== --
--                                    VIEW                                    --
-- ========================================================================== --


view : Model -> Browser.Document Msg
view model =
    { title = "Elm - Capacitor"
    , body =
        [ div
            [ style "background-color" "blue"
            , style "height" "1000px"
            , style "width" "100%"
            , style "margin-top" "20px" -- for testing
            ]
            [ div
                [ style "background-color" "red"
                , style "height" "100px"
                , style "width" "100px"
                ]
                [ button
                    [ onClick SetStorage
                    , style "background-color" "green"
                    , style "height" "100px"
                    , style "width" "100px"
                    ]
                    [ text model.date ]
                ]
            ]
        ]
    }



-- ========================================================================== --
--                                    MAIN                                    --
-- ========================================================================== --


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
