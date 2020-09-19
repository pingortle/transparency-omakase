import { Controller } from 'stimulus'

export default class extends Controller {
  connect () {
    const world = document.querySelector('html')

    this.element.style.width = 'var(--scalable-width)'
    this.element.style.height = 'var(--scalable-height)'

    this.resize({ width: world.offsetWidth, height: world.offsetHeight })

    this.resizeObserver = new ResizeObserver(entries => {
      for (const entry of entries) {
        if (entry.contentBoxSize) {
          for (const box of new Array(entry.contentBoxSize).flat()) {
            this.resize({
              width: box.inlineSize,
              height: box.blockSize
            })
          }
        } else {
          this.resize({
            width: entry.contentRect.width,
            height: entry.contentRect.height
          })
        }
      }
    })

    this.resizeObserver.observe(world)
  }

  disconnect () {
    this.resizeObserver.disconnect()
  }

  get widthFactor () {
    return this.data.get('width')
  }

  get heightFactor () {
    return this.data.get('height')
  }

  get initialOffsetWidth () {
    return this.element.offsetWidth
    return this.data.get('width')
  }

  get initialOffsetHeight () {
    return this.element.offsetHeight
    return this.data.get('height')
  }

  resize ({ width, height }) {
    const scale = Math.min(
      width / this.initialOffsetWidth,
      height / this.initialOffsetHeight
    )

    this.element.style.transform = `scale(${scale})`
  }
}
