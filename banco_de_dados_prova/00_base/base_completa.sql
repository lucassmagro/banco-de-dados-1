-- base completa da disciplina (esquema da clinica dos slides)
-- rodar este arquivo inteiro antes de testar os demais
-- tabelas: ambulatorio, departamento, medico, paciente, funcionario, consulta

drop table if exists consulta cascade;
drop table if exists medico cascade;
drop table if exists paciente cascade;
drop table if exists funcionario cascade;
drop table if exists departamento cascade;
drop table if exists ambulatorio cascade;

-- ambulatorios da clinica
create table ambulatorio (
    nroa int primary key,
    andar numeric(3) not null,
    capacidade smallint check (capacidade >= 1)
);

-- departamentos administrativos
create table departamento (
    codd int primary key,
    nome varchar(20) not null unique
        check (nome in ('vendas', 'pessoal', 'financas', 'administrativo')),
    andar int check (andar between 1 and 10),
    orcamento numeric(20,2)
);

-- medicos, podem ou nao atender em um ambulatorio
create table medico (
    codm int primary key,
    nome varchar(40) not null,
    idade smallint not null check (idade >= 16),
    especialidade char(20),
    cpf numeric(11) unique,
    cidade varchar(30),
    nroa int,
    foreign key (nroa) references ambulatorio (nroa)
);

-- pacientes internados
create table paciente (
    codp int primary key,
    nome varchar(40) not null,
    idade smallint not null check (idade >= 0),
    cidade char(30),
    cpf numeric(11) unique,
    doenca varchar(40) not null
);

-- funcionarios da clinica
create table funcionario (
    codf int primary key,
    nome varchar(40) not null,
    idade smallint check (idade >= 0),
    cpf numeric(11) unique,
    cidade varchar(30),
    salario numeric(10,2) check (salario >= 0),
    cargo varchar(20),
    codd int,
    constraint fk_func_depto foreign key (codd) references departamento (codd)
        on update cascade
        on delete set null
);

-- consultas marcadas (chave composta)
create table consulta (
    codm int,
    codp int,
    data date,
    hora time,
    primary key (codm, codp, data, hora),
    foreign key (codm) references medico (codm),
    foreign key (codp) references paciente (codp)
);

-- dados ambulatorios
insert into ambulatorio values (1, 1, 30);
insert into ambulatorio values (2, 1, 50);
insert into ambulatorio values (3, 2, 40);
insert into ambulatorio values (4, 2, 25);
insert into ambulatorio values (5, 2, 55);
insert into ambulatorio values (6, 3, 20);
insert into ambulatorio values (7, 5, 60);
insert into ambulatorio values (8, 5, 45);

-- dados departamentos
insert into departamento values (1, 'vendas', 1, 50000);
insert into departamento values (2, 'pessoal', 2, 30000);
insert into departamento values (3, 'financas', 3, 80000);
insert into departamento values (4, 'administrativo', 1, 40000);

-- dados medicos (mesmos dos slides + extras)
insert into medico values (1, 'Joao', 40, 'ortopedia', 10000100000, 'Florianopolis', 1);
insert into medico values (2, 'Maria', 42, 'traumatologia', 10000110000, 'Blumenau', 2);
insert into medico values (3, 'Pedro', 51, 'pediatria', 11000100000, 'Sao Jose', 2);
insert into medico values (4, 'Carlos', 28, 'ortopedia', 11000110000, 'Joinville', null);
insert into medico values (5, 'Marcia', 33, 'neurologia', 11000111000, 'Biguacu', 3);
insert into medico values (6, 'Joana', 37, 'traumatologia', 11111100000, 'Florianopolis', 3);
insert into medico values (7, 'Mauro', 53, 'traumatologia', 11110000110, 'Blumenau', 2);
insert into medico values (8, 'Rafael', 61, 'pediatria', 12000100000, 'Florianopolis', 7);
insert into medico values (9, 'Bianca', 45, 'cardiologia', 12100100000, 'Palhoca', 5);
insert into medico values (10, 'Otavio', 39, 'ortopedia', 12200100000, 'Florianopolis', 7);

-- dados pacientes (cpf do Carlos e da Rita repetem em medico/funcionario de proposito)
insert into paciente values (1, 'Ana', 20, 'Florianopolis', 20000200000, 'gripe');
insert into paciente values (2, 'Paulo', 24, 'Palhoca', 20000220000, 'fratura');
insert into paciente values (3, 'Lucia', 30, 'Biguacu', 22000200000, 'tendinite');
insert into paciente values (4, 'Carlos', 28, 'Joinville', 11000110000, 'sarampo');
insert into paciente values (5, 'Marta', 54, 'Florianopolis', 23000200000, 'cancer');
insert into paciente values (6, 'Joao', 17, 'Sao Jose', 24000200000, 'gastrite');
insert into paciente values (7, 'Rita', 32, 'Sao Jose', 20000100000, 'hepatite');
insert into paciente values (8, 'Caio', 45, 'Florianopolis', 41000100000, 'cancer');
insert into paciente values (9, 'Beatriz', 8, 'Palhoca', 25000200000, 'gripe');
insert into paciente values (10, 'Pedro', 70, 'Blumenau', 26000200000, 'diabetes');

-- dados funcionarios
insert into funcionario values (1, 'Rita', 32, 20000100000, 'Sao Jose', 1200, 'atendente', 1);
insert into funcionario values (2, 'Maria', 55, 30000110000, 'Palhoca', 1220, 'atendente', 2);
insert into funcionario values (3, 'Caio', 45, 41000100000, 'Florianopolis', 1100, 'auxiliar', 1);
insert into funcionario values (4, 'Carlos', 44, 51000110000, 'Florianopolis', 1200, 'tecnico', 3);
insert into funcionario values (5, 'Paula', 33, 61000111000, 'Florianopolis', 2500, 'gerente', 3);
insert into funcionario values (6, 'Bruno', 29, 62000111000, 'Biguacu', 1800, 'tecnico', 2);
insert into funcionario values (7, 'Sofia', 38, 63000111000, 'Florianopolis', 3200, 'gerente', 1);
insert into funcionario values (8, 'Lucas', 23, 64000111000, 'Palhoca', 950, 'estagiario', 4);
insert into funcionario values (9, 'Helena', 50, 65000111000, 'Sao Jose', 2100, 'analista', 4);
insert into funcionario values (10, 'Igor', 41, 66000111000, 'Florianopolis', 1750, 'tecnico', null);

-- dados consultas (mesmos dos slides + extras)
insert into consulta values (1, 1, '2018-10-12', '14:00');
insert into consulta values (1, 4, '2018-10-13', '10:00');
insert into consulta values (2, 1, '2018-10-13', '09:00');
insert into consulta values (2, 2, '2018-10-13', '11:00');
insert into consulta values (2, 3, '2018-10-14', '14:00');
insert into consulta values (2, 4, '2018-10-14', '17:00');
insert into consulta values (3, 1, '2018-10-19', '18:00');
insert into consulta values (3, 3, '2018-10-12', '10:00');
insert into consulta values (3, 4, '2018-10-19', '13:00');
insert into consulta values (4, 4, '2018-10-20', '13:00');
insert into consulta values (4, 4, '2018-10-22', '19:30');
insert into consulta values (5, 4, '2018-10-27', '09:30');
insert into consulta values (5, 5, '2018-10-15', '08:30');
insert into consulta values (5, 2, '2018-10-16', '15:00');
insert into consulta values (1, 5, '2018-10-23', '07:30');
insert into consulta values (6, 6, '2018-10-23', '16:00');
insert into consulta values (2, 5, '2018-10-24', '10:30');
insert into consulta values (8, 9, '2018-10-25', '09:00');
insert into consulta values (9, 10, '2018-10-25', '11:30');
insert into consulta values (1, 3, '2018-10-26', '14:30');
insert into consulta values (4, 7, '2018-10-26', '08:00');

-- conferencia rapida
select 'ambulatorio' as tabela, count(*) from ambulatorio
union select 'departamento', count(*) from departamento
union select 'medico', count(*) from medico
union select 'paciente', count(*) from paciente
union select 'funcionario', count(*) from funcionario
union select 'consulta', count(*) from consulta;
