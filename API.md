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

#### REPEAT
Repetir as disponibilidades de carona do usuário logado para a semana passada.

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -X PATCH https://caronas-unisc.herokuapp.com/api/v1/ride_availabilities/week/repeat`

A chamada trará na resposta as disponibilidades de carona criadas para a semana atual.

Obs.: Se já houverem disponibilidades de carona definidas para a semana atual, estas serão excluídas.

### Rides

#### MATCHES
Busca matches para o usuário logado atualmente. Este endpoint retorna um objeto JSON com duas seções: "give" e "receive".

Na seção "receive", irão aparecer as disponibilidades das pessoas que podem dar carona para o usuário logado.
Ele irá casar todas as pessoas na situação oposta. Por exemplo: usuário atual quer receber carona na segunda e terça à noite.
Nesse caso, na seção "receive" serão listados usuários que podem dar carona na segunda e terça de noite, caso disponíveis.

Na seção "give", irão aparecer as pessoas que pediram carona para o usuário logado atual.
Ou seja, se o usuário logado quiser dar carona na quarta e sexta à noite, nessa seção aparecerão usuários que voluntariamente
pediram ao usuário atual uma carona nessas datas/períodos. Não irão aparecer matches em que usuários não pediram a carona.

Para chamar este método, usar:

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -X GET https://caronas-unisc.herokuapp.com/api/v1/rides/matches`

Exemplo de retorno:

```javascript
{
	"receive": [
		{
			"availability_id": 1,
			"period": "night",
			"date": "2015-11-23", // segunda-feira
			"user_name": "João",
			"remaining_places_in_car": 1,
			"ride": null // ride é null nesse registro porque o usuário atual não pediu carona para o Fulano
		},
		{
			"availability_id": 2,
			"period": "night",
			"date": "2015-11-23", // segunda-feira
			"user_name": "Felipe",
			"remaining_places_in_car": 3,
			"ride": { // usuário atual pediu carona para o Felipe
				"id": 5,
				"status": "pending" // a carona requisitada está pendente (o Felipe, outro usuário, precisa aprovar)
			}
		},
		{
			"availability_id": 3,
			"period": "night",
			"date": "2015-11-24", // terça-feira
			"user_name": "Felipe",
			"remaining_places_in_car": 2,
			"ride": { // usuário atual pediu carona para o Felipe
				"id": 6,
				"status": "accepted" // o Felipe (outro usuário) aceitou dar a carona
			}
		},
	],
	"give": [
		{
			"availability_id": 4,
			"period": "night",
			"date": "2015-11-25", // quarta-feira
			"user_name": "André", // o André pediu carona para o usuário atual
			"ride": {
				"id": 7,
				"status": "pending" // o usuário atual ainda não aceitou o pedido de carona do André
			}
		}
	]
}
```

#### CREATE
Chamar esse endpoint para pedir carona. É necessário passar o ID da availability da pessoa que quer dar carona no corpo. Por exemplo,
se o usuário atual quer pedir carona para o João na segunda-feira (availability_id 1), chamar:

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -H "Content-Type: application/json" -X POST -d '{"ride_availability_id":1}' https://caronas-unisc.herokuapp.com/api/v1/rides`

Ao fazer isso, será criada uma "ride" no sistema com status "pending", relacionada à ride availability de receber carona do usuário atual, e à
ride availability de dar carona do João.

#### UPDATE
Chamar esse endpoint para aprovar um pedido de carona feito por outra pessoa. É necessário passar o ID da carona na URL e o status no corpo. Por exemplo,
se o usuário atual quer aceitar o pedido de carona do André para quarta à noite (ride id = 7), deve chamar:

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -H "Content-Type: application/json" -X PATCH -d '{"ride":{"status":"accepted"}}' https://caronas-unisc.herokuapp.com/api/v1/rides/7`

#### READ

Para ver os dados de uma carona.

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -X GET https://caronas-unisc.herokuapp.com/api/v1/rides/:ride_id`

Onde `:ride_id` é o ID da carona.

### Chat

#### LIST

Para listar as mensagens:

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -X GET https://caronas-unisc.herokuapp.com/api/v1/rides/:ride_id/messages`

Onde `:ride_id` é o ID da carona.

Opcionalmente é possível passar o parâmetro `last_id` como query string, para buscar apenas as mensagens com ID acima do especificado. Exemplo: `https://caronas-unisc.herokuapp.com/api/v1/rides/:ride_id/messages?last_id=10`

#### CREATE

Para enviar mensagem no chat:

`curl -H "Authentication-Token: oNBBAK6kktjSvmx2tn4mvYnX" -H "Content-Type: application/json" -X POST -d '{"message":{"body":"olar"}}' https://caronas-unisc.herokuapp.com/api/v1/rides/:ride_id/messages`