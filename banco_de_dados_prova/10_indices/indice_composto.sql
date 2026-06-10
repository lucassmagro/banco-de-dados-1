-- indice composto
-- quando usar: buscas que filtram por duas ou mais colunas juntas
-- obs prova: a ordem das colunas importa
--            indice em (a, b) serve para buscas por a, ou por a e b
--            mas nao serve para buscas so por b

-- exemplo simples
-- indice composto em cidade e especialidade do medico
create index idx_med_cidade_espec on medico (cidade, especialidade);

-- usa o indice (filtra pela primeira coluna)
select * from medico where cidade = 'Florianopolis';

-- usa o indice (filtra pelas duas)
select * from medico where cidade = 'Florianopolis' and especialidade = 'ortopedia';

-- exemplo intermediario
-- indice composto na consulta (data e hora)
create index idx_consulta_data_hora on consulta (data, hora);

-- aproveita o indice
select * from consulta where data = '2018-10-13' and hora > '10:00';

-- so pela data tambem usa (e a primeira coluna)
select * from consulta where data = '2018-10-13';

-- so pela hora nao usa (nao e a primeira coluna)
-- select * from consulta where hora > '10:00';

-- exemplo estilo prova
-- indice composto com ordem mista para otimizar um relatorio
create index idx_func_depto_sal on funcionario (codd, salario desc);

-- consulta otimizada: funcionarios por departamento ordenados por salario
select codf, nome, salario
from funcionario
where codd = 1
order by salario desc;

-- limpeza
drop index if exists idx_med_cidade_espec;
drop index if exists idx_consulta_data_hora;
drop index if exists idx_func_depto_sal;
