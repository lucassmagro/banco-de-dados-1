-- serial e sequence
-- quando usar: gerar codigos automaticos para a chave primaria
-- obs prova: serial cria a sequence sozinho
--            jeito manual: create sequence + set default nextval

-- exemplo simples (tipo serial)
create table produto (
    id serial primary key,
    nome varchar(40)
);
insert into produto (nome) values ('soro');
insert into produto (nome) values ('gaze');
select * from produto;
drop table produto;

-- exemplo intermediario (sequence manual)
create table item (
    id int,
    nome varchar(40)
);
create sequence item_seq start 1;
alter table item alter column id set default nextval('item_seq');
insert into item (nome) values ('luva');
insert into item (nome) values ('mascara');

-- inserindo usando nextval manualmente
insert into item (id, nome) values (nextval('item_seq'), 'seringa');

select * from item;
drop table item;
drop sequence item_seq;

-- exemplo estilo prova
-- tabela de log com identificador automatico
create table log_teste (
    identificador serial primary key,
    tabela varchar(50),
    operacao varchar(10)
);
drop table log_teste;
