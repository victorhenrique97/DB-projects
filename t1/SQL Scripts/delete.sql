
--REMOCAO TEATRO
DELETE FROM APRESENTACAO_TEATRO WHERE TEATRO = 'Nome Teatro';
DELETE FROM TEATRO_FANTOCHE WHERE NOME = 'Nome teatro';
COMMIT;

--REMOCAO ORGANIZADOR
DELETE FROM FESTA_FUNCIONARIO WHERE FUNCIONARIO = 'xxx.xxx.xxx-xx';
DELETE FROM ORGANIZADOR WHERE FUNCIONARIO = 'xxx.xxx.xxx-xx';
DELETE FROM FUNCIONARIO WHERE CPF = 'xxx.xxx.xxx-xx';
DELETE FROM TIPO_PESSOA WHERE CPF = 'xxx.xxx.xxx-xx';
COMMIT;

-- REMOCAO TECNICO
DELETE FROM FESTA_FUNCIONARIO WHERE FUNCIONARIO = 'xxx.xxx.xxx-xx';
DELETE FROM AJUSTE_EQUIPAMENTO WHERE TECNICO = 'xxx.xxx.xxx-xx';
DELETE FROM TECNICO WHERE FUNCIONARIO = 'xxx.xxx.xxx-xx';
DELETE FROM FUNCIONARIO WHERE CPF = 'xxx.xxx.xxx-xx';
DELETE FROM TIPO_PESSOA WHERE CPF = 'xxx.xxx.xxx-xx';
COMMIT;

-- REMOCAO ANIMADOR
DELETE FROM APRESENTACAO_ANIMADOR WHERE ANIMADOR = 'xxx.xxx.xxx-xx';
DELETE FROM ANIMADOR WHERE CPF = 'xxx.xxx.xxx-xx';
DELETE FROM TIPO_ATRACAO WHERE CPF = 'xxx.xxx.xxx-xx';
DELETE FROM TIPO_PESSOA WHERE CPF = 'xxx.xxx.xxx-xx';
COMMIT;


-- REMOCAO MAGICO
DELETE FROM APRESENTACAO_MAGICO WHERE MAGICO = 'xxx.xxx.xxx-xx';
DELETE FROM MAGICO WHERE CPF = 'xxx.xxx.xxx-xx';
DELETE FROM TIPO_ATRACAO WHERE CPF = 'xxx.xxx.xxx-xx';
DELETE FROM TIPO_PESSOA WHERE CPF = 'xxx.xxx.xxx-xx';
COMMIT;


-- REMOCAO FESTA
DELETE FROM APRESENTACAO_TEATRO WHERE FESTA_INFANTIL = X;
DELETE FROM APRESENTACAO_MAGICO WHERE FESTA_INFANTIL = X;
DELETE FROM APRESENTACAO_ANIMADOR WHERE FESTA_INFANTIL = X;
DELETE FROM FESTA_INFANTIL WHERE FESTA = X;
DELETE FROM FESTA_FUNCIONARIO WHERE FESTA = X;
DELETE FROM FESTA WHERE ID_FESTA = X;
COMMIT;

-- REMOCAO DE BRINQUEDO
DELETE FROM AJUSTE_EQUIPAMENTO WHERE EQUIPAMENTO = 'Nome equipamento';
DELETE FROM BRINQUEDO WHERE NOME = 'NOME BRINQUEDO';
DELETE FROM EQUIPAMENTO WHERE NOME = 'EQUIPAMENTO';
COMMIT;

-- REMOCAO DE CLIENTE
DELETE FROM CLIENTE WHERE CPF = 'XXX.XXX.XXX-XX';
DELETE FROM TIPO_PESSOA WHERE CPF = 'XXX.XXX.XXX-XX';
COMMIT;

-- REMOCAO DE AJUSTE DE EQUIPAMENTOS
DELETE FROM AJUSTE_EQUIPAMENTO WHERE EQUIPAMENTO = 'Nome equip' AND TECNICO = 'XXX.XXX.XXX-XX' AND DATA = TO_DATE('XX-XX-XXXX 22:30','DD-MM-YYYY HH24:MI');
COMMIT;

-- REMOCAO DE FESTA_FUNCIONARIO
DELETE FROM FESTA_FUNCIONARIO WHERE FUNCIONARIO = 'XXX.XXX.XXX-XX' AND FESTA = X;
COMMIT;

-- REMOCAO DE APRESENTACAO_MAGICO
DELETE FROM APRESENTACAO_MAGICO WHERE MAGICO = 'XXX.XXX.XXX-XX' AND FESTA_INFANTIL = X;
COMMIT;

-- REMOCAO DE APRESENTACAO_ANIMADOR
DELETE FROM APRESENTACAO_ANIMADOR WHERE ANIMADOR = 'XXX.XXX.XXX-XX' AND FESTA_INFANTIL = X;
COMMIT;

-- REMOCAO DE APRESENTACAO_TEATRO
DELETE FROM APRESENTACAO_TEATRO WHERE TEATRO = 'NOME' AND FESTA_INFANTIL = X;
COMMIT;