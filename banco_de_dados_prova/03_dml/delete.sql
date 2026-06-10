-- delete
-- quando usar: remover linhas da tabela
-- obs prova: SEM where apaga a tabela INTEIRA (cuidado!)
--            nao confundir com drop (apaga a estrutura)
--            fk pode bloquear o delete (apagar filhos antes)

-- exemplo simples
-- consultas marcadas para as 19:00 foram canceladas
delete from consulta where hora = '19:00';

-- exemplo intermediario (mais de uma condicao)
-- pacientes com cancer ou idade inferior a 10 anos deixaram a clinica
delete from consulta
where codp in (select codp from paciente where doenca = 'cancer' or idade < 10);
delete from paciente
where doenca = 'cancer' or idade < 10;

-- exemplo estilo prova
-- medicos que residem em Biguacu e Palhoca deixaram a clinica
delete from consulta
where codm in (select codm from medico where cidade in ('Biguacu', 'Palhoca'));
delete from medico
where cidade in ('Biguacu', 'Palhoca');

-- recarregue a base depois de testar este arquivo
