#### Descripción

Microservicio para obtener el historial de transacciones. Las columnas del reporte son:

- id_transaccion
- Tipo
- fecha
- descripcion
- telefono_cliente
- usuario

#### Crear imagen docker

```
docker build . -t ayd2/reportetransacciones:latest
docker run -p 8081:8080 -d ayd2/reportetransacciones:latest
```

#### URL del Microservicio
```
http://localhost:8081/transacciones/post/reporte
```

#### Tipo de REQUEST
```
POST
```
#### Parámetros
```json
{
    "fecha_inicio": "2020-10-20",
    "fecha_fin": "2020-10-30"
}
```
**Nota:** Las fechas deben ir en formato **yyyy-MM-dd**

#### Respuestas

##### - Éxito
```json
{
	"codigo": 1,
	"mensaje": "Se obtuvo el reporte correctamente",
	"data": [
            {
                "id_transaccion": 1,
                "Tipo": "Depósito",
                "fecha": "2020-10-25T00:00:00.000Z",
                "descripcion": "Deposito de 100 billetes de Q.200, 100 billetes de Q.100, 50 billetes de Q.50, 1000 billetes de Q.20, 1000 billetes de Q.10, 2000 billetes de Q.5",
                "telefono_cliente": null,
                "usuario": "admin"
            },
            {
                "id_transaccion": 3,
                "Tipo": "Depósito",
                "fecha": "2020-10-25T00:00:00.000Z",
                "descripcion": "Deposito de 100 billetes de Q.5",
                "telefono_cliente": null,
                "usuario": "admin"
            },
            {
                "id_transaccion": 6,
                "Tipo": "Depósito",
                "fecha": "2020-10-23T13:05:22.000Z",
                "descripcion": "Deposito de 50 billetes de Q.10",
                "telefono_cliente": null,
                "usuario": "admin"
            }
	]
}
```

##### - Error
```json
{
	"codigo": 0,
	"mensaje": "Ocurrió un error tal y tal"
}
```

#### Ejecutar Tests
```
npm run test
```
