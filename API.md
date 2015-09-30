### Users

##### LIST
`curl -X GET https://caronas-unisc.herokuapp.com/api/v1/users`

##### CREATE
`curl -H "Content-Type: application/json" -X POST -d '{"user":{"name":"Guilherme","email":"ghsehn@gmail.com","password":"abc123"}}' https://caronas-unisc.herokuapp.com/api/v1/users`

##### READ
`curl -X GET https://caronas-unisc.herokuapp.com/api/v1/users/1`

##### UPDATE
`curl -H "Content-Type: application/json" -X PUT -d '{"user":{"name":"Guilherme","email":"ghsehn@gmail.com","password":"abc123"}}' https://caronas-unisc.herokuapp.com/api/v1/users/1`

##### DELETE
`curl -X DELETE https://caronas-unisc.herokuapp.com/api/v1/users/1`

### Sessions

##### CREATE
Para fazer login.
`curl -H "Content-Type: application/json" -X POST -d '{"email":"ghsehn@gmail.com","password":"abc123"}' http://localhost:3000/api/v1/sessions`

##### DELETE
Para fazer logout e excluir a sessão.
`curl -X DELETE http://localhost:3000/api/v1/sessions/WkEiGHYJwHpc2DuD4Wu2qynX`
