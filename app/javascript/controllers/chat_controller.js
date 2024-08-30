import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  static targets = ["messages", "input", "question", "thread"];

  connect() {
    this.messagesTarget.style.height = `${window.innerHeight - 100}px`
    this.questionTarget.setAttribute("maxlength", 255);
  }
  
  submit(event) {
    event.preventDefault();
    this.questionTarget.disabled = true;
    this.messagesTarget.innerHTML += `<div class="answer-item m-5 shadow-lg p-4 rounded-lg bg-blue-500 text-white"><p>${this.questionTarget.value}</p></div>`;
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;

    fetch('/questions.json', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify(
        { 
          question: {
            question: this.questionTarget.value , 
            thread_id: this.threadTarget.value  
          } 
        }
      )
    }).then(response => {
        if (response.ok) {
          return response.json();
        }
    }).then(data => {
      // render text with turbo stream
      const response = data.question.answer;
      this.messagesTarget.innerHTML += `<div class="answer-item m-5 shadow-lg p-4 rounded-lg"><p>${response}</p></div>`;
      this.afterSubmit();
    }).catch(error => {
      console.error("Error:", error);
    });
  }

  afterSubmit() {
    this.questionTarget.value = "";
    this.questionTarget.disabled = false;
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }
}