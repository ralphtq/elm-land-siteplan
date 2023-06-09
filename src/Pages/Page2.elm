module Pages.Page2 exposing (page)

import Html exposing (Html)
import View exposing (View)


page : View msg
page =
    { title = "Pages.Page2"
    , body = [ Html.text "/page2" ]
    }
