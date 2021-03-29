var initVoice = function() {
if (annyang) {
  Shiny.onInputChange('type', 'setosa');
  var commands = {
    'type *type': function(type) {
      Shiny.onInputChange('type', type);
    }
  };
  annyang.addCommands(commands);
  annyang.start();
  }
};

$(function() {
  setTimeout(initVoice, 10);
});
