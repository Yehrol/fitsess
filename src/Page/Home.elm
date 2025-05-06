module Page.Home exposing (..)

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
    | GoToEditSession
    | GoToNewExercise
    | GoToHistory


update : Msg -> Model -> ( Model, Cmd Msg, List Action )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none, [] )

        GoToEditSession ->
            ( model, Cmd.none, [ GoToRoute EditSession ] )

        GoToNewExercise ->
            ( model, Cmd.none, [ GoToRoute NewExercise ] )

        GoToHistory ->
            ( model, Cmd.none, [ GoToRoute History ] )



-- ========================================================================== --
--                                    VIEW                                    --
-- ========================================================================== --


view : Model -> Html Msg
view model =
    div
        [ style "background-color" "red"
        , style "height" "100%"
        , style "width" "100%"
        ]
        [ button
            [ onClick GoToEditSession
            ]
            [ text "New session" ]
        , button
            [ onClick GoToNewExercise
            ]
            [ text "Add an exercise" ]
        , button
            [ onClick GoToHistory
            ]
            [ text "History" ]
        ]
