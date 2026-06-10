-- expressoes regulares posix
-- quando usar: busca avancada por padroes textuais mais complexos que like
-- obs prova: usa o operador ~ para case sensitive e ~* para case insensitive
--            !~ e !~* para nao corresponde
--            ^ (inicio), $ (fim), [a-z] (intervalo), | (ou)

-- exemplo simples
-- medicos cujo nome comeca com 'J' ou 'M'
select nome
from medico
where nome ~ '^[JM]';

-- exemplo intermediario
-- pacientes com doenca que contem 'ite' ou 'oma' ignorando maiusculas/minusculas
select nome, doenca
from paciente
where doenca ~* '(ite|oma)';

-- exemplo estilo prova
-- cpfs que comecam com '1' e terminam com '00', usando posix regex em campo text
select nome, cpf
from funcionario
where cast(cpf as text) ~ '^1.*00$';
