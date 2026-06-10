-- natural join
-- quando usar: juncao automatica pelos atributos de MESMO NOME
-- obs prova: o atributo comum aparece uma unica vez no resultado
--            perigo: se houver mais colunas com mesmo nome, junta por todas

-- exemplo simples
-- paciente e consulta tem codp em comum
select *
from paciente natural join consulta;

-- exemplo intermediario
-- nome dos medicos com consulta em 13/10/2018 (junta por codm)
select nome
from medico natural join consulta
where data = '2018-10-13';

-- exemplo estilo prova
-- numero e andar dos ambulatorios cujos medicos tem consulta em 12/10/2018
-- medico/ambulatorio juntam por nroa; medico/consulta por codm
select distinct nroa, andar
from ambulatorio natural join medico natural join consulta
where data = '2018-10-12';

-- nome, cpf e especialidade dos medicos com consulta de paciente com tendinite
select distinct m.nome, m.cpf, m.especialidade
from medico m natural join consulta natural join paciente
where doenca = 'tendinite';
