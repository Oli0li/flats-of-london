import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["booking", "details", "div"];
  static values = {
    current: String,
  };

  connect() {
    const display = (event) => {
      // Get the class of the button that was clicked (eg: "future-bookings active")
      const buttonClass = event.path[0].className.split(" ");
      this.detailsTargets.forEach((target) => {
        // Check if the first class of the button that was clicked is also used in one of the details div
        // If so, this details div is displayed, and the other ones are hidden
        if (target.className.includes(buttonClass[0])) {
          target.className = target.className.replace("d-none", "d-block");
        } else {
          target.classList.replace("d-block", "d-none");
        }
      });
    };

    this.bookingTargets.forEach((element) => {
      element.addEventListener("click", display);
    });
  }
}
