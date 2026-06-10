-- primary key
-- quando usar: identificar unicamente cada linha da tabela
-- obs prova: pk = unique + not null
--            pode ser simples (1 coluna) ou composta (2+ colunas)
--            cada tabela so pode ter UMA pk

-- exemplo simples (pk na coluna)
create table teste_pk1 (
    id int primary key,
    nome varchar(40)
);

-- exemplo intermediario (pk composta na constraint)
create table teste_pk2 (
    codm int,
    codp int,
    data date,
    primary key (codm, codp, data)
);

-- exemplo estilo prova
-- adicionar pk depois da criacao
create table teste_pk3 (
    id int,
    nome varchar(40)
);
alter table teste_pk3 add primary key (id);

-- limpeza
drop table teste_pk3;
drop table teste_pk2;
drop table teste_pk1;
