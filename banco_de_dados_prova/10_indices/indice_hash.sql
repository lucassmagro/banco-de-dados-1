-- indice hash
-- quando usar: buscas exclusivamente por igualdade (=)
-- obs prova: hash so serve para =, nao suporta <, >, between, order by
--            menor que btree mas limitado
--            antes do postgres 10, hash nao era seguro com crash

-- exemplo simples
-- indice hash na coluna cidade do paciente
create index idx_pac_cidade_hash on paciente using hash (cidade);

-- essa busca aproveita o hash
select * from paciente where cidade = 'Florianopolis';

-- exemplo intermediario
-- hash em coluna de especialidade (buscas sempre por igualdade)
create index idx_med_espec_hash on medico using hash (especialidade);

-- explain mostra que usa o indice hash
explain select * from medico where especialidade = 'ortopedia';

-- exemplo estilo prova
-- comparando btree vs hash
-- btree: bom para =, <, >, <=, >=, between, order by, like 'abc%'
-- hash: so para =, mas pode ser mais rapido nesse caso

create index idx_func_cargo_hash on funcionario using hash (cargo);

select * from funcionario where cargo = 'tecnico'; -- usa hash

-- essa consulta NAO usa hash (nao suporta like)
-- select * from funcionario where cargo like 'tec%';

-- limpeza
drop index if exists idx_pac_cidade_hash;
drop index if exists idx_med_espec_hash;
drop index if exists idx_func_cargo_hash;
