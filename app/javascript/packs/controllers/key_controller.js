import { Controller } from 'stimulus'
import Mousetrap from 'mousetrap'

export default class extends Controller {
  connect () {
    Mousetrap.bind(this.combo, () => {
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
