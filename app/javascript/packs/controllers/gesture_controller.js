import { Controller } from 'stimulus'
import TinyGesture from 'tinygesture'

export default class extends Controller {
  connect () {
    this.gesture = new TinyGesture(this.element.parentElement, {
      mouseSupport: false
    })
    this.gesture.on(this.name, () => {
      this.element.dispatchEvent(new CustomEvent(this.event, { bubbles: true }))
    })
  }

  disconnect () {
    this.gesture.destroy()
  }

  get name () {
    return this.data.get('name')
  }
  get event () {
    return this.data.get('event')
  }
}
