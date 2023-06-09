module Pages.Profile.Username_ exposing (page)

import Html exposing (Html)
import View exposing (View)


page : { username : String } -> View msg
page params =
    { title = "Pages.Profile.Username_"
    , body = [ Html.text ("/profile/" ++ params.username) ]
    }
