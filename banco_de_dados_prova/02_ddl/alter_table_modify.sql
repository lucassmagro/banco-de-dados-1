-- alter table: alterar tipo, renomear, constraints
-- quando usar: mudar definicoes da tabela sem recriar
-- obs prova: alter column muda tipo, rename column muda nome
--            add/drop constraint mexe nas restricoes

-- exemplo simples (mudar tipo da coluna)
alter table paciente alter column cidade type varchar(40);

-- exemplo intermediario (renomear coluna)
-- renomeie a coluna city para cidade
alter table paciente rename column cidade to city;
alter table paciente rename column city to cidade;
alter table medico rename column nome to nome_medico;
alter table medico rename column nome_medico to nome;

-- renomear a tabela
alter table paciente rename to pacientes;
alter table pacientes rename to paciente;

-- exemplo estilo prova (constraints depois da criacao)
-- adicionar pk / fk / check
alter table funcionario add constraint salario_minimo check (salario >= 900);
alter table funcionario drop constraint salario_minimo;

-- remover e recriar uma fk
alter table funcionario drop constraint fk_func_depto;
alter table funcionario add constraint fk_func_depto
    foreign key (codd) references departamento (codd)
    on update cascade
    on delete set null;

-- default em coluna existente
alter table funcionario alter column salario set default 1000;
alter table funcionario alter column salario drop default;
