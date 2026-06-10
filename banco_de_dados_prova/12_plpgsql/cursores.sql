-- cursores
-- quando usar: percorrer o resultado de uma consulta linha a linha
-- obs prova: cursor permite navegar no resultado sem carregar tudo na memoria
--            open / fetch / close
--            refcursor pode ser retornado para o chamador

-- exemplo simples
create or replace function cursor_medicos()
returns void as $$
declare
    cur cursor for select codm, nome from medico;
    reg record;
begin
    open cur;
    loop
        fetch cur into reg;
        exit when not found;
        raise notice 'medico: % - %', reg.codm, reg.nome;
    end loop;
    close cur;
end;
$$ language plpgsql;

select cursor_medicos();

-- exemplo intermediario (cursor com parametro)
create or replace function cursor_medicos_cidade(cid varchar)
returns void as $$
declare
    cur cursor(c varchar) for
        select codm, nome from medico where cidade = c;
    reg record;
begin
    open cur(cid);
    loop
        fetch cur into reg;
        exit when not found;
        raise notice '% - %', reg.codm, reg.nome;
    end loop;
    close cur;
end;
$$ language plpgsql;

select cursor_medicos_cidade('Florianopolis');

-- exemplo estilo prova
-- funcao que retorna refcursor (cursor aberto para o chamador)
create or replace function abrir_cursor_consultas()
returns refcursor as $$
declare
    cur refcursor;
begin
    open cur for
        select m.nome as medico, p.nome as paciente, c.data
        from consulta c
        join medico m on m.codm = c.codm
        join paciente p on p.codp = c.codp;
    return cur;
end;
$$ language plpgsql;

-- para usar: begin; select abrir_cursor_consultas(); fetch all from "<cursor>"; commit;
