module.exports = (app) => {
    const passengers = require('../controllers/passenger.controller.js');

    // Create a new Note
    app.post('/passengers', passengers.create);

    // Retrieve all passengers
    app.get('/passengers', passengers.findAll);

    // Retrieve a single Note with passengerId
    app.get('/passengers/:passengerId', passengers.findOne);

    // Update a Note with passengerId
    app.put('/passengers/:passengerId', passengers.update);

    // Delete a Note with passengerId
    app.delete('/passengers/:passengerId', passengers.delete);
}