API SISTEMAPP


A API contempla os endpoints:
	- Cadastro de Categoria de Produto
	- Cadastro de Produtos
	- Cadastro de Ordem de Venda
	- Cadastro de Funcionário
	- Cadastro de Clientes


Para executar deve ser criado um banco de dados utilizando o SQL Server na maquina local ou servido, 
o nome do banco de dados deve ser SistemaAPP.

Após o banco SistemaAPP criado no SQL Server o script da pasta do database deverá ser executado para 
a criação das tabelas, automaticamente serão criados dois usuários, um administrador e outro cliente.

	Usuário Administrador: administrador@email.com.br  Senha: 123

	Usuário Cliente: cliente@email.com Senha: 123

Junto ao projeto estão os script do Postman para execução de cadas Endpoint.

	Endpoint como Cliente: SistemaAPP - Cliente
	Endpoint como Administrador: SistemaAPP - Administrador

Como a solução em execução através da url abaixo é possível verificar toda a documentação dos Endpoints
e como executar cada um deles.

	Url: https://localhost:44381/swagger/index.html



Executar os Endpoints.

1º Receber o Token fazendo o login com dos dados do cliente/administrador.
2º Para executar os demais Endpoints utilize o toke gerado
	

	