import { Controller } from 'stimulus'
import Mousetrap from 'mousetrap'
import screenfull from 'screenfull'

export default class extends Controller {
  connect () {
    Mousetrap.bind(this.combo, event => {
      // Prevent alert sounds on Safari in fullscreen :#
      if (screenfull.isFullscreen) event.preventDefault()
      this.element.dispatchEvent(new CustomEvent(this.event, { bubbles: true }))
    })
  }

  disconnect () {
    Mousetrap.unbind(this.combo)
  }

  get combo () {
    return this.data.get('combo')
  }
  get event () {
    return this.data.get('event')
  }
}
