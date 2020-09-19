import { Controller } from 'stimulus'

export default class extends Controller {
  back () {
    history.back()
  }
}
