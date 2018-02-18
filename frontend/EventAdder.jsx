class EventAdder {
  constructor($el){
    this.$form = $el.find("form");
    this.$events = $el.find("ul");

    this.$form.on("submit", this.submitEvent.bind(this));
  }

  submitEvent(e){
    e.preventDefault();
    $.ajax({
      method: "post",
      url: "/api/events",
      dataType: "json",
      data: this.$form.serialize(),
      success: function(event){
        this.addEvent(event);
        this.clearForm();
      }.bind(this),
      error: function(){
        alert("Error. Not able to save event.");
      }
    });
  }

  addEvent(event){
    $(".noEventsMarker").remove();
    const $event = $("<li></li>").text(
      `${event.name}: ${event.summary}`
    );
    this.$events.append($event);
  }

  clearForm(){
    this.$form.find("input[type='text']").val("");
    this.$form.find("textarea").val("");
  }

}

module.exports = EventAdder;
