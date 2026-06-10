-- full join (juncao externa completa)
-- quando usar: preservar as linhas dos DOIS lados
-- obs prova: full [outer] join: quem nao casa aparece com null no outro lado
--            caiu no enade: full join traz todos de ambas as tabelas

-- exemplo simples
select *
from medico m full join consulta c on m.codm = c.codm;

-- exemplo intermediario
-- todos os medicos e todos os ambulatorios, casando quando der
select m.nome, a.nroa, a.andar
from medico m full outer join ambulatorio a on m.nroa = a.nroa;

-- exemplo estilo prova (enade)
-- linhas exclusivas de cada lado (sem o miolo da interseccao)
select m.nome, c.data
from medico m full outer join consulta c on m.codm = c.codm
where m.codm is null or c.codm is null;
