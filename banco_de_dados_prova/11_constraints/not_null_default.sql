-- not null e default
-- quando usar: not null impede valor nulo, default define valor padrao
-- obs prova: not null nao e constraint nomeavel (e restricao de coluna)
--            default e usado quando o insert omite a coluna

-- exemplo simples
create table teste_nn1 (
    id int primary key,
    nome varchar(40) not null
);

-- exemplo intermediario (default)
create table teste_nn2 (
    id int primary key,
    nome varchar(40) not null,
    ativo boolean default true,
    data_cadastro date default current_date
);
insert into teste_nn2 (id, nome) values (1, 'teste');
select * from teste_nn2;

-- exemplo estilo prova
-- adicionar e remover not null e default via alter
create table teste_nn3 (
    id int primary key,
    nome varchar(40),
    salario numeric(10,2)
);
alter table teste_nn3 alter column nome set not null;
alter table teste_nn3 alter column salario set default 1000;

-- remover
alter table teste_nn3 alter column nome drop not null;
alter table teste_nn3 alter column salario drop default;

-- limpeza
drop table teste_nn3;
drop table teste_nn2;
drop table teste_nn1;
