### Users

##### CREATE
Usado para cadastrar novos usuários.

`curl -H "Content-Type: application/json" -X POST -d '{"user":{"name":"Guilherme","email":"ghsehn@gmail.com","password":"abc123"}}' https://caronas-unisc.herokuapp.com/api/v1/users`

##### LIST
`curl -X GET https://caronas-unisc.herokuapp.com/api/v1/users`

##### READ
`curl -X GET https://caronas-unisc.herokuapp.com/api/v1/users/1`

##### UPDATE
`curl -H "Content-Type: application/json" -X PUT -d '{"user":{"name":"Guilherme","email":"ghsehn@gmail.com","password":"abc123"}}' https://caronas-unisc.herokuapp.com/api/v1/users/1`

##### DELETE
`curl -X DELETE https://caronas-unisc.herokuapp.com/api/v1/users/1`

##### TO-DO:
- permissionar os métodos READ/UPDATE/DELETE para só o próprio usuário poder chamar.
- remover o método LIST

### Sessions

##### CREATE
Para fazer login.

`curl -H "Content-Type: application/json" -X POST -d '{"email":"ghsehn@gmail.com","password":"abc123"}' https://caronas-unisc.herokuapp.com/api/v1/sessions`

##### DELETE
Ao fazer logout pelo app, chamar essa URL para excluir a sessão do servidor.

`curl -X DELETE https://caronas-unisc.herokuapp.com/api/v1/sessions/WkEiGHYJwHpc2DuD4Wu2qynX`
