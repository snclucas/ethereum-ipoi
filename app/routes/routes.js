module.exports = function(app, passport) {

  app.get('/', function(req, res) {
    res.send('Hello World!');
  });

};