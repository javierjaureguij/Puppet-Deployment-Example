let index = require('../index');
let API_CONFIG_PUERTO = index.API_CONFIG_PUERTO;
let API_URL = 'http://localhost:' + API_CONFIG_PUERTO + '';

let chai = require('chai');
let chaiHttp = require('chai-http');
const expect = require('chai').expect;

chai.use(chaiHttp);

describe('Realizando test unitario de suma... ', () => {
	it('Deberia devolver 100', (done) => {
		chai.request(API_URL)
            .post('/post/suma')
            .send({
                operador1: '60',
                operador2: '40'
            })
			.end(function(err, res) {
				console.log(res.body)
                expect(res.body.resultado).to.equal(100); // Se espera que el resultado sea 100.
				done();
			});
	});
});