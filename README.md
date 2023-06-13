# elm-land-siteplan
## Templates for elm-land

Siteplan is a template based on elm-land. The template follows the advice given at Working with JavaScript.

The Siteplan next to the logo should be clickable and open a dialog window.

This uses an 'onClick' to send the message 'LaunchModal', which, via 'update', invokes 'Effect.openWindowDialog', lines 90 to 96 in 'Effect.elm'.

### Issue

Elm error:


-- TYPE MISMATCH ---------------------------------------- .elm-land/src/Main.elm

Something is off with the 1st branch of this `case` expression:

397|             (Pages.Home_.page)
                  ^^^^^^^^^^^^^^^^
This `page` value is a:

    View Pages.Home_.HomeMsg

But the type annotation on `viewPage` says it should be:

    View Msg


## Installation Steps

1. Run sass

sass -w assets/scss/main.scss static/dist/main.css

2. Run elm-land server
3. Go to 'localhost:1234'
