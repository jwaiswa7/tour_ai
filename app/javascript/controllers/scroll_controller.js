import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  scrollRight() {
    const container = this.containerTarget
    container.scrollBy({
      left: container.clientWidth,
      behavior: 'smooth'
    })
  }

  scrollLeft() {
    const container = this.containerTarget
    container.scrollBy({
      left: -container.clientWidth,
      behavior: 'smooth'
    })
  }
}