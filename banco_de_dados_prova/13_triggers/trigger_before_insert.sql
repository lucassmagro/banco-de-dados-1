-- trigger before insert
-- quando usar: interceptar e modificar dados antes de inserir
-- obs prova: pode alterar new para mudar valores
--            retornar null cancela a insercao
--            retornar new confirma a insercao (com ou sem mudancas)

-- exemplo simples
-- converte nome para maiusculo antes de inserir paciente
create or replace function upper_nome_paciente()
returns trigger as $$
begin
    new.nome := upper(new.nome);
    return new;
end;
$$ language plpgsql;

create trigger trg_upper_pac
before insert on paciente
for each row execute function upper_nome_paciente();

-- testando
insert into paciente values (11, 'teste upper', 25, 'Florianopolis', 99000000011, 'gripe');
select * from paciente where codp = 11;
delete from paciente where codp = 11;
drop trigger trg_upper_pac on paciente;

-- exemplo intermediario
-- preenche data automaticamente se nao informada na consulta
create or replace function preencher_data_consulta()
returns trigger as $$
begin
    if new.data is null then
        new.data := current_date;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_data_consulta
before insert on consulta
for each row execute function preencher_data_consulta();

drop trigger trg_data_consulta on consulta;

-- exemplo estilo prova
-- impede insercao de funcionario com salario acima de 5000
create or replace function limitar_salario_insert()
returns trigger as $$
begin
    if new.salario > 5000 then
        raise exception 'salario maximo permitido e 5000. informado: %', new.salario;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_limitar_sal_insert
before insert on funcionario
for each row execute function limitar_salario_insert();

-- testando (deve dar erro)
-- insert into funcionario values (11, 'Teste', 30, 99000099000, 'Florianopolis', 6000, 'gerente', 1);
drop trigger trg_limitar_sal_insert on funcionario;
