const app = require('./app')
require('./connection');

async function init() {
     app.listen(3000);
    
    console.log('Server on Localhost:3000')
}

init();