//const express = require('express');
//const app = express();

//app.use(express.json());
//app.use(express.urlencoded({ extended: false }))

//app.use(require('./controllers/authController'))

//module.exports = app;

////////////////////////////////

const express = require('express');
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use(require('./controllers/authController'));

const port = 3000;
const ipAddress = '192.168.1.57'; // Substitua pelo seu endereço IP

app.listen(port, ipAddress, () => {
  console.log(`Servidor rodando em http://${ipAddress}:${port}`);
});

module.exports = app;
/////////////////////////////


//const express = require('express');
//const https = require('https');
//const fs = require('fs');

//const app = express();

//app.use(express.json());
//app.use(express.urlencoded({ extended: false }));

//app.use(require('./controllers/authController'));

//const port = 3000;
//const ipAddress = '192.168.1.57'; // Substitua pelo seu endereço IP

// Configuração do certificado SSL/TLS
//const options = {
//  key: fs.readFileSync('src/certs/key.pem', 'utf8'),
//  cert: fs.readFileSync('src/certs/server.crt', 'utf8')
//};

//https.createServer(options, app).listen(port, ipAddress, () => {
//  console.log(`Servidor rodando em https://${ipAddress}:${port}`);
//});

//module.exports = app;

/////// outra versao

//const express = require('express');
//const app = express();

//app.use(express.json());
//app.use(express.urlencoded({ extended: false }));

// Configurar o cabeçalho Access-Control-Allow-Origin
//app.use((req, res, next) => {
//  res.setHeader('Access-Control-Allow-Origin', '*');
//  next();
//});

//app.use(require('./controllers/authController'));

//const port = 3000;
//const ipAddress = '192.168.1.57'; // Substitua pelo seu endereço IP

//app.listen(port, ipAddress, () => {
//  console.log(`Servidor rodando em http://${ipAddress}:${port}`);
//})//;

//module.exports = app;
