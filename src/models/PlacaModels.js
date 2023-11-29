let mongoose = require('mongoose');

let placaSchema = mongoose.Schema({
    placas: {
        type: String,
        required: true
   },
    dadosDaPlaca: String,
    renavam: String,
    status: {
        type: String,
        enum: ['AJUIZADA', 'NÃO AJUIZADA', 'AJUIZADO', 'ajuizado', 'ajuizada']
    },
    create: {
        type: Date,
        default: Date.now
    }
});

let Placa = module.exports = mongoose.model('placa', placaSchema);

// Cada vez que fizermos uma solicitação GET, isso será executado
module.exports.get = function(callback, limit) {
    Placa.find(callback).limit(limit);
}


// PlacaModel.js
//const mongoose = require('mongoose');
//const Schema = mongoose.Schema;

//const placaSchema = new Schema({
//  placas: String,
//  dadosDaPlaca: String,
//  renavam: String,
//  status: String
//});

//const Placa = mongoose.model('Placa', placaSchema);

//module.exports = Placa;

