import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages", "input"]

  connect() {
    // set the heigt of the messages container to the height of the window
    this.messagesTarget.style.height = `${window.innerHeight - 100}px`
  }
}