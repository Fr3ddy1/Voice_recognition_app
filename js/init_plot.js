var initVoice1 = function() {
if (annyang) {
  var bigger = 1;
  Shiny.onInputChange('title', 'say title something');
  Shiny.onInputChange('color', 'black');
  Shiny.onInputChange('bigger', 1);
  var commands = {
    'title *title': function(title) {
      Shiny.onInputChange('title', title);
    },
    'color :color': function(color) {
      Shiny.onInputChange('color', color);
    },
    'bigger': function() {
      bigger += 1;
      Shiny.onInputChange('bigger', bigger);
    },
    'smaller': function() {
      if (bigger >= 1.5) {
        bigger -= 1;
        Shiny.onInputChange('bigger', bigger);
      }
    }
  };
  annyang.addCommands(commands);
  annyang.start();
  }
};

$(function() {
  setTimeout(initVoice1, 10);
});
