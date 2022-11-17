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
    const endTarget = this.endTarget;
    const price = this.priceTarget.innerHTML.slice(1);
    let startDate, endDate;

    flatpickr(this.startTarget, {
      disable: unavailableDates,
      minDate: "today",
      dateFormat: "d-m-Y",
      onChange: function (selectedDates) {
        startDate = new Date(selectedDates[0]);

        // set minimum date for the end target
        let endMinDate = selectedDates[0];
        endMinDate.setDate(endMinDate.getDate() + 1);
        endPicker.set("minDate", endMinDate);

        // Make end date field clickable
        endTarget.disabled = false;

        // set maximum date for the end target as being the last date between the minimum end date and the next booking
        setMaxEndDate(endMinDate);

        // Change total if it was already displayed, and hide total if the start date was changed to a date later than the original end date
        endTarget.value !== "" ? displayTotal() : hideTotal();
      },
    });

    const endPicker = flatpickr(this.endTarget, {
      disable: unavailableDates,
      dateFormat: "d-m-Y",
      onChange: function (selectedDates) {
        // display the total amount to pay
        endDate = new Date(selectedDates[0]);
        displayTotal();
      },
    });

    const calculateNumberOfNights = () => {
      const millisecondsPerDay = 1000 * 60 * 60 * 24;
      return (endDate - startDate) / millisecondsPerDay;
    };

    const displayTotal = () => {
      const millisecondsPerDay = 1000 * 60 * 60 * 24;
      const numberOfNights = (endDate - startDate) / millisecondsPerDay;
      this.totalTarget.innerHTML = `Total: ${numberOfNights} ${
        numberOfNights === 1 ? "night" : "nights"
      } x ${price} = £${numberOfNights * price}`;
    };

    const hideTotal = () => {
      this.totalTarget.innerHTML = "";
    };

    const setMaxEndDate = (minDate) => {
      // if the user selected a date just before a booking as a start date, display no available end date as a booking must include at least 1 night
      let maxDate;
      for (let i = 0; i < bookingsStartDates.length; i++) {
        const firstUnavailableDate = new Date(bookingsStartDates[i]);
        if (minDate <= firstUnavailableDate) {
          maxDate = firstUnavailableDate;
          break;
        }
      }
      endPicker.set("maxDate", maxDate);
    };
  }
}
