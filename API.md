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

#### CREATE
Usado para iniciar redefinição de senha, enviando e-mail para usuário.

`curl -H "Content-Type: application/json" -X POST -d '{"email":"ghsehn@gmail.com"}' https://caronas-unisc.herokuapp.com/api/v1/password_resets`

Os demais passos de redefinição de senha estão disponíveis apenas na interface web.

### Sessions

##### CREATE
Para fazer login.

`curl -H "Content-Type: application/json" -X POST -d '{"email":"ghsehn@gmail.com","password":"abc123"}' https://caronas-unisc.herokuapp.com/api/v1/sessions`

##### DELETE
Ao fazer logout pelo app, chamar essa URL para excluir a sessão do servidor.

`curl -X DELETE https://caronas-unisc.herokuapp.com/api/v1/sessions/WkEiGHYJwHpc2DuD4Wu2qynX`

##### INFO
Para ler informações do usuário logado. É preciso passar o token do usuário logado via header.

`curl -H "Authentication-Token: KTjii5ZzwU24BNmdj5QAc7fJ" -X GET https://caronas-unisc.herokuapp.com/api/v1/sessions/info`

### Ride availabilities

#### CREATE/UPDATE
Usado para criar uma disponibilidade de carona, que pode ser para receber carona ou dar carona.

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -H "Content-Type: application/json" -X PUT -d '{"ride_availability":**corpo**}' https://caronas-unisc.herokuapp.com/api/v1/ride_availabilities/:date/:period`

##### Parâmetros
Parâmetros da URL que identificam a data e período da disponibilidade.

| Nome   | Descrição |
| ------ | --------- |
| date   | Data da disponibilidade, em formato YYYY-MM-DD (exemplo: `2015-05-10`) |
| period | Período da disponibilidade (`morning`, `afternoon` ou `night`) |

Exemplo de URL montada: `https://caronas-unisc.herokuapp.com/api/v1/ride_availabilities/2015-05-10/night`

##### Corpo
Parâmetros a serem enviados no corpo da request em JSON. Eles ficam dentro da key `ride_availability` do objeto JSON.

| Nome | Descrição |
| ---- | --------- |
| availability_type | Se o usuário quer dar ou receber carona nesse dia e período. Valores possíveis: `give` e `receive` |
| starting_location_address | String com endereço de partida (só deve ser preenchido se `ride_availability` = `receive`) |
| starting_location_latitude | Latitude do endereço de partida (só deve ser preenchido se `ride_availability` = `receive`) |
| starting_location_longitude | Longitude do endereço de partida (só deve ser preenchido se `ride_availability` = `receive`) |
| available_places_in_car | Quantidade de locais disponíveis no carro (só deve ser preenchido se `ride_availability` = `give`) |

Exemplo de requisição final montada:

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -H "Content-Type: application/json" -X PUT -d '{"ride_availability":{"availability_type":"receive","starting_location_address":"Rua Marechal Floriano 50, Santa Cruz do Sul - RS","starting_location_latitude":-29.714920,"starting_location_longitude":-52.427807}}' https://caronas-unisc.herokuapp.com/api/v1/ride_availabilities/2015-05-10/night`

Ainda não desenvolvido: Cadastro de dados da rota quando usuário quer dar carona.

#### DELETE
Usado quando usuário cancela uma disponibilidade de carona para uma data/período.

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -H "Content-Type: application/json" -X DELETE https://caronas-unisc.herokuapp.com/api/v1/ride_availabilities/:date/:period`

#### GET
Permite buscar as disponibilidades de carona do usuário logado para uma determinada semana.

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -X GET https://caronas-unisc.herokuapp.com/api/v1/ride_availabilities/week/2015-10-15`

Passe como parâmetro uma data que faça parte da semana a ser consultada. No exemplo acima, ao passar a data 15/10/2015, o sistema irá retornar as caronas do dia 11/10/2015 (domingo, início da semana) até 17/10/2015 (sábado, fim da semana).