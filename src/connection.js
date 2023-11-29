const mongoose = require('mongoose')
require('dotenv').config();

mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true, useCreateIndex: true });

const db = mongoose.connection;

db.on('error', (err) => {
    console.error('Erro de conexão com o banco de dados: ' + err);
});

db.once('open', () => {
    console.log('Conexão com o banco de dados MongoDB bem-sucedida!');
});


//mongoose.connect('mongodb://localhost:27017/storedb', {
//    useNewUrlParser: true,
//    useUnifiedTopology: true,
//    useCreateIndex: true
//}).then(db => console.log('Connection establishe successfully'))