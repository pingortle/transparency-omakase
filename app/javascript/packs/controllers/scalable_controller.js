import { Controller } from 'stimulus'

export default class extends Controller {
  connect () {
    const world = document.querySelector('html')

    this.element.style.width = 'var(--scalable-width)'
    this.element.style.height = 'var(--scalable-height)'

    Math.min(world.offsetWidth, world.offsetHeight)
    this.resize({ width: world.offsetWidth, height: world.offsetHeight })

    const resizeObserver = new ResizeObserver(entries => {
      for (const entry of entries) {
        if (entry.contentBoxSize) {
          this.resize({
            width: entry.contentBoxSize.inlineSize,
            height: entry.contentBoxSize.blockSize
          })
        } else {
          this.resize({
            width: entry.contentRect.width,
            height: entry.contentRect.height
          })
        }
      }
    })

    resizeObserver.observe(world)
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
