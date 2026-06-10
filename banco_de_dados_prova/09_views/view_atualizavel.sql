-- view atualizavel
-- quando usar: permitir insert, update ou delete pela view
-- obs prova: view e atualizavel se baseada em uma unica tabela,
--            sem distinct, group by, having, union, funcoes de agregacao
--            with check option impede insercao que nao apareceria na view

-- exemplo simples
-- view atualizavel dos medicos ortopedistas
create or replace view ortopedistas as
select codm, nome, idade, cidade
from medico
where especialidade = 'ortopedia';

-- inserir pela view (a especialidade precisa estar na tabela real)
-- update pela view
update ortopedistas set cidade = 'Joinville' where codm = 1;
select * from ortopedistas;
update ortopedistas set cidade = 'Florianopolis' where codm = 1;

-- exemplo intermediario (with check option)
-- impede que insercao/update faca a linha sumir da view
create or replace view funcionarios_floripa as
select codf, nome, salario, cidade
from funcionario
where cidade = 'Florianopolis'
with check option;

-- isso funciona
update funcionarios_floripa set salario = salario + 100 where codf = 3;

-- isso daria erro (muda a cidade, linha sairia da view)
-- update funcionarios_floripa set cidade = 'Palhoca' where codf = 3;

-- exemplo estilo prova
-- view atualizavel com local check option
create or replace view ambulatorios_andar2 as
select nroa, andar, capacidade
from ambulatorio
where andar = 2
with local check option;

-- update valido (mantem andar = 2)
update ambulatorios_andar2 set capacidade = capacidade + 1 where nroa = 3;

-- desfaz
update ambulatorios_andar2 set capacidade = capacidade - 1 where nroa = 3;

-- limpeza
drop view if exists ortopedistas;
drop view if exists funcionarios_floripa;
drop view if exists ambulatorios_andar2;
