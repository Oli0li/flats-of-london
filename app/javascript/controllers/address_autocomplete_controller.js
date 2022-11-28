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

    autofill.addEventListener("retrieve", (event) => {
      const featureCollection = event.detail;
      console.log(featureCollection);
      console.log(featureCollection.features[0].properties.full_address);
      console.log(this.addressTarget);
      this.addressTarget.setAttribute(
        "value",
        featureCollection.features[0].properties.full_address
      );
      console.log(`value : ${this.addressTarget.value}`);
      console.log(`target: ${this.addressTarget}`);
    });

    // console.log(this.addressTarget);
    // this.addressTarget.addEventListener("keyup", () => {
    //   const mapboxSearchListbox = document.getElementsByTagName(
    //     "mapbox-search-listbox"
    //   );
    //   const seed = mapboxSearchListbox[0].dataset.seed;
    //   console.log(mapboxSearchListbox);
    //   console.log(seed);
    //   const suggestions = document.getElementsByClassName(
    //     `${seed}--Suggestion`
    //   );
    //   console.log(suggestions);
    //   Array.from(suggestions).forEach((suggestion) => {
    //     suggestion.addEventListener("click", () => {
    //       const fullAddress = suggestion.getElementsByClassName(
    //         `${seed}--SuggestionDesc`
    //       );
    //       console.log(fullAddress[0].innerHTML);
    //       this.addressTarget.value = fullAddress[0].innerHTML;
    //     });
    //   });
    // });
  }
}
