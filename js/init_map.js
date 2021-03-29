var initVoice2 = function() {
if (annyang) {
  Shiny.onInputChange('txt', 'NA');
  var commands = {
      'country *txt': function(x) {
      Shiny.onInputChange('txt', x);
    }
  };
  annyang.setLanguage("es-VE");
  annyang.addCommands(commands);
  annyang.start();
  //Establecemos el lenguaje, en mi caso es español de México (puedes ver la lista completa de lenguajes soportados aquí).

  }
};

$(function() {
  setTimeout(initVoice2, 10);
});
