
-- script em SQL contendo 6 consultas de alta ou media complexidade.

-- selecionar o nome, salario e cargo  dos funcionarios que recebem mais que a media de salario dos funcionarios.
SELECT FUNC.NOME, FUNC.SALARIO, FUNC.CARGO FROM FUNCIONARIO FUNC
WHERE FUNC.SALARIO >
	(SELECT AVG(F.SALARIO) AS MEDIA_SALARIAL 
	FROM FUNCIONARIO F
);

-- Selecionar para grupo de fantoches o nome o seu tipo, o tema da festa, data e hora em que trabalharam
-- ordenar por nome tipo de teatro e tema da festa.
SELECT TF.NOME AS NOME_TEATRO, FI.TEMA AS TEMA_FESTA, TO_CHAR(F.DATA, 'DD/MM/YYYY-HH24:MI') AS DATA
FROM TEATRO_FANTOCHE TF, APRESENTACAO_TEATRO AT, FESTA F, FESTA_INFANTIL FI
WHERE (TF.NOME = AT.TEATRO) AND (AT.FESTA_INFANTIL = FI.FESTA) AND (F.ID_FESTA = FI.FESTA)
ORDER BY TF.TIPO, FI.TEMA;

-- selecionar o cep e o numero do local, alem do horario as festas infantis que ocorreram ou irao ocorrer  
--em 2018 e o nome do cliente associado, ordenando por data e hora da festa.
SELECT C.NOME AS CLIENTE, FI.TEMA AS TEMA_FESTA, F.CEP, F.NUMERO, TO_CHAR(F.DATA, 'DD/MM-HH24:MI') AS DATA
FROM FESTA F, CLIENTE C, FESTA_INFANTIL FI
WHERE FI.FESTA = F.ID_FESTA AND F.CLIENTE = C.CPF AND UPPER(F.TIPO_FESTA) = 'INFANTIL' AND EXTRACT(YEAR FROM F.DATA) = 2018
ORDER BY F.DATA;

-- selecionar o nome e telefone e funcao dos funcionarios e data das festas que eles foram designados para trabalhar.
SELECT FUNC.NOME AS NOME_FUNCIONARIO, FUNC.TELEFONE, FUNC.CARGO, TO_CHAR(F.DATA, 'DD/MM/YYYY-HH24:MI') AS HORARIO
FROM FUNCIONARIO FUNC, FESTA_FUNCIONARIO FF, FESTA F
WHERE FUNC.CPF = FF.FUNCIONARIO AND UPPER(F.TIPO_FESTA) = 'INFANTIL' AND FF.FESTA = F.ID_FESTA;

--selecionar o valor que a empresa gasta pagando cada tipo de atracoes individuais (animador e magico) que apresentam em festas infantis
SELECT TA.TIPO_ATRACAO, SUM (CASE WHEN TA.TIPO_ATRACAO = 'MAGICO' THEN M.SALARIO ELSE A.SALARIO END) AS PAGAMENTO
FROM TIPO_ATRACAO TA LEFT JOIN ANIMADOR A ON (TA.CPF = A.CPF)
LEFT JOIN MAGICO M ON (TA.CPF = M.CPF)
GROUP BY TA.TIPO_ATRACAO
HAVING TIPO_ATRACAO = 'ANIMADOR' OR TIPO_ATRACAO = 'MAGICO';

-- selecionar para os tecnicos o seu nome, seu salario e se ele tiver dado manutencao
-- em algum brinquedo o nome e a data e horario em que ele fez a manutencao.
SELECT F.NOME AS FUNCIONARIO, F.SALARIO, E.NOME AS NOME_BRINQUEDO, TO_CHAR(AE.DATA, 'DD/MM/YYYY-HH24:MI') AS DATA_MANUTENCAO
FROM AJUSTE_EQUIPAMENTO AE JOIN EQUIPAMENTO E ON E.NOME = AE.EQUIPAMENTO AND UPPER(E.TIPO_EQUIPAMENTO) = 'BRINQUEDO' 
RIGHT JOIN TECNICO T ON AE.TECNICO = T.FUNCIONARIO
JOIN FUNCIONARIO F ON T.FUNCIONARIO = F.CPF;






