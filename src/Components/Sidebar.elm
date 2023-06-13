module Components.Sidebar exposing (view, viewSidebar, Msg)

import Html exposing (Html)
import Html.Attributes as Attr exposing (alt, class, src, style)
import Html.Events
import Json.Encode
import Effect exposing (Effect(..), openWindowDialog)
import View exposing (View)
import Shared.Msg exposing (Msg(..))

type alias Model = {}

type Msg = None
  | LaunchModal String

update :  Msg -> Model -> ( Model, Msg )
update msg model =
 case msg of
        None -> (model, None)
        LaunchModal text ->
            Debug.log "LaunchModal"
            Effect.openWindowDialog text
              |> ( \_ -> (model, None))

view : { page : View Msg } -> View Msg
view { page } =
    { title = page.title
    , body = 
        [ Html.div [ Attr.class "layout" ]
            [ viewSidebar
            , Html.div [ Attr.class "page" ] <|
              Html.div [] [Html.text "TODO: Status Block - showing server and logged-in status"] :: page.body
              ]
            ]
    }

viewSidebar : Html Msg
viewSidebar =
    Html.aside [ Attr.class "sidebar" ]
        [ 
          Html.div [class "teamwork-logo edg-product-logo"] 
            [Html.a [Html.Events.onClick <| LaunchModal "Test Modals"]
                 [
                 Html.h1 [ class "title is-4" , Attr.href "/"
                    , style "margin-left" "48px"
                    , style "margin-top" "10px"
                    , style "color" "darkblue"
                    , style "font-family" "Cursive" ] 
                    [ Html.text "Siteplan"  ]
                 ] 
            ]
        , Html.a [ Attr.href "/"] [ Html.text "Home" ]
        , Html.a [ Attr.href "/page1"] [ Html.text "Page 1" ]
        , Html.a [ Attr.href "/page2"] [ Html.text "Page 2" ]
        , Html.a [ Attr.href "/page3"] [ Html.text "Page 3" ]
        , Html.hr [][]
        , Html.a [ Attr.href "/profile/me" ] [ Html.text "Profile" ]
        , Html.a [ Attr.href "/settings/account" ] [ Html.text "Settings" ]
        ]

