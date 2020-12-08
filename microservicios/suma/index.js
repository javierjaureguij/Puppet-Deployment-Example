/* IMPORTS */

const express = require("express");
const bodyParser = require('body-parser');
const router = express.Router();
const cors = require('cors');
const app = express();

/* CONFIGURACIONES */

const API_CONFIG_PUERTO = 8080

app.use(cors());
app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));

router.post('/post/suma', function(req, res) {
	let operador1 = parseInt(req.body.operador1);
	let operador2 = parseInt(req.body.operador2);
	res.send({
		resultado: operador1 + operador2
	});
});

/* PUBLICACIÓN */
app.use('/', router);
app.listen(API_CONFIG_PUERTO, () => {
	console.log('El servidor está inicializado en el puerto ' + API_CONFIG_PUERTO);
});

module.exports.API_CONFIG_PUERTO = API_CONFIG_PUERTO;
