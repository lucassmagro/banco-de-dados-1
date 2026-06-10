-- cursor em plpgsql
-- quando usar: navegar linha a linha pelo resultado de uma consulta
-- obs prova: cursor nao carrega tudo na memoria de uma vez
--            open / fetch / close
--            found e true se o fetch retornou uma linha

-- exemplo simples
-- percorre medicos com cursor explicito
create or replace function listar_cursor()
returns text as $$
declare
    cur cursor for select codm, nome from medico order by codm;
    reg record;
    resultado text := '';
begin
    open cur;
    loop
        fetch cur into reg;
        exit when not found;
        resultado := resultado || reg.nome || ' ';
    end loop;
    close cur;
    return resultado;
end;
$$ language plpgsql;

select listar_cursor();

-- exemplo intermediario (cursor parametrizado)
-- cursor que recebe a cidade como argumento
create or replace function medicos_cursor(cid varchar)
returns text as $$
declare
    cur cursor(c varchar) for
        select codm, nome, especialidade from medico where cidade = c;
    reg record;
    resultado text := '';
begin
    open cur(cid);
    loop
        fetch cur into reg;
        exit when not found;
        resultado := resultado || reg.nome || '(' || trim(reg.especialidade) || ') ';
    end loop;
    close cur;
    return resultado;
end;
$$ language plpgsql;

select medicos_cursor('Florianopolis');
select medicos_cursor('Blumenau');

-- exemplo estilo prova
-- cursor que conta e totaliza salarios de um departamento
create or replace function resumo_depto_cursor(cod_depto int)
returns text as $$
declare
    cur cursor for
        select nome, salario from funcionario where codd = cod_depto;
    reg record;
    total numeric := 0;
    qtd int := 0;
begin
    open cur;
    loop
        fetch cur into reg;
        exit when not found;
        total := total + reg.salario;
        qtd := qtd + 1;
    end loop;
    close cur;
    return qtd || ' funcionarios, total: ' || total || ', media: ' || round(total / qtd, 2);
end;
$$ language plpgsql;

select resumo_depto_cursor(1);
select resumo_depto_cursor(3);
