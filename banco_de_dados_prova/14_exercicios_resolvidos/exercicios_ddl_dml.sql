-- exercicios ddl e dml

-- 1. criar tabela exame com pk, fk para paciente e check de resultado
create table exame (
    cod_exame serial primary key,
    codp int not null references paciente (codp),
    tipo varchar(30) not null,
    data date default current_date,
    resultado varchar(10) check (resultado in ('positivo', 'negativo', 'inconclusivo'))
);

-- 2. adicionar coluna observacao na tabela exame
alter table exame add column observacao text;

-- 3. inserir exames
insert into exame (codp, tipo, resultado)
values (1, 'hemograma', 'positivo');
insert into exame (codp, tipo, data, resultado)
values (2, 'raio-x', '2018-10-15', 'negativo');
insert into exame (codp, tipo, resultado, observacao)
values (3, 'ultrassom', 'inconclusivo', 'repetir em 30 dias');

-- 4. atualizar resultado do exame do paciente 1
update exame set resultado = 'negativo' where codp = 1;

-- 5. deletar exames com resultado inconclusivo
delete from exame where resultado = 'inconclusivo';

-- 6. alterar tipo da coluna resultado para varchar(20)
alter table exame drop constraint exame_resultado_check;
alter table exame alter column resultado type varchar(20);
alter table exame add constraint exame_resultado_check
    check (resultado in ('positivo', 'negativo', 'inconclusivo', 'pendente'));

-- 7. criar indice na coluna tipo
create index idx_exame_tipo on exame (tipo);

-- 8. criar view de exames com nome do paciente
create or replace view exames_completos as
select e.cod_exame, p.nome as paciente, e.tipo, e.data, e.resultado
from exame e
join paciente p on p.codp = e.codp;

select * from exames_completos;

-- 9. renomear coluna tipo para tipo_exame
alter table exame rename column tipo to tipo_exame;

-- 10. limpar tudo
drop view exames_completos;
drop index idx_exame_tipo;
drop table exame;
