module Pages.Home_ exposing (page)

import Components.Sidebar
import Html exposing (Html)
import Html.Attributes exposing (alt, class, src, style)
import Html.Events
import Page exposing (Page)
import Route exposing (Route)
import View exposing (View)
import Shared
import Html exposing (..)
import Effect exposing (Effect)
import Library.StringTransforms exposing (..)

siteplanAbstract : String
siteplanAbstract = """
  <p style="margin-bottom:20px;">
    <span style="font-family:Cursive; font-weight: bold;">Siteplan</span> 
    is a template based on <a href="https://elm.land">elm-land</a>.
    The template follows the advice given at 
    <a href="https://elm.land/guide/working-with-js.html">Working with JavaScript</a>.
  </p>
  <p style="margin-bottom:20px;">Instructions:</p>
  <ol style="margin-left:20px;">
  <li>Use is made of scss and the following command should be run to create 'main.css':<br/>
  <pre>sass -w assets/scss/main.scss static/dist/main.css</pre>
  </li>
  <li>Run 'elm-land server' and go to 'localhost:1234'</li>
  </ol>
  <h2>Issue</h2>
  <p style="margin-top:20px;">
    The <span style="font-family:Cursive; font-weight: bold;">Siteplan</span> 
    next to the logo should be clickable and open a dialog window.</p>
  <p style="margin-top:20px;">This currently is not working.
  The code that is failing is commented out in 'Sidebar.elm' on lines 42 and 51.
  </p>
  <p style="margin-top:20px;">This uses an 'onClick' to send the message 'LaunchModal',
  which, via 'update', invokes 'Effect.openWindowDialog', lines 90 to 96 in 'Effect.elm'.
  </p>
  <p style="margin-top:20px;">This issue that is reported by Elm is:</p>
  <img src="/dist/images/siteplan-issue1.png" width="700px"/>
   """

page : View msg
page =
    Components.Sidebar.view
   { page =
      { title = "Elm Siteplan v1"
    , body =
        [ Html.div [ class "edgard header title text-centered" ]
          [ Html.h1 [ class "title is-1" ] [ Html.text "Home Page" ]]
          , Html.div [ class "container py-6 p-5" ]
             [Html.div [style "margin-left" "20px"] <| textHtml siteplanAbstract
             ]
          ]    
    }
   }
