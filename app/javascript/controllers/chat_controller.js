import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "input", "messages", "threadId"]

  connect() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  handleSubmit(event){
    console.log('Submitting');
    this.inputTarget.value = "Submitting...";
    this.inputTarget.disabled = true;
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }
}