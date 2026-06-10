-- create table
-- quando usar: criar tabela com estrutura e restricoes
-- obs prova: tipos principais
--   int / integer, smallint, bigint
--   numeric(precisao, escala), serial (auto incremento)
--   char(n) fixo, varchar(n) variavel, text
--   date ('YYYY-MM-DD'), time, timestamp, boolean

-- exemplo simples
create table aluno (
    matricula numeric(10),
    nome varchar(120),
    genero smallint,
    primary key (matricula)
);

-- exemplo intermediario (constraint na coluna)
create table ambulatorio2 (
    nroa int primary key,
    andar numeric(3) not null,
    capacidade smallint
);

-- exemplo estilo prova
-- chave primaria, estrangeira, unique, not null e check juntos
create table medico2 (
    codm int,
    nome varchar(40) not null,
    idade smallint not null check (idade >= 16),
    especialidade char(20),
    cpf numeric(11) unique,
    cidade varchar(30),
    nroa int not null,
    primary key (codm),
    foreign key (nroa) references ambulatorio2 (nroa)
);

-- chave primaria composta
create table consulta2 (
    codm int,
    codp int,
    data date,
    hora time,
    primary key (codm, codp, data, hora)
);

-- limpa os testes
drop table consulta2;
drop table medico2;
drop table ambulatorio2;
drop table aluno;
