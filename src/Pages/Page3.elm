module Pages.Page3 exposing (page)

import Components.Sidebar
import Html exposing (Html)
import Html.Attributes exposing (alt, class, src, style)
import Page exposing (Page)
import Route exposing (Route)
import View exposing (View)
import Effect exposing (Effect)


page : View msg
page =
    Components.Sidebar.view
   { page =
      { title = "Elm Siteplan v1"
    , body =
        [ Html.div [ class "edgard header title text-centered" ]
          [ Html.h1 [ class "title is-1" ] [ Html.text "Page 3" ]]
          , Html.div [ class "container py-6 p-5" ]
             [Html.div [style "margin-left" "20px"] [Html.text "Page 3 Content"]
             ]
          ]    
    }
   }