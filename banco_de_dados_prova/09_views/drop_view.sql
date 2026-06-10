-- drop view
-- quando usar: remover uma view existente
-- obs prova: drop view nao apaga dados (view nao tem dados)
--            cascade remove views dependentes

-- exemplo simples
create or replace view teste_view as select * from medico;
drop view teste_view;

-- exemplo intermediario (sem erro se nao existir)
drop view if exists teste_view;

-- exemplo estilo prova (cascade)
-- view base
create or replace view medicos_ativos as
select codm, nome from medico where nroa is not null;

-- view que depende da anterior
create or replace view medicos_ativos_floripa as
select * from medicos_ativos where nome like 'J%';

-- sem cascade da erro, com cascade remove as dependentes tambem
drop view medicos_ativos cascade;
