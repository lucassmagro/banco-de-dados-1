-- funcao basica em plpgsql
-- quando usar: criar logica reutilizavel no banco
-- obs prova: funcao sempre retorna algo (returns tipo)
--            linguagem: plpgsql (procedural)
--            bloco: declare / begin / end

-- exemplo simples
-- funcao que retorna o dobro de um numero
create or replace function dobro(n int)
returns int as $$
begin
    return n * 2;
end;
$$ language plpgsql;

select dobro(5);

-- exemplo intermediario
-- funcao que retorna o nome do medico pelo codigo
create or replace function nome_medico(cod int)
returns varchar as $$
declare
    resultado varchar;
begin
    select nome into resultado from medico where codm = cod;
    return resultado;
end;
$$ language plpgsql;

select nome_medico(1);
select nome_medico(3);

-- exemplo estilo prova
-- funcao que retorna o total de consultas de um medico
create or replace function total_consultas(cod_medico int)
returns int as $$
declare
    total int;
begin
    select count(*) into total
    from consulta
    where codm = cod_medico;
    return total;
end;
$$ language plpgsql;

select m.nome, total_consultas(m.codm) as consultas
from medico m;
