import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String };

  connect() {
    mapboxsearch.autofill({
      accessToken: this.apiKeyValue,
      options: {
        country: "gb",
        bbox: [-0.351708, 51.384527, 0.153177, 51.669993],
      },
    });
  }
}
