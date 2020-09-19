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

    const ua = window.navigator.userAgent
    const mqStandAlone = '(display-mode: standalone)'
    let iphone = ua.indexOf('iPhone') !== -1 && ua.indexOf('Safari') !== -1
    let appMode = 'browser'
    if (
      window.navigator.standalone ||
      window.matchMedia(mqStandAlone).matches
    ) {
      appMode = 'standalone'
    }

    if (iphone && appMode !== 'standalone') {
      this.iphoneResizer = () => {
        this.resize({
          width: window.innerWidth,
          height: window.innerHeight
        })
      }
      window.addEventListener('resize', this.iphoneResizer)
    } else {
      this.resizeObserver.observe(world)
    }
  }

  disconnect () {
    this.resizeObserver.disconnect()
    window.removeEventListener('resize', this.iphoneResizer)
  }

  get widthFactor () {
    return this.data.get('width')
  }

  get heightFactor () {
    return this.data.get('height')
  }

  get initialOffsetWidth () {
    return this.element.offsetWidth
  }

  get initialOffsetHeight () {
    return this.element.offsetHeight
  }

  resize ({ width, height }) {
    const scale = Math.min(
      width / this.initialOffsetWidth,
      height / this.initialOffsetHeight
    )

    this.element.style.transform = `scale(${scale})`
  }
}
