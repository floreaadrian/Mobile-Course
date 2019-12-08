const mongoose = require('mongoose');

const PassengerSchema = mongoose.Schema({
    name: String,
    email: String,
    airplaneName: String,
    seatPosition: String,
    id: Number
}, {
    timestamps: true
});

module.exports = mongoose.model('Passenger', PassengerSchema);