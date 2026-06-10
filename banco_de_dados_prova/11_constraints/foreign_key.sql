-- foreign key
-- quando usar: garantir integridade referencial entre tabelas
-- obs prova: fk referencia a pk (ou unique) de outra tabela
--            o valor da fk tem que existir na tabela referenciada ou ser null

-- exemplo simples (fk na coluna)
create table depto_fk (id int primary key, nome varchar(20));
create table func_fk (
    id int primary key,
    nome varchar(40),
    depto int references depto_fk (id)
);

-- exemplo intermediario (fk nomeada com constraint)
drop table func_fk;
create table func_fk (
    id int primary key,
    nome varchar(40),
    depto int,
    constraint fk_depto foreign key (depto) references depto_fk (id)
);

-- exemplo estilo prova
-- adicionar fk depois da criacao da tabela
drop table func_fk;
create table func_fk (
    id int primary key,
    nome varchar(40),
    depto int
);
alter table func_fk add constraint fk_depto
    foreign key (depto) references depto_fk (id);

-- limpeza
drop table func_fk;
drop table depto_fk;
