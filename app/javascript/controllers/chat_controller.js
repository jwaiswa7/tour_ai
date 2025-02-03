import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "input", "messages", "container"]

  connect() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  handleSubmit(event){
    this.inputTarget.value = "Submitting...";
    this.inputTarget.disabled = true;
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  toggle() {
    this.containerTarget.classList.toggle("hidden")
    // Change the button text
    if (this.containerTarget.classList.contains("hidden")) {
      this.buttonTarget.textContent = "Show Chat";
    } else {
      this.buttonTarget.textContent = "Hide Chat";
    }
  }
}