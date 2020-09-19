import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['slide', 'nextControl', 'previousControl']

  connect () {
    this.show(this.slideTargets[0])
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

  next () {
    this.show(this.nextSlide)
  }

  previous () {
    this.show(this.previousSlide)
  }

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
}