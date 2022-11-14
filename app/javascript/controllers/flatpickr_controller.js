import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["start", "end", "price", "total"];

  connect() {
    const unavailableDates = JSON.parse(this.element.dataset.unavailable);
    const bookingsStartDates = JSON.parse(
      this.element.dataset.firstUnavailableDates
    );
    const startTarget = this.startTarget;
    const endTarget = this.endTarget;
    const price = this.priceTarget.innerHTML.slice(1);
    const totalTarget = this.totalTarget;
    let startDate, endDate;

    flatpickr(this.startTarget, {
      disable: unavailableDates,
      minDate: "today",
      dateFormat: "d-m-Y",
      onChange: function (selectedDates) {
        console.log(`start : ${startTarget}`);
        startDate = new Date(selectedDates[0]);
        console.log(`start date: ${startDate}`);
        // set minimum date for the end target
        let endMinDate = selectedDates[0];
        endMinDate.setDate(endMinDate.getDate() + 1);
        endPicker.set("minDate", endMinDate);

        // Make end date field clickable
        endTarget.disabled = false;

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
        console.log(endTarget);
      },
    });

    // Setting the minimum date for end date to tomorrow in case some users start with the end date
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);

    const endPicker = flatpickr(this.endTarget, {
      disable: unavailableDates,
      dateFormat: "d-m-Y",
      minDate: tomorrow,
      onChange: function (selectedDates) {
        // display the total amount to pay
        endDate = new Date(selectedDates[0]);
        const millisecondsPerDay = 1000 * 60 * 60 * 24;
        const numberOfNights = (endDate - startDate) / millisecondsPerDay;
        totalTarget.innerHTML = `Total: ${numberOfNights} ${
          numberOfNights === 1 ? "night" : "nights"
        } x ${price} = £${numberOfNights * price}`;
      },
    });
  }
}
