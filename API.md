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