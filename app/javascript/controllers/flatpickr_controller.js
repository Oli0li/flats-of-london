import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["start", "end"];

  connect() {
    const unavailableDates = JSON.parse(this.element.dataset.unavailable);
    const bookingsStartDates = JSON.parse(
      this.element.dataset.firstUnavailableDates
    );

    flatpickr(this.startTarget, {
      disable: unavailableDates,
      minDate: "today",
      dateFormat: "d-m-Y",
      onChange: function (selectedDates) {
        // set minimum date for the end target
        let endMinDate = selectedDates[0];
        endMinDate.setDate(endMinDate.getDate() + 1);
        endPicker.set("minDate", endMinDate);

        // set maximum date for the end target
        // if the user selected a date just before a booking, they cannot select an end date as a booking must include at least 1 night
        let maxDate;
        for (let i = 0; i < bookingsStartDates.length; i++) {
          const firstUnavailableDate = new Date(bookingsStartDates[i]);
          if (endMinDate <= firstUnavailableDate) {
            maxDate = firstUnavailableDate;
            break;
          }
        }
        endPicker.set("maxDate", maxDate);
      },
    });

    // Setting the minimum date for end date to tomorrow in case some users start with the end date
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);

    const endPicker = flatpickr(this.endTarget, {
      disable: unavailableDates,
      dateFormat: "d-m-Y",
      minDate: tomorrow,
    });
  }
}
