import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["start", "end"];

  connect() {
    const unavailableDates = JSON.parse(this.element.dataset.unavailable);

    flatpickr(this.startTarget, {
      disable: unavailableDates,
      minDate: "today",
      dateFormat: "d-m-Y",
      onChange: function (selectedDates) {
        let minDate = selectedDates[0];
        minDate.setDate(minDate.getDate() + 1);
        endPicker.set("minDate", minDate);
      },
    });

    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);

    const endPicker = flatpickr(this.endTarget, {
      disable: unavailableDates,
      dateFormat: "d-m-Y",
      minDate: tomorrow,
    });
  }
}
