-- while em plpgsql
-- quando usar: repetir enquanto uma condicao for verdadeira
-- obs prova: while condicao loop ... end loop
--            a condicao e testada ANTES de cada iteracao
--            se for falsa logo no inicio, o corpo nunca executa

-- exemplo simples
-- conta de 1 a 5 com while
create or replace function contar_while()
returns text as $$
declare
    i int := 1;
    resultado text := '';
begin
    while i <= 5 loop
        resultado := resultado || i || ' ';
        i := i + 1;
    end loop;
    return resultado;
end;
$$ language plpgsql;

select contar_while();

-- exemplo intermediario
-- fatorial com while
create or replace function fatorial_while(n int)
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

select fatorial_while(6); -- 720

-- exemplo estilo prova
-- fibonacci: retorna o n-esimo termo
create or replace function fibonacci(n int)
returns bigint as $$
declare
    a bigint := 0;
    b bigint := 1;
    temp bigint;
    i int := 2;
begin
    if n = 0 then return 0; end if;
    if n = 1 then return 1; end if;
    while i <= n loop
        temp := a + b;
        a := b;
        b := temp;
        i := i + 1;
    end loop;
    return b;
end;
$$ language plpgsql;

select fibonacci(10); -- 55
