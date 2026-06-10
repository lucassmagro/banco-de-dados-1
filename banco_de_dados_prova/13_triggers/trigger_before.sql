-- trigger before
-- quando usar: executar ANTES da operacao (insert, update, delete)
-- obs prova: before pode modificar ou cancelar a operacao
--            retornar null cancela a operacao
--            retornar new confirma (com possiveis alteracoes)

-- exemplo simples
-- converte nome do paciente para maiusculo antes de inserir
create or replace function nome_maiusculo_pac()
returns trigger as $$
begin
    new.nome := upper(new.nome);
    return new;
end;
$$ language plpgsql;

create trigger trg_nome_pac_upper
before insert on paciente
for each row execute function nome_maiusculo_pac();

-- testando
insert into paciente values (11, 'teste', 25, 'Florianopolis', 99000000001, 'gripe');
select * from paciente where codp = 11; -- nome fica TESTE
delete from consulta where codp = 11;
delete from paciente where codp = 11;
drop trigger trg_nome_pac_upper on paciente;

-- exemplo intermediario
-- impede delete de medico que tem consulta marcada
create or replace function bloquear_delete_medico()
returns trigger as $$
begin
    if exists (select 1 from consulta where codm = old.codm) then
        raise exception 'medico % tem consultas marcadas', old.nome;
    end if;
    return old;
end;
$$ language plpgsql;

create trigger trg_bloquear_del_medico
before delete on medico
for each row execute function bloquear_delete_medico();

-- testando (deve dar erro para medico com consulta)
-- delete from medico where codm = 1;
drop trigger trg_bloquear_del_medico on medico;

-- exemplo estilo prova
-- before update que ajusta salario maximo a 5000
create or replace function limitar_salario()
returns trigger as $$
begin
    if new.salario > 5000 then
        new.salario := 5000;
        raise notice 'salario limitado a 5000 para %', new.nome;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_limitar_salario
before update on funcionario
for each row execute function limitar_salario();

-- testando
update funcionario set salario = 9999 where codf = 5;
select nome, salario from funcionario where codf = 5; -- salario = 5000
drop trigger trg_limitar_salario on funcionario;

-- recarregue a base depois de testar
