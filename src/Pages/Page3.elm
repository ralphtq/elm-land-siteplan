module Pages.Page3 exposing (page)

import Html exposing (Html)
import View exposing (View)


page : View msg
page =
    { title = "Pages.Page3"
    , body = [ Html.text "/page3" ]
    }
