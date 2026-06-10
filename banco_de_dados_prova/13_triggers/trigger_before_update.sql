-- trigger before update
-- quando usar: interceptar e modificar dados antes de atualizar
-- obs prova: tem acesso a old (valores antigos) e new (valores novos)
--            pode alterar new para corrigir ou limitar valores
--            retornar null cancela o update

-- exemplo simples
-- impede que o nome do medico fique vazio
create or replace function impedir_nome_vazio_medico()
returns trigger as $$
begin
    if new.nome is null or trim(new.nome) = '' then
        raise exception 'nome do medico nao pode ficar vazio';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_nome_medico
before update on medico
for each row execute function impedir_nome_vazio_medico();

drop trigger trg_nome_medico on medico;

-- exemplo intermediario
-- limita aumento de salario a no maximo 50%
create or replace function limitar_aumento()
returns trigger as $$
begin
    if new.salario > old.salario * 1.5 then
        new.salario := old.salario * 1.5;
        raise notice 'aumento limitado a 50%% para %', new.nome;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_limitar_aumento
before update on funcionario
for each row execute function limitar_aumento();

-- testando
update funcionario set salario = 9999 where codf = 1;
select nome, salario from funcionario where codf = 1;
drop trigger trg_limitar_aumento on funcionario;

-- exemplo estilo prova
-- impede mudanca de especialidade do medico se ele tem consultas marcadas
create or replace function bloquear_mudanca_espec()
returns trigger as $$
begin
    if old.especialidade <> new.especialidade then
        if exists (select 1 from consulta where codm = old.codm) then
            raise exception 'medico % tem consultas, nao pode mudar especialidade', old.nome;
        end if;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_bloquear_espec
before update on medico
for each row execute function bloquear_mudanca_espec();

drop trigger trg_bloquear_espec on medico;

-- recarregue a base depois de testar
