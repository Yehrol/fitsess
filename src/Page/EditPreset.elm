module Page.EditPreset exposing (..)

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


update : Msg -> Model -> ( Model, Cmd Msg, List Action )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none, [] )

        GoBack ->
            ( model, Cmd.none, [ GoToRoute Home ] )



-- ========================================================================== --
--                                    VIEW                                    --
-- ========================================================================== --


view : Model -> Html Msg
view model =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "align-items" "center"
        , style "justify-content" "center"
        , style "gap" "20px"
        , style "height" "100%"
        , style "width" "100%"
        , style "background-color" "orange"
        ]
        [ button
            [ onClick GoBack
            ]
            [ text "Go Back" ]
        ]
