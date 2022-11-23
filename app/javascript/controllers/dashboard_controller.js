import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["tab", "details", "div"];
  static values = {
    current: String,
  };

  connect() {
    const display = (event) => {
      // Get the tab that was clicked
      const clickedTab = event.path[0];

      // Set its class as "active", and the class of other tabs as "inactive"
      clickedTab.classList.replace("inactive", "active");
      this.tabTargets.forEach((tab) => {
        if (tab !== clickedTab) tab.classList.replace("active", "inactive");
      });

      // Check if the first class of the tab that was clicked is also used in one of the details div
      // If so, this details div is displayed, and the other ones are hidden
      this.detailsTargets.forEach((target) => {
        if (target.className.includes(clickedTab.classList[0])) {
          target.classList.replace("d-none", "d-block");
        } else {
          target.classList.replace("d-block", "d-none");
        }
      });
    };

    this.tabTargets.forEach((element) => {
      element.addEventListener("click", display);
    });
  }
}
