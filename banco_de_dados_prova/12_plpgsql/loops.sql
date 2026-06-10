-- loops em plpgsql
-- quando usar: repetir logica para cada linha ou n vezes
-- obs prova: loop basico, while, for numerico, for in query
--            exit encerra o loop, continue pula iteracao

-- exemplo simples (for numerico)
-- insere 5 ambulatorios de teste
create or replace function inserir_ambulatorios_teste()
returns void as $$
declare
    i int;
begin
    for i in 20..24 loop
        insert into ambulatorio values (i, i % 5 + 1, 10 + i);
    end loop;
end;
$$ language plpgsql;

select inserir_ambulatorios_teste();
select * from ambulatorio where nroa >= 20;
delete from ambulatorio where nroa >= 20;

-- exemplo intermediario (for in query)
-- percorre medicos e imprime via raise notice
create or replace function listar_medicos()
returns void as $$
declare
    reg record;
begin
    for reg in select codm, nome, especialidade from medico loop
        raise notice 'medico %: % (%)', reg.codm, reg.nome, reg.especialidade;
    end loop;
end;
$$ language plpgsql;

select listar_medicos();

-- exemplo estilo prova (while com condicao de saida)
-- calcula fatorial
create or replace function fatorial(n int)
returns bigint as $$
declare
    resultado bigint := 1;
    i int := 1;
begin
    while i <= n loop
        resultado := resultado * i;
        i := i + 1;
    end loop;
    return resultado;
end;
$$ language plpgsql;

select fatorial(5);  -- 120
select fatorial(10); -- 3628800
