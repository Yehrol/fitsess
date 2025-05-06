module Internal.Actions exposing (..)


type Action
    = GoToRoute Route


type Route
    = Home
    | EditSession
    | NewExercise
    | History
    | HistorySession
    | EditPreset
