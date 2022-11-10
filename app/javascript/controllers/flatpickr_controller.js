import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["start", "end"];

  connect() {
    const unavailableDates = JSON.parse(this.element.dataset.unavailable);
    const lastAvailableDates = JSON.parse(this.element.dataset.lastavailable);
    console.log(`unavailable dates : ${lastAvailableDates}`);
    console.log(`last unavailable dates : ${lastAvailableDates[2]}`);

    flatpickr(this.startTarget, {
      disable: unavailableDates,
      minDate: "today",
      dateFormat: "d-m-Y",
      onChange: function (selectedDates) {
        let minDate = selectedDates[0];
        minDate.setDate(minDate.getDate() + 1);
        endPicker.set("minDate", minDate);

        console.log(`minDate: ${minDate}`);
        let lastAvailable = new Date(lastAvailableDates[2]);
        console.log(minDate < lastAvailable);
        let maxDate;
        for (let i = 0; i < lastAvailableDates.length; i++) {
          console.log(minDate, lastAvailableDates[i]);
          if (minDate < new Date(lastAvailableDates[i])) {
            maxDate = new Date(lastAvailableDates[i]);
            break;
          }
        }
        endPicker.set("maxDate", maxDate);
        console.log(maxDate);
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
