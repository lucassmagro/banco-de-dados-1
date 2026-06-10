-- create database
-- quando usar: criar um banco novo
-- obs prova: nao roda dentro de transacao, rodar fora do banco que esta criando
-- conexao no psql: psql -h localhost -U postgres -d clinica

-- exemplo simples
create database clinica;

-- exemplo intermediario (com dono e encoding)
create database clinica2
    with owner = postgres
    encoding = 'UTF8'
    connection_limit = -1;

-- exemplo estilo prova
-- crie um bd com nome Clinica
create database clinica;
