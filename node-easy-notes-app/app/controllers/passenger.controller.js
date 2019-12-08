const Passenger = require('../models/passenger.model.js');

// Create and Save a new Passenger
exports.create = (req, res) => {
    // Validate request
    if (!req.body.name) {
        return res.status(400).send({
            message: "Passenger content can not be empty"
        });
    }

    // Create a Passenger
    const passenger = new Passenger({
        name: req.body.name || "Untitled Passenger",
        email: req.body.email,
        airplaneName: req.body.airplaneName,
        seatPosition: req.body.seatPosition,
        id: req.body.id
    });

    // Save Passenger in the database
    passenger.save()
        .then(data => {
            res.send(data);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while creating the Passenger."
            });
        });
};

// Retrieve and return all passengers from the database.
exports.findAll = (req, res) => {
    Passenger.find()
        .then(passengers => {
            res.send(passengers);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving passengers."
            });
        });
};

// Find a single passenger with a passengerId
exports.findOne = (req, res) => {
    Passenger.findById(req.params.passengerId)
        .then(passenger => {
            if (!passenger) {
                return res.status(404).send({
                    message: "Passenger not found with id " + req.params.passengerId
                });
            }
            res.send(passenger);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "Passenger not found with id " + req.params.passengerId
                });
            }
            return res.status(500).send({
                message: "Error retrieving passenger with id " + req.params.passengerId
            });
        });
};

// Update a passenger identified by the passengerId in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body.name) {
        return res.status(400).send({
            message: "Passenger content can not be empty"
        });
    }

    // Find passenger and update it with the request body
    Passenger.findByIdAndUpdate(req.params.passengerId, {
            name: req.body.name || "Untitled Passenger",
            email: req.body.email,
            airplaneName: req.body.airplaneName,
            seatPosition: req.body.seatPosition,
            id: req.body.id
        }, {
            new: true
        })
        .then(passenger => {
            if (!passenger) {
                return res.status(404).send({
                    message: "Passenger not found with id " + req.params.passengerId
                });
            }
            res.send(passenger);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "Passenger not found with id " + req.params.passengerId
                });
            }
            return res.status(500).send({
                message: "Error updating passenger with id " + req.params.passengerId
            });
        });
};

// Delete a passenger with the specified passengerId in the request
exports.delete = (req, res) => {
    console.log(req.params.passengerId);
    Passenger.findByIdAndRemove(req.params.passengerId)
        .then(passenger => {
            if (!passenger) {
                return res.status(404).send({
                    message: "Passenger not found with id " + req.params.passengerId
                });
            }
            res.send({
                message: "Passenger deleted successfully!"
            });
        }).catch(err => {
            if (err.kind === 'ObjectId' || err.name === 'NotFound') {
                return res.status(404).send({
                    message: "Passenger not found with id " + req.params.passengerId
                });
            }
            return res.status(500).send({
                message: "Could not delete passenger with id " + req.params.passengerId
            });
        });
};