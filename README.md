# Caronas UNISC

### Dependências
- Ruby 2.2.2
- Rails 4.2.3

### Configurando o ambiente
1. Rodar o comando `bundle install` (instala as gems usadas no projeto)
2. Rodar o comando `rake db:create` (cria o banco de dados de desenvolvimento)
3. Rodar o comando `rake db:schema:load` (cria as tabelas do banco de dados)
4. Confiugurar remoto do heroku no git com `heroku git:remote -a caronas-unisc` (certificar-se antes de que está logado usando `heroku login`)
5. Iniciar o servidor com `rails s`

### Configurando servidor de e-mail
1. Crie um `.env` baseado nos moldes do `.env.example`, com dados de login do SendGrid

### Deploy
1. Rodar `git push heroku master`
2. Se houver novas migrations, rodar `heroku run rake db:migrate`

### Manual da API
Os métodos com exemplos em cURL estão no `API.md` nesse mesmo diretório.

O ambiente de produção está em https://caronas-unisc.herokuapp.com
