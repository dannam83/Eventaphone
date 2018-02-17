var EventAdder = function($el) {
  this.$form = $el.find("form");
  this.$events = $el.find("ul");
};

module.exports = EventAdder;
