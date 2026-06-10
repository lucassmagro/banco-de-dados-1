-- loop basico em plpgsql
-- quando usar: repetir um bloco ate que exit seja chamado
-- obs prova: loop infinito por padrao, precisa de exit para sair
--            exit when condicao encerra o loop
--            continue pula para a proxima iteracao

-- exemplo simples
-- conta de 1 a 5 e retorna o resultado
create or replace function contar_loop()
returns text as $$
declare
    i int := 0;
    resultado text := '';
begin
    loop
        i := i + 1;
        exit when i > 5;
        resultado := resultado || i || ' ';
    end loop;
    return resultado;
end;
$$ language plpgsql;

select contar_loop();

-- exemplo intermediario
-- loop com continue (pula numeros pares)
create or replace function impares_ate(n int)
returns text as $$
declare
    i int := 0;
    resultado text := '';
begin
    loop
        i := i + 1;
        exit when i > n;
        continue when i % 2 = 0;
        resultado := resultado || i || ' ';
    end loop;
    return resultado;
end;
$$ language plpgsql;

select impares_ate(10);

-- exemplo estilo prova
-- loop que calcula soma acumulada ate ultrapassar um valor
create or replace function soma_ate_limite(limite int)
returns text as $$
declare
    i int := 0;
    soma int := 0;
begin
    loop
        i := i + 1;
        soma := soma + i;
        exit when soma >= limite;
    end loop;
    return 'somou ate ' || i || ', total = ' || soma;
end;
$$ language plpgsql;

select soma_ate_limite(50);
