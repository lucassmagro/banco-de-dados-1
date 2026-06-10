-- where
-- quando usar: filtrar linhas
-- obs prova: comparadores: =, <>, !=, >, <, >=, <=
--            logicos: and, or, not
--            and tem precedencia sobre or, usar parenteses

-- exemplo simples
select * from paciente where idade > 18;

-- exemplo intermediario (and / or)
select *
from funcionario
where cidade = 'Florianopolis' and salario > 1500;

select *
from medico
where idade < 40 or especialidade = 'traumatologia';

-- diferente
select * from medico where cidade <> 'Florianopolis';

-- exemplo estilo prova (parenteses mudam o resultado)
-- funcionarios de Florianopolis ou Palhoca com salario acima de 1000
select nome, salario
from funcionario
where (cidade = 'Florianopolis' or cidade = 'Palhoca')
  and salario > 1000;

-- comparando com data e hora
select * from consulta where data = '2018-10-13' and hora > '10:00';
