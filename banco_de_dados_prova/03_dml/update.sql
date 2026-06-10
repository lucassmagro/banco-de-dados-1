-- update
-- quando usar: alterar valores de linhas existentes
-- obs prova: SEM where atualiza a tabela INTEIRA (cuidado!)
--            pode atualizar varias colunas separadas por virgula
--            pode usar a propria coluna no calculo

-- exemplo simples
-- o paciente Paulo mudou para Ilhota
update paciente set cidade = 'Ilhota' where nome = 'Paulo';

-- exemplo intermediario (mais de uma coluna e calculo)
-- ambulatorio 2 ganhou 5 vagas e foi para o andar 3
update ambulatorio
set capacidade = capacidade + 5,
    andar = 3
where nroa = 2;

-- exemplo estilo prova
-- a paciente Ana fez aniversario e sua doenca agora e cancer
update paciente
set idade = idade + 1,
    doenca = 'cancer'
where nome = 'Ana';

-- consulta do medico 3 com o paciente 4 passou para uma hora e meia depois
update consulta
set hora = hora + interval '1 hour 30 minutes'
where codm = 3 and codp = 4;

-- aumento de 10% para salarios abaixo da media
update funcionario
set salario = salario * 1.1
where salario < (select avg(salario) from funcionario);

-- desfaz os testes (recarregue a base se quiser os valores originais)
