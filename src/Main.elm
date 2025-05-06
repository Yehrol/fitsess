module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Internal.Actions as Actions
import Page.EditSession as EditSession
import Page.History as History
import Page.HistorySession as HistorySession
import Page.Home as Home
import Page.NewExercise as NewExercise



-- port setStorage : Model -> Cmd msg
-- ========================================================================== --
--                                    MODEL                                   --
-- ========================================================================== --


type alias Flags =
    {}


type Model
    = Home Home.Model
    | EditSession EditSession.Model
    | NewExercise NewExercise.Model
    | History History.Model
    | HistorySession HistorySession.Model


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        ( homeModel, homeCmd ) =
            Home.init
    in
    updateWith Home GotHomeMsg ( homeModel, homeCmd )



-- ========================================================================== --
--                                   UPDATE                                   --
-- ========================================================================== --


type Msg
    = NoOp
    | GotHomeMsg Home.Msg
    | GotEditSessionMsg EditSession.Msg
    | GotNewExerciseMsg NewExercise.Msg
    | GotHistoryMsg History.Msg
    | GotHistorySessionMsg HistorySession.Msg



-- | SetStorage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( GotHomeMsg homeMsg, Home homeModel ) ->
            let
                ( newMdl, newCmd, actions ) =
                    Home.update homeMsg homeModel
            in
            updateWith Home GotHomeMsg ( newMdl, newCmd )
                |> (\( mdl, cmd ) -> performActions mdl cmd actions)

        ( GotEditSessionMsg editSessionMsg, EditSession editSessionModel ) ->
            let
                ( newMdl, newCmd, actions ) =
                    EditSession.update editSessionMsg editSessionModel
            in
            updateWith EditSession GotEditSessionMsg ( newMdl, newCmd )
                |> (\( mdl, cmd ) -> performActions mdl cmd actions)

        ( GotNewExerciseMsg newExerciseMsg, NewExercise newExerciseModel ) ->
            let
                ( newMdl, newCmd, actions ) =
                    NewExercise.update newExerciseMsg newExerciseModel
            in
            updateWith NewExercise GotNewExerciseMsg ( newMdl, newCmd )
                |> (\( mdl, cmd ) -> performActions mdl cmd actions)

        ( GotHistoryMsg historyMsg, History historyModel ) ->
            let
                ( newMdl, newCmd, actions ) =
                    History.update historyMsg historyModel
            in
            updateWith History GotHistoryMsg ( newMdl, newCmd )
                |> (\( mdl, cmd ) -> performActions mdl cmd actions)

        ( GotHistorySessionMsg historySessionMsg, HistorySession historySessionModel ) ->
            let
                ( newMdl, newCmd, actions ) =
                    HistorySession.update historySessionMsg historySessionModel
            in
            updateWith HistorySession GotHistorySessionMsg ( newMdl, newCmd )
                |> (\( mdl, cmd ) -> performActions mdl cmd actions)

        ( _, _ ) ->
            ( model, Cmd.none )


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )


performActions : Model -> Cmd Msg -> List Actions.Action -> ( Model, Cmd Msg )
performActions model cmd actions =
    case actions of
        [] ->
            ( model, cmd )

        action :: rest ->
            case action of
                -- _ ->
                --     performActions newModel (Cmd.batch [ cmd, newCmd ]) rest
                Actions.GoToRoute route ->
                    let
                        ( newModel, newCmd ) =
                            router route
                    in
                    -- ignore the rest when navigating to a new page
                    ( newModel, Cmd.batch [ cmd, newCmd ] )


router : Actions.Route -> ( Model, Cmd Msg )
router route =
    case route of
        Actions.Home ->
            Home.init
                |> updateWith Home GotHomeMsg

        Actions.EditSession ->
            EditSession.init
                |> updateWith EditSession GotEditSessionMsg

        Actions.NewExercise ->
            NewExercise.init
                |> updateWith NewExercise GotNewExerciseMsg

        Actions.History ->
            History.init
                |> updateWith History GotHistoryMsg

        Actions.HistorySession ->
            HistorySession.init
                |> updateWith HistorySession GotHistorySessionMsg



-- SetStorage ->
--     ( model, setStorage (Model "2025.04.25") )
-- ========================================================================== --
--                                    VIEW                                    --
-- ========================================================================== --


view : Model -> Browser.Document Msg
view model =
    { title = "Fitsess"
    , body =
        [ Html.div
            [ style "display" "flex"
            , style "flex-direction" "column"
            , style "align-items" "center"
            , style "justify-content" "center"
            , style "height" "100vh"
            ]
            [ case model of
                Home homeModel ->
                    Home.view homeModel
                        |> Html.map GotHomeMsg

                EditSession editSessionModel ->
                    EditSession.view editSessionModel
                        |> Html.map GotEditSessionMsg

                NewExercise newExerciseModel ->
                    NewExercise.view newExerciseModel
                        |> Html.map GotNewExerciseMsg

                History historyModel ->
                    History.view historyModel
                        |> Html.map GotHistoryMsg

                HistorySession historySessionModel ->
                    HistorySession.view historySessionModel
                        |> Html.map GotHistorySessionMsg
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
