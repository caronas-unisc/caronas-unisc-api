##### CREATE
`curl -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"user":{"name":"Guilherme","email":"ghsehn@gmail.com","password":"abc123"}}' http://localhost:3000/api/v1/users`

##### READ
`curl -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://localhost:3000/api/v1/users/1`

##### UPDATE
`curl -H "Accept: application/json" -H "Content-Type: application/json" -X PUT -d '{"user":{"name":"Guilherme","email":"ghsehn@gmail.com","password":"abc123"}}' http://localhost:3000/api/v1/users/1`

##### DELETE
`curl -H "Accept: application/json" -H "Content-Type: application/json" -X DELETE http://localhost:3000/api/v1/users/1`
