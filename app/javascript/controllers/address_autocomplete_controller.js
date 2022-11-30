import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static targets = ["address"];
  static values = { apiKey: String };

  connect() {
    const autofill = mapboxsearch.autofill({
      accessToken: this.apiKeyValue,
      options: {
        country: "gb",
        bbox: [-0.351708, 51.384527, 0.153177, 51.669993],
      },
    });

    autofill.addEventListener("retrieve", async (event) => {
      const fullAddress = event.detail.features[0].properties.full_address;
      this.addressTarget.value = await fullAddress;
    });
  }
}
