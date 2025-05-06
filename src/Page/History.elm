module Page.History exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Internal.Actions exposing (Action(..), Route(..))



-- ========================================================================== --
--                                    MODEL                                   --
-- ========================================================================== --


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( Model
    , Cmd.none
    )



-- ========================================================================== --
--                                   UPDATE                                   --
-- ========================================================================== --


type Msg
    = NoOp
    | GoBack
    | GoToHistorySession


update : Msg -> Model -> ( Model, Cmd Msg, List Action )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none, [] )

        GoBack ->
            ( model, Cmd.none, [ GoToRoute Home ] )

        GoToHistorySession ->
            ( model, Cmd.none, [ GoToRoute HistorySession ] )



-- ========================================================================== --
--                                    VIEW                                    --
-- ========================================================================== --


view : Model -> Html Msg
view model =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "background-color" "violet"
        , style "height" "100%"
        , style "width" "100%"
        ]
        [ button
            [ onClick GoBack
            ]
            [ text "Go Back" ]
        , button
            [ onClick GoToHistorySession
            ]
            [ text "Session xxx" ]
        ]
