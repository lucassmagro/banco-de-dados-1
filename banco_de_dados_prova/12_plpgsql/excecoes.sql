-- excecoes
-- quando usar: tratar erros dentro de funcoes
-- obs prova: bloco exception fica dentro do begin/end
--            sqlstate identifica o tipo de erro
--            raise exception lanca erro personalizado

-- exemplo simples
-- funcao segura que nao quebra se o medico nao existir
create or replace function buscar_medico(cod int)
returns varchar as $$
declare
    resultado varchar;
begin
    select nome into strict resultado from medico where codm = cod;
    return resultado;
exception
    when no_data_found then
        return 'medico nao encontrado';
end;
$$ language plpgsql;

select buscar_medico(1);   -- Joao
select buscar_medico(999); -- medico nao encontrado

-- exemplo intermediario
-- funcao que valida e insere ambulatorio
create or replace function inserir_ambulatorio(nro int, and_ar int, cap int)
returns varchar as $$
begin
    if cap < 1 then
        raise exception 'capacidade deve ser >= 1';
    end if;

    insert into ambulatorio values (nro, and_ar, cap);
    return 'inserido com sucesso';
exception
    when unique_violation then
        return 'ambulatorio ja existe';
    when check_violation then
        return 'valor fora do permitido';
end;
$$ language plpgsql;

select inserir_ambulatorio(99, 1, 30);  -- inserido
select inserir_ambulatorio(99, 1, 30);  -- ja existe
select inserir_ambulatorio(100, 1, 0);  -- capacidade invalida
delete from ambulatorio where nroa in (99, 100);

-- exemplo estilo prova
-- funcao que transfere orcamento entre departamentos com validacao
create or replace function transferir_orcamento(de int, para int, valor numeric)
returns varchar as $$
declare
    saldo_atual numeric;
begin
    select orcamento into saldo_atual from departamento where codd = de;

    if saldo_atual is null then
        raise exception 'departamento origem nao encontrado';
    end if;

    if saldo_atual < valor then
        raise exception 'saldo insuficiente: % disponivel', saldo_atual;
    end if;

    update departamento set orcamento = orcamento - valor where codd = de;
    update departamento set orcamento = orcamento + valor where codd = para;
    return 'transferencia concluida';
exception
    when others then
        return 'erro: ' || sqlerrm;
end;
$$ language plpgsql;

select transferir_orcamento(3, 2, 5000);
select transferir_orcamento(3, 2, 999999); -- saldo insuficiente
