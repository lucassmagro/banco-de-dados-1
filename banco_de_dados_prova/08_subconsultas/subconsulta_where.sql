-- subconsulta no where
-- quando usar: filtrar linhas com base no resultado de outra consulta
-- obs prova: a subconsulta roda primeiro, o resultado alimenta a consulta externa

-- exemplo simples
-- medicos com idade acima da media
select nome, idade
from medico
where idade > (select avg(idade) from medico);

-- exemplo intermediario
-- funcionarios que ganham mais que a media salarial do seu departamento
select f.nome, f.salario
from funcionario f
where f.salario > (select avg(f2.salario)
                   from funcionario f2
                   where f2.codd = f.codd);

-- exemplo estilo prova
-- nome dos pacientes que tem consulta com medicos ortopedistas
select nome
from paciente
where codp in (select c.codp
               from consulta c
               join medico m on m.codm = c.codm
               where m.especialidade = 'ortopedia');
