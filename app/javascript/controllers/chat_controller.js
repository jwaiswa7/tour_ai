import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "container", "input", "messages", "threadId"]

  connect() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  toggle() {
    this.containerTarget.classList.toggle("hidden")
  }

  handleSubmit(event){
    this.inputTarget.value = "Submitting...";
    this.inputTarget.disabled = true;
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }
}