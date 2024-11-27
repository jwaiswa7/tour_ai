import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "container", "input", "messages", "thread_id"]

  toggle() {
    this.containerTarget.classList.toggle("hidden")
  }

  handleSubmit(event){
    event.preventDefault(); 

    const message = this.inputTarget.value.trim();

    if (message.length > 0) {
      this.messagesTarget.appendChild(this.createChatMessage(message));
      this.inputTarget.value = ""
    }else{
      console.log("empty")
    }

    this.inputTarget.value = ""

    this.getAIMessage(message);

  }

  async getAIMessage(message) {

    const thread_id = this.inputTarget.value.trim(); // Get the message from the input field

    try {
      const response = await fetch("/chats", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.getCSRFToken(),
        },
        body: JSON.stringify(
          { 
            thread_id: thread_id,
            message: message
          }
        ), // Send the message as JSON
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const data = await response.json();
      
      this.messagesTarget.appendChild(this.createAIMessage(data.message));

      // this.inputTarget.value = ""; // Clear the input field after successful submission
    } catch (error) {
      console.error("Failed to send message:", error);
      alert("There was a problem sending your message. Please try again.");
    }
  }

  getCSRFToken() {
    // Get the CSRF token from the meta tag added by Rails
    const meta = document.querySelector('meta[name="csrf-token"]');
    return meta ? meta.content : "";
  }

  createChatMessage(message) {
    // Create the main container div
    const container = document.createElement("div");
    container.className = "flex gap-3 my-4 text-gray-600 text-sm flex-1";
  
    // Create the span for the avatar
    const avatarSpan = document.createElement("span");
    avatarSpan.className = "relative flex shrink-0 overflow-hidden rounded-full w-8 h-8";
  
    // Create the avatar container div
    const avatarContainer = document.createElement("div");
    avatarContainer.className = "rounded-full bg-gray-100 border p-1";
  
    // Create the SVG element
    const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
    svg.setAttribute("stroke", "none");
    svg.setAttribute("fill", "black");
    svg.setAttribute("stroke-width", "0");
    svg.setAttribute("viewBox", "0 0 16 16");
    svg.setAttribute("height", "20");
    svg.setAttribute("width", "20");
  
    // Create the path for the SVG
    const path = document.createElementNS("http://www.w3.org/2000/svg", "path");
    path.setAttribute(
      "d",
      "M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z"
    );
  
    // Append path to SVG
    svg.appendChild(path);
  
    // Append SVG to avatar container
    avatarContainer.appendChild(svg);
  
    // Append avatar container to span
    avatarSpan.appendChild(avatarContainer);
  
    // Create the paragraph for the text
    const messageParagraph = document.createElement("p");
    messageParagraph.className = "leading-relaxed";
  
    // Create the bold name span
    const nameSpan = document.createElement("span");
    nameSpan.className = "block font-bold text-gray-700";
    nameSpan.textContent = "You";
  
    // Create the message text node
    const messageText = document.createTextNode(message);
  
    // Append name span and message text to the paragraph
    messageParagraph.appendChild(nameSpan);
    messageParagraph.appendChild(messageText);
  
    // Append the avatar span and message paragraph to the container
    container.appendChild(avatarSpan);
    container.appendChild(messageParagraph);
  
    return container;
  }

  createAIMessage(message) {
    // Create the main container div
    const container = document.createElement("div");
    container.className = "flex gap-3 my-4 text-gray-600 text-sm flex-1";
  
    // Create the avatar span
    const avatarSpan = document.createElement("span");
    avatarSpan.className = "relative flex shrink-0 overflow-hidden rounded-full w-8 h-8";
  
    // Create the inner avatar div
    const avatarDiv = document.createElement("div");
    avatarDiv.className = "rounded-full bg-gray-100 border p-1";
  
    // Create the SVG element
    const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
    svg.setAttribute("stroke", "none");
    svg.setAttribute("fill", "black");
    svg.setAttribute("stroke-width", "1.5");
    svg.setAttribute("viewBox", "0 0 24 24");
    svg.setAttribute("aria-hidden", "true");
    svg.setAttribute("height", "20");
    svg.setAttribute("width", "20");
  
    // Create the path for the SVG
    const path = document.createElementNS("http://www.w3.org/2000/svg", "path");
    path.setAttribute("stroke-linecap", "round");
    path.setAttribute("stroke-linejoin", "round");
    path.setAttribute(
      "d",
      "M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 002.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 00-2.456 2.456zM16.894 20.567L16.5 21.75l-.394-1.183a2.25 2.25 0 00-1.423-1.423L13.5 18.75l1.183-.394a2.25 2.25 0 001.423-1.423l.394-1.183.394 1.183a2.25 2.25 0 001.423 1.423l1.183.394-1.183.394a2.25 2.25 0 00-1.423 1.423z"
    );
  
    // Append the path to the SVG
    svg.appendChild(path);
  
    // Append the SVG to the avatar div
    avatarDiv.appendChild(svg);
  
    // Append the avatar div to the avatar span
    avatarSpan.appendChild(avatarDiv);
  
    // Create the message paragraph
    const messageParagraph = document.createElement("p");
    messageParagraph.className = "leading-relaxed";
  
    // Create the bold span for the name
    const nameSpan = document.createElement("span");
    nameSpan.className = "block font-bold text-gray-700";
    nameSpan.textContent = "AI";
  
    // Create the message text
    const messageText = document.createTextNode(message);
  
    // Append the name span and message text to the paragraph
    messageParagraph.appendChild(nameSpan);
    messageParagraph.appendChild(messageText);
  
    // Append the avatar span and message paragraph to the container
    container.appendChild(avatarSpan);
    container.appendChild(messageParagraph);
  
    return container;
  }



}