class EventAdder {
  constructor($el){
    this.$form = $el.find("form");
    this.$events = $el.find("ul");

    this.$form.on("submit", this.submitMessage.bind(this));
  }

  submitMessage(e){
    e.preventDefault();
    alert("nothing but the alert");
  }

}


module.exports = EventAdder;
