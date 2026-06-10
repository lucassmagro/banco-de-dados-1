-- for em plpgsql
-- quando usar: iterar sobre um intervalo numerico ou sobre resultado de query
-- obs prova: for i in 1..10 (numerico, limites inclusos)
--            for reg in select ... (percorre resultado de consulta)
--            reverse inverte a direcao
--            by define o passo

-- exemplo simples (for numerico)
-- soma de 1 a n
create or replace function soma_for(n int)
returns int as $$
declare
    total int := 0;
begin
    for i in 1..n loop
        total := total + i;
    end loop;
    return total;
end;
$$ language plpgsql;

select soma_for(100); -- 5050

-- exemplo intermediario (for in query)
-- percorre medicos e monta uma lista com nomes
create or replace function lista_medicos()
returns text as $$
declare
    reg record;
    resultado text := '';
begin
    for reg in select codm, nome from medico order by codm loop
        resultado := resultado || reg.codm || ':' || reg.nome || ', ';
    end loop;
    return resultado;
end;
$$ language plpgsql;

select lista_medicos();

-- exemplo estilo prova
-- for reverso e com passo
create or replace function contagem_regressiva(inicio int, passo int)
returns text as $$
declare
    resultado text := '';
begin
    for i in reverse inicio..1 by passo loop
        resultado := resultado || i || ' ';
    end loop;
    return resultado;
end;
$$ language plpgsql;

select contagem_regressiva(10, 2); -- 10 8 6 4 2

-- for in query com filtro
create or replace function pacientes_por_cidade(cid varchar)
returns text as $$
declare
    reg record;
    resultado text := '';
begin
    for reg in select nome, doenca from paciente where cidade = cid loop
        resultado := resultado || reg.nome || '(' || reg.doenca || ') ';
    end loop;
    return resultado;
end;
$$ language plpgsql;

select pacientes_por_cidade('Florianopolis');
