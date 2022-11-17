import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="checkout"
export default class extends Controller {
  static targets = ["payButton"];
  static values = {
    key: String,
    sessionId: String,
  };

  connect() {
    this.payButtonTarget.addEventListener("click", () => {
      const stripe = Stripe(this.keyValue);
      stripe.redirectToCheckout({
        sessionId: this.sessionIdValue,
      });
    });
  }
}
