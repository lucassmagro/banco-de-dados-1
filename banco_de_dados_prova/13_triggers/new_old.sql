-- new e old em triggers
-- quando usar: acessar os valores antes e depois da operacao
-- obs prova: new = linha nova (insert e update)
--            old = linha antiga (update e delete)
--            insert: so new (nao existe old)
--            delete: so old (nao existe new)
--            update: tem new e old

-- exemplo simples
-- mostra old e new no update
create or replace function mostrar_old_new()
returns trigger as $$
begin
    raise notice 'old: % (idade %)', old.nome, old.idade;
    raise notice 'new: % (idade %)', new.nome, new.idade;
    return new;
end;
$$ language plpgsql;

create trigger trg_old_new_medico
before update on medico
for each row execute function mostrar_old_new();

-- testando (ver mensagens no console)
update medico set idade = idade + 1 where codm = 1;
update medico set idade = idade - 1 where codm = 1;
drop trigger trg_old_new_medico on medico;

-- exemplo intermediario
-- compara old e new para registrar so o que mudou
create or replace function detectar_mudancas()
returns trigger as $$
begin
    if old.nome <> new.nome then
        raise notice 'nome mudou: % -> %', old.nome, new.nome;
    end if;
    if old.salario <> new.salario then
        raise notice 'salario mudou: % -> %', old.salario, new.salario;
    end if;
    if old.codd is distinct from new.codd then
        raise notice 'departamento mudou: % -> %', old.codd, new.codd;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_detectar_func
before update on funcionario
for each row execute function detectar_mudancas();

update funcionario set salario = salario + 50 where codf = 1;
update funcionario set salario = salario - 50 where codf = 1;
drop trigger trg_detectar_func on funcionario;

-- exemplo estilo prova
-- trigger generico que usa new no insert e old no delete
create or replace function log_generico()
returns trigger as $$
begin
    if tg_op = 'INSERT' then
        raise notice '[insert] novo registro: %', new;
        return new;
    elsif tg_op = 'UPDATE' then
        raise notice '[update] de: % para: %', old, new;
        return new;
    elsif tg_op = 'DELETE' then
        raise notice '[delete] removido: %', old;
        return old;
    end if;
end;
$$ language plpgsql;

create trigger trg_generico_amb
before insert or update or delete on ambulatorio
for each row execute function log_generico();

drop trigger trg_generico_amb on ambulatorio;
