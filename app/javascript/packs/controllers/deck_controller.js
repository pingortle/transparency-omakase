import { Controller } from 'stimulus'
import screenfull from 'screenfull'

export default class extends Controller {
  static targets = ['slide', 'nextControl', 'previousControl']

  connect () {
    this.show(this.slideTargets[0])
    this.setupScrollPrevention()
  }

  disconnect () {
    this.teardownScrollPrevention()
  }

  show (slide) {
    if (!slide) return

    this.slideTargets.forEach(candidate => {
      candidate.hidden = true
    })

    slide.hidden = false

    this.nextControlTarget.disabled = !this.nextSlide
    this.previousControlTarget.disabled = !this.previousSlide
  }

  next (event) {
    event.preventDefault()
    this.show(this.nextSlide)
  }

  previous (event) {
    event.preventDefault()
    this.show(this.previousSlide)
  }

  fullscreen () {
    if (screenfull.isEnabled) screenfull.toggle()
  }

  // Private

  get currentSlide () {
    return this.slideTargets.find(slide => !slide.hidden)
  }

  get nextSlide () {
    return this.onlySlide(this.currentSlide.nextElementSibling)
  }

  get previousSlide () {
    return this.onlySlide(this.currentSlide.previousElementSibling)
  }

  onlySlide (element) {
    return this.slideTargets.includes(element) ? element : null
  }

  setupScrollPrevention () {
    const scrollable = this.element.parentElement
    this.scrollPoller = setInterval(() => {
      if (scrollable.scrollTop !== 0 || scrollable.scrollLeft !== 0) {
        scrollable.scrollTop = 0
        scrollable.scrollLeft = 0
      }
    }, 1000)
  }

  teardownScrollPrevention () {
    clearInterval(this.scrollPoller)
  }
}
