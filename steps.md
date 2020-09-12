# Milestones
## 🏁 Rear view
- Template basic rails app
- Deploy to heroku
- Scaffold decks
- Scaffold basic presentation controller using remarkjs
- Frame out the GUI
- Fix remarkjs+turbolinks bug
  - solution: disable turbolinks for that controller :P
- Add client-side deck search (using github/filterable-input-element)
  - Tip: use async import() for standalone web components
  - Tip: to avoid iOS zooming in on form fields, make the font size ≥16px (.f4 in primer)

## 🛣 Vision
- Document how to use
- Create landing page
- Add continuous presentation mode (no slides, scrollable viewport)
- Add presentation preview while editing
  - ¿Replace remarkjs with something turbolinks friendly (or fix it; if we fix it, let's unvendor it too)
    - Look at reveal.js for replacement
    - Consider iframes for remarkjs
- Add integrated scripture reference support
  - Generate readable presentation with no effort
  - Differentiate from normal decks in search

### 💸 Sustainability tasks
- Find early adopters/product champions
- Offer to tiny group for testing
- Calculate cost per customer/user
- Create pricing model based on usage data
  - Consider donation funding model
- Find marketing channels

## 🌅 Horizon
- Synchronize presentations among participants
  - Consider dat-sdk (synchronize by distributing the hypercore key to clients)
    - Downside: requires explicit handoff of control…is that bad? (b/c single writer feed)
- More interactivity: polls, requests, reactions, responses, and more
- Integrate with discord
- Integrate with zoom (embed?)
- Add easy but lo-fi livestream for un-fussy churches with no media director and no budget
- Add easy/lo-fi video chat for core participants…??? (really want discord or something else to to the solution here, but if we must…)
