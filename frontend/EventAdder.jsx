class EventAdder {
  constructor($el){
    this.$form = $el.find("form");
    this.$events = $el.find("ul");

    this.$form.on("submit", this.submitMessage.bind(this));
  }

  submitMessage(e){
    e.preventDefault();
    $.ajax({
      method: "post",
      url: "/api/events",
      dataType: "json",
      data: this.$form.serialize(),
      success: function(){
        alert("hooray it worked");
      },
      error: function(){
        alert("Error. Not able to save event.");
      }
    });
  }

}

module.exports = EventAdder;
