class EventAdder {
  constructor($el){
    this.$form = $el.find("form");
    this.$events = $el.find("ul");
    this.$form.on("submit", this.submitEvent.bind(this));
  }

  submitEvent(e){
    e.preventDefault();
    if ( !this.hasEmptyInput() ){
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
          alert("Error. Event not saved.");
        }
      });
    }
  }

  hasEmptyInput(){
    let empty = false;
    for (let i = 1; i < this.$form[0].length - 1; i++){
      const input = this.$form[0][i];
      if (input.value == false){
        empty = true;
        const field = input.name.slice(6, -1);
        alert(`Please fill in event ${field}.`);
        break;
      }
    }
    return empty;
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
