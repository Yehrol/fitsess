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
    ( Home homeModel
    , Cmd.map GotHomeMsg homeCmd
    )



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
            Home.update homeMsg homeModel
                |> updateWith Home GotHomeMsg
                |> (\( m, c, a ) -> performActions m c a)

        ( GotEditSessionMsg editSessionMsg, EditSession editSessionModel ) ->
            EditSession.update editSessionMsg editSessionModel
                |> updateWith EditSession GotEditSessionMsg
                |> (\( m, c, a ) -> performActions m c a)

        ( GotNewExerciseMsg newExerciseMsg, NewExercise newExerciseModel ) ->
            NewExercise.update newExerciseMsg newExerciseModel
                |> updateWith NewExercise GotNewExerciseMsg
                |> (\( m, c, a ) -> performActions m c a)

        ( GotHistoryMsg historyMsg, History historyModel ) ->
            History.update historyMsg historyModel
                |> updateWith History GotHistoryMsg
                |> (\( m, c, a ) -> performActions m c a)

        ( GotHistorySessionMsg historySessionMsg, HistorySession historySessionModel ) ->
            HistorySession.update historySessionMsg historySessionModel
                |> updateWith HistorySession GotHistorySessionMsg
                |> (\( m, c, a ) -> performActions m c a)

        ( _, _ ) ->
            ( model, Cmd.none )


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg, List Actions.Action ) -> ( Model, Cmd Msg, List Actions.Action )
updateWith toModel toMsg ( subModel, subCmd, actions ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    , actions
    )


routeToPage : Actions.Route -> ( Model, Cmd Msg )
routeToPage route =
    case route of
        Actions.Home ->
            let
                ( homeModel, homeCmd ) =
                    Home.init
            in
            ( Home homeModel, Cmd.map GotHomeMsg homeCmd )

        Actions.EditSession ->
            let
                ( editSessionModel, editSessionCmd ) =
                    EditSession.init
            in
            ( EditSession editSessionModel, Cmd.map GotEditSessionMsg editSessionCmd )

        Actions.NewExercise ->
            let
                ( newExerciseModel, newExerciseCmd ) =
                    NewExercise.init
            in
            ( NewExercise newExerciseModel, Cmd.map GotNewExerciseMsg newExerciseCmd )

        Actions.History ->
            let
                ( historyModel, historyCmd ) =
                    History.init
            in
            ( History historyModel, Cmd.map GotHistoryMsg historyCmd )

        Actions.HistorySession ->
            let
                ( historySessionModel, historySessionCmd ) =
                    HistorySession.init
            in
            ( HistorySession historySessionModel, Cmd.map GotHistorySessionMsg historySessionCmd )


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
                            routeToPage route
                    in
                    -- ignore the rest when navigating to a new page
                    ( newModel, Cmd.batch [ cmd, newCmd ] )



-- SetStorage ->
--     ( model, setStorage (Model "2025.04.25") )
-- ========================================================================== --
--                                    VIEW                                    --
-- ========================================================================== --


view : Model -> Browser.Document Msg
view model =
    { title = "Fitsess"
    , body =
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
