-- trigger statement e clausula when
-- quando usar: executar a acao apenas 1 vez por comando e com condicao previa
-- obs prova: for each statement executa o trigger 1 vez, mesmo se o update afetar mil linhas
--            quando usar 'when (condicao)', a funcao do trigger so roda se condicao for true
--            economiza processamento

-- exemplo simples (statement trigger)
-- log de operacoes em lote
create table if not exists log_lote (id serial, op varchar(10), data timestamp default now());

create or replace function log_operacao_lote()
returns trigger as $$
begin
    insert into log_lote (op) values (tg_op);
    return null; -- statement triggers podem retornar null
end;
$$ language plpgsql;

create trigger trg_log_lote_medico
after update on medico
for each statement execute function log_operacao_lote();

-- testa o statement trigger (um update em 5 registros gera so 1 log)
update medico set idade = idade + 1;
update medico set idade = idade - 1;

-- exemplo intermediario (when)
-- so dispara se o salario inserido for absurdamente alto
create or replace function alerta_salario()
returns trigger as $$
begin
    raise notice 'alerta: salario alto cadastrado: %', new.salario;
    return new;
end;
$$ language plpgsql;

create trigger trg_salario_alto
before insert on funcionario
for each row
when (new.salario > 10000)
execute function alerta_salario();

-- testando o when (so o segundo deve disparar o notice)
-- insert into funcionario values (101, 'Normal', 30, 10101, 'Florianopolis', 1500, 'tec', 1);
-- insert into funcionario values (102, 'Diretor', 40, 10102, 'Florianopolis', 15000, 'dir', 1);

-- exemplo estilo prova
-- combinando for each statement com tg_op
create or replace function protecao_horario_comercial()
returns trigger as $$
begin
    if extract(hour from current_time) not between 8 and 18 then
        raise exception 'operacoes so permitidas em horario comercial!';
    end if;
    return null;
end;
$$ language plpgsql;

create trigger trg_horario_seguro
before delete on consulta
for each statement execute function protecao_horario_comercial();

-- limpeza
drop trigger if exists trg_log_lote_medico on medico;
drop trigger if exists trg_salario_alto on funcionario;
drop trigger if exists trg_horario_seguro on consulta;
drop table if exists log_lote;
