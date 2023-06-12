port module Effect exposing
    ( Effect
    , none, batch
    , sendCmd, sendMsg
    , openWindowDialog
    , pushRoute
    , replaceRoute
    , signIn
    , signOut
    , loadExternalUrl
    , map
    , toCmd
    )

{-|

@docs Effect
@docs none, batch
@docs sendCmd, sendMsg
@docs pushRoute, replaceRoute, loadExternalUrl

@docs signIn, signOut
@docs saveUser, clearUser

@docs map, toCmd

-}

import Browser.Navigation
import Dict exposing (Dict)
import Route exposing (..)
import Route.Path
import Route.Query
import Shared.Model
import Shared.Msg
import Task
import Url exposing (Url)
import Json.Encode
import Process
import Html exposing (q)


type Effect msg
    = 
      None
    | Batch (List (Effect msg))
    | SendCmd (Cmd msg)
      -- ROUTING
    | PushUrl String
    | ReplaceUrl String
    | LoadExternalUrl String
      -- SHARED
    | SendSharedMsg Shared.Msg.Msg
    | SendMessageToJavaScript
        { tag : String 
        , data : Json.Encode.Value
        }

-- PORTS

port outgoing : { tag : String, data : Json.Encode.Value } -> Cmd msg

-- BASICS


{-| Don't send any effect.
-}
none : Effect msg
none =
    None


{-| Send multiple effects at once.
-}
batch : List (Effect msg) -> Effect msg
batch =
    Batch


{-| Send a normal `Cmd msg` as an effect, something like `Http.get` or `Random.generate`.
-}
sendCmd : Cmd msg -> Effect msg
sendCmd =
    SendCmd


{-| Send a message as an effect. Useful when emitting events from UI components.
-}
sendMsg : msg -> Effect msg
sendMsg msg =
    Task.succeed msg
        |> Task.perform identity
        |> SendCmd

openWindowDialog : String -> Effect msg
openWindowDialog question =
    Debug.log("I am in openWindowDialog with a message: " ++ question)
    SendMessageToJavaScript
        { tag = "OPEN_WINDOW_DIALOG"
        , data = Json.Encode.string question
        }

-- ROUTING


{-| Set the new route, and make the back button go back to the current route.
-}

pushRoute :
    { path : Route.Path.Path
    , query : Dict String String
    , hash : Maybe String
    }
    -> Effect msg
pushRoute route =
    PushUrl (Route.toString route)


{-| Set the new route, but replace the previous one, so clicking the back
button **won't** go back to the previous route.
-}
replaceRoute :
    { path : Route.Path.Path
    , query : Dict String String
    , hash : Maybe String
    }
    -> Effect msg
replaceRoute route =
    ReplaceUrl (Route.toString route)


{- | Redirect users to a new URL, somewhere external your web application.
-}

loadExternalUrl : String -> Effect msg
loadExternalUrl =
    LoadExternalUrl

-- SHARED


signIn :
    { token : String
    , id : String
    , name : String
    , profileImageUrl : String
    , email : String
    }
    -> Effect msg
signIn user =
    SendSharedMsg (Shared.Msg.SignIn user)


signOut : Effect msg
signOut =
    SendSharedMsg Shared.Msg.SignOut



-- LOCAL STORAGE
-- INTERNALS


{-| Elm Land depends on this function to connect pages and layouts
together into the overall app.
-}

map : (msg1 -> msg2) -> Effect msg1 -> Effect msg2
map fn effect =
    case effect of
        None ->
            None

        Batch list ->
            Batch (List.map (map fn) list)

        SendCmd cmd ->
            SendCmd (Cmd.map fn cmd)

        PushUrl url ->
            PushUrl url

        ReplaceUrl url ->
            ReplaceUrl url

        LoadExternalUrl url ->
            LoadExternalUrl url

        SendSharedMsg sharedMsg ->
            SendSharedMsg sharedMsg
        
        SendMessageToJavaScript message ->
            Debug.log("DEBUG ===> I am in map with this message: " ++ message.tag)
            SendMessageToJavaScript message


{-| Elm Land depends on this function to perform your effects.
-}
toCmd :
    { 
      key : Browser.Navigation.Key
    , url : Url
    , shared : Shared.Model.Model
    , fromSharedMsg : Shared.Msg.Msg -> msg
    , fromCmd : Cmd msg -> msg
    , toCmd : msg -> Cmd msg
    }
    -> Effect msg
    -> Cmd msg
toCmd options effect =
    case effect of
        None ->
            Cmd.none

        Batch list ->
            Cmd.batch (List.map (toCmd options) list)

        SendCmd cmd ->
            cmd

        PushUrl url ->
            Browser.Navigation.pushUrl options.key url

        ReplaceUrl url ->
            Browser.Navigation.replaceUrl options.key url

        LoadExternalUrl url ->
            Browser.Navigation.load url

        SendSharedMsg sharedMsg ->
            Task.succeed sharedMsg
                |> Task.perform options.fromSharedMsg

        SendMessageToJavaScript message ->
            Debug.log("In toCmd with this message: " ++ message.tag)
            outgoing message
