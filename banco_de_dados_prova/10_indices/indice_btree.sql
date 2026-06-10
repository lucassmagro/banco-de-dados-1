-- indice btree
-- quando usar: buscas com =, <, >, <=, >=, between, order by, like 'abc%'
-- obs prova: btree e o tipo padrao do postgresql
--            se nao especificar using, cria btree automaticamente

-- exemplo simples
-- indice btree na coluna cidade do medico
create index idx_med_cidade_btree on medico using btree (cidade);

-- conferir se criou
select indexname, indexdef
from pg_indexes
where tablename = 'medico' and indexname = 'idx_med_cidade_btree';

-- exemplo intermediario
-- btree em coluna usada em order by
create index idx_func_salario_btree on funcionario using btree (salario);

-- a consulta abaixo aproveita o indice para ordenar
explain select nome, salario from funcionario order by salario;

-- exemplo estilo prova
-- btree em coluna de data para buscas por intervalo
create index idx_consulta_data_btree on consulta using btree (data);

-- essa busca usa o indice btree
select * from consulta where data between '2018-10-12' and '2018-10-15';

-- limpeza
drop index if exists idx_med_cidade_btree;
drop index if exists idx_func_salario_btree;
drop index if exists idx_consulta_data_btree;
