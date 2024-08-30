import { Controller } from "@hotwired/stimulus";
import { marked } from "marked";
export default class extends Controller {
  static targets = ["messages", "input", "question"]

  connect() {
    // set the height of the messages container to the height of the window
    this.messagesTarget.style.height = `${window.innerHeight - 100}px`
  }
  
  submit(event) {
    event.preventDefault();
    fetch('/questions.json', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ question: {question: this.questionTarget.value } })
    }).then(response => {
      if (response.ok) {
        const form = event.target;
        const formData = new FormData(form);

        fetch(form.action, {
          method: form.method,
          headers: {
            'Accept': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          },
          body: formData
        })
        .then(response => response.json())
        .then(data => {
          // render text with turbo stream
          const response = data.question.answer;
          this.afterSubmit();
        })
        .catch(error => {
          console.error("Error:", error);
        });
      }
    })
  }

  afterSubmit() {
    this.inputTarget.value = "";
    this.questionTarget.value = "";
  }
}