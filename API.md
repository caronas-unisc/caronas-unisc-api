### Users

##### CREATE
Usado para cadastrar novos usuários.

`curl -H "Content-Type: application/json" -X POST -d '{"user":{"name":"Guilherme","email":"ghsehn@gmail.com","password":"abc123","ride_intention":"give_ride"}}' https://caronas-unisc.herokuapp.com/api/v1/users`

O valor de `ride_intention` pode ser `give_ride`, `receive_ride` ou `give_and_receive_ride`. Se não for enviado, será cadastrado com o valor `give_and_receive_ride`.

##### READ
`curl -X GET https://caronas-unisc.herokuapp.com/api/v1/users/1`

##### UPDATE
Para atualizar informações do usuário logado. É preciso passar o token do usuário logado via header.

`curl -H "Authentication-Token: MdCTNVZDgs1wskn9x4o2NXmm" -H "Content-Type: application/json" -X PATCH -d '{"user":{"name":"Guilherme","password":"abc123","intention":"give_ride"}}' https://caronas-unisc.herokuapp.com/api/v1/users/update`

TO-DO: Deixar essa URL mais "RESTful", usando algo como `PATCH /me` - http://blog.2partsmagic.com/restful-uri-design/

### Password resets

### Sessions
Usado para iniciar recuperação de senha.

`curl -H "Content-Type: application/json" -X POST -d '{"email":"ghsehn@gmail.com"}' https://caronas-unisc.herokuapp.com/api/v1/password_resets`

##### CREATE
Para fazer login.

`curl -H "Content-Type: application/json" -X POST -d '{"email":"ghsehn@gmail.com","password":"abc123"}' https://caronas-unisc.herokuapp.com/api/v1/sessions`

##### DELETE
Ao fazer logout pelo app, chamar essa URL para excluir a sessão do servidor.

`curl -X DELETE https://caronas-unisc.herokuapp.com/api/v1/sessions/WkEiGHYJwHpc2DuD4Wu2qynX`

##### INFO
Para ler informações do usuário logado. É preciso passar o token do usuário logado via header.

`curl -H "Authentication-Token: KTjii5ZzwU24BNmdj5QAc7fJ" -X GET https://caronas-unisc.herokuapp.com/api/v1/sessions/info`