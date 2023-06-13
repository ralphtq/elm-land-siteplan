# elm-land-siteplan
## Templates for elm-land

Siteplan is a template based on elm-land. The template follows the advice given at Working with JavaScript.

Use is made of scss and the following command should be run to create 'main.css':
sass -w assets/scss/main.scss static/dist/main.css
Run 'elm-land server' and go to 'localhost:1234'
Issue
The Siteplan next to the logo should be clickable and open a dialog window.

This uses an 'onClick' to send the message 'LaunchModal', which, via 'update', invokes 'Effect.openWindowDialog', lines 90 to 96 in 'Effect.elm'.

## Installation Steps

1. Run sass

> sass -w assets/scss/main.scss static/dist/main.css

2. Run elm-land server




