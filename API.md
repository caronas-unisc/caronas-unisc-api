### Users

##### CREATE
Usado para cadastrar novos usuários.

`curl -H "Content-Type: application/json" -X POST -d '{"user":{"name":"Guilherme","email":"ghsehn@gmail.com","password":"abc123","ride_intention":"give_ride"}}' https://caronas-unisc.herokuapp.com/api/v1/users`

O valor de `ride_intention` pode ser `give_ride`, `receive_ride` ou `give_and_receive_ride`. Se não for enviado, será cadastrado com o valor `give_and_receive_ride`.

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

### Password resets

### Sessions
Usado para iniciar recuperação de senha.

`curl -H "Content-Type: application/json" -X POST -d '{"email":"ghsehn@gmail.com"}' http://localhost:3000/api/v1/password_resets`

##### CREATE
Para fazer login.

`curl -H "Content-Type: application/json" -X POST -d '{"email":"ghsehn@gmail.com","password":"abc123"}' https://caronas-unisc.herokuapp.com/api/v1/sessions`

##### DELETE
Ao fazer logout pelo app, chamar essa URL para excluir a sessão do servidor.

`curl -X DELETE https://caronas-unisc.herokuapp.com/api/v1/sessions/WkEiGHYJwHpc2DuD4Wu2qynX`

##### INFO
Para ler informações do usuário logado. É preciso passar o token do usuário logado via header.

`curl -H "Authentication-Token: KTjii5ZzwU24BNmdj5QAc7fJ" -X GET https://caronas-unisc.herokuapp.com/api/v1/sessions/info`