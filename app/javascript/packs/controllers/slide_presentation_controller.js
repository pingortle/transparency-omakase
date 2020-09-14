import { Controller } from 'stimulus'
import Reveal from 'reveal.js'
import RevealMarkdown from 'reveal.js/plugin/markdown/markdown.esm.js'

export default class extends Controller {
  static targets = ['slides']

  connect () {
    const revealContainer = this.element

    revealContainer.classList.add('reveal')
    this.slidesTarget.classList.add('slides')

    this.deck = new Reveal(revealContainer, {
      hash: true,
      plugins: [RevealMarkdown],
      keyboard: {
        '27' () {
          history.back()
        }
      }
    })

    this.deck.initialize()
  }

  disconnect () {
    location.reload()
  }
}
