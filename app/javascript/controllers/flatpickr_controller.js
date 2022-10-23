import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    console.log("Hello flatpickr");
    const startDateInput = document.getElementById('booking_start_date');
    const endDateInput = document.getElementById('booking_end_date');

  if (startDateInput && endDateInput) {
    const unvailableDates = JSON.parse(document.querySelector('.widget-content').dataset.unavailable)

    flatpickr(startDateInput, {
    minDate: 'today',
    dateFormat: 'd-m-Y',
    disable: unvailableDates,
    onChange: function(selectedDates, selectedDate) {
      if (selectedDate === '') {
        endDateInput.disabled = true;
      }
      let minDate = selectedDates[0];
      minDate.setDate(minDate.getDate() + 1);
      endDateCalendar.set('minDate', minDate);
      endDateInput.disabled = false;
    }
  });
    const endDateCalendar =
      flatpickr(endDateInput, {
        dateFormat: 'd-m-Y',
        disable: unvailableDates,
        });
    };
  };
}
