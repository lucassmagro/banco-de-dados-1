-- tipos de indice
-- quando usar: escolher a estrutura de indice mais adequada
-- obs prova: b-tree e o padrao, hash so para igualdade
--            gin e gist sao para tipos complexos (texto, json, geometria)

-- b-tree (padrao): bom para =, <, >, <=, >=, between, order by
create index idx_btree_idade on medico using btree (idade);

-- hash: so para igualdade exata (=)
create index idx_hash_cidade on medico using hash (cidade);

-- exemplo simples
-- b-tree em coluna de filtro frequente
create index idx_pac_doenca on paciente (doenca);

-- exemplo intermediario
-- indice composto com ordem especifica
create index idx_func_depto_salario on funcionario (codd, salario desc);

-- exemplo estilo prova
-- consultar indices existentes de uma tabela
select indexname, indexdef
from pg_indexes
where tablename = 'medico';

-- limpeza
drop index if exists idx_btree_idade;
drop index if exists idx_hash_cidade;
drop index if exists idx_pac_doenca;
drop index if exists idx_func_depto_salario;
