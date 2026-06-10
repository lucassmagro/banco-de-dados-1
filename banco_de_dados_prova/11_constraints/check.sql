-- check
-- quando usar: validar valores permitidos na coluna
-- obs prova: check roda na insercao e atualizacao
--            pode usar operadores e funcoes simples

-- exemplo simples
create table teste_chk1 (
    id int primary key,
    idade smallint check (idade >= 0)
);

-- exemplo intermediario (check com lista de valores)
create table teste_chk2 (
    id int primary key,
    status varchar(10) check (status in ('ativo', 'inativo', 'ferias'))
);

-- exemplo estilo prova
-- check nomeado e adicionado via alter
create table teste_chk3 (
    id int primary key,
    salario numeric(10,2),
    cargo varchar(20)
);
alter table teste_chk3 add constraint chk_salario check (salario >= 900);
alter table teste_chk3 add constraint chk_cargo
    check (cargo in ('estagiario', 'tecnico', 'gerente'));

-- remover constraint
alter table teste_chk3 drop constraint chk_salario;

-- limpeza
drop table teste_chk3;
drop table teste_chk2;
drop table teste_chk1;
