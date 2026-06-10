-- on delete e on update
-- quando usar: definir acao automatica quando a linha referenciada e alterada ou apagada
-- obs prova: opcoes: cascade, set null, set default, restrict, no action (padrao)
--            restrict = bloqueia; cascade = propaga; set null = coloca null

-- exemplo simples (cascade)
create table depto_ac (id int primary key, nome varchar(20));
create table func_ac (
    id int primary key,
    nome varchar(40),
    depto int references depto_ac (id)
        on delete cascade
        on update cascade
);
insert into depto_ac values (1, 'vendas');
insert into func_ac values (1, 'Ana', 1);

-- apagar depto apaga o funcionario junto
delete from depto_ac where id = 1;
select * from func_ac; -- vazio

-- exemplo intermediario (set null)
drop table func_ac;
drop table depto_ac;

create table depto_ac (id int primary key, nome varchar(20));
create table func_ac (
    id int primary key,
    nome varchar(40),
    depto int references depto_ac (id)
        on delete set null
        on update cascade
);
insert into depto_ac values (1, 'vendas');
insert into func_ac values (1, 'Ana', 1);

delete from depto_ac where id = 1;
select * from func_ac; -- depto fica null

-- exemplo estilo prova
-- criar fk com on delete set null e on update cascade via alter table
drop table func_ac;
drop table depto_ac;

create table depto_ac (id int primary key, nome varchar(20));
create table func_ac (
    id int primary key,
    nome varchar(40),
    depto int
);
alter table func_ac add constraint fk_depto
    foreign key (depto) references depto_ac (id)
    on delete set null
    on update cascade;

-- limpeza
drop table func_ac;
drop table depto_ac;
