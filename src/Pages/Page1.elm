module Pages.Page1 exposing (page)

import Html exposing (Html)
import View exposing (View)


page : View msg
page =
    { title = "Pages.Page1"
    , body = [ Html.text "/page1" ]
    }
