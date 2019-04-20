INSERT INTO PARTIDA (TIME1, TIME2, DATA) VALUES ('VASCO', 'CHAPECOENSE', TO_DATE('06-06-2018', 'DD-MM-YYYY')); #INSERCAO DE UM VALOR NA DATA DE HOJE E LOCAL NULO
INSERT INTO PARTIDA (TIME1, TIME2, DATA) VALUES ('VASCO', 'CHAPECOENSE', TO_DATE('07-06-2018', 'DD-MM-YYYY')); #INSERCAO DE UM VALOR COM DATA FUTURA E LOCAL NULO

SELECT P.TIME1, P.TIME2 FROM PARTIDA P WHERE (P.DATA - SYSDATE > 0 AND P.LOCAL IS NULL);

/*
TIME1                TIME2               

-------------------- --------------------

VASCO                CHAPECOENSE         
*/


SELECT T1.NOME, T1.ESTADO, T2.NOME, T2.ESTADO , P.DATA, P.PLACAR 
FROM TIME T1, TIME T2, PARTIDA P 
WHERE (P.TIME1 = T1.NOME AND P.TIME2 = T2.NOME);

/*
NOME                 ES NOME                 ES DATA      PLACA
-------------------- -- -------------------- -- --------- -----
INTER                SP PALMEIRAS            SP 02-MAR-18 1X0  
VASCO                RJ CHAPECOENSE          SC 07-JUN-18 0X0  
VASCO                RJ CHAPECOENSE          SC 06-JUN-18 0X0  
VASCO                RJ CHAPECOENSE          SC 30-APR-18 0X0  
PALMEIRAS            SP SANTOS               SP 01-FEB-18 4X2  
CRUZEIRO             MG SANTOS               SP 01-JUL-18 0X2  
UNIDOS                  INTER                SP 01-DEC-18 0X0
*/

SELECT T1.NOME, T1.ESTADO, T2.NOME, T2.ESTADO , P.DATA, P.PLACAR, J.CLASSICO 
FROM TIME T1, TIME T2, PARTIDA P, JOGA J
WHERE (P.TIME1 = T1.NOME AND P.TIME2 = T2.NOME AND P.TIME1 = J.TIME1 AND P.TIME2 = J.TIME2);

/*
NOME                 ES NOME                 ES DATA      PLACA C
-------------------- -- -------------------- -- --------- ----- -
INTER                SP PALMEIRAS            SP 02-MAR-18 1X0   N
VASCO                RJ CHAPECOENSE          SC 30-APR-18 0X0   S
VASCO                RJ CHAPECOENSE          SC 06-JUN-18 0X0   S
VASCO                RJ CHAPECOENSE          SC 07-JUN-18 0X0   S
CRUZEIRO             MG SANTOS               SP 01-JUL-18 0X2   N
PALMEIRAS            SP SANTOS               SP 01-FEB-18 4X2   S
UNIDOS                  INTER                SP 01-DEC-18 0X0    

O que muda para a consulta anterior eh o fato de precisar juntar com a tabela joga para obter se eh classico ou nao
*/

SELECT COUNT (*) FROM PARTIDA P, JOGA J
WHERE (P.TIME1 = J.TIME1 AND P.TIME2 = J.TIME2 AND EXTRACT(MONTH FROM P.DATA) = 02 AND EXTRACT(YEAR FROM P.DATA) = 2018 AND UPPER(CLASSICO) = 'S');

/*
 COUNT(*)
----------
         1
*/

INSERT INTO PARTIDA (TIME1, TIME2, DATA) VALUES ('VASCO', 'CHAPECOENSE', TO_DATE('25-02-2018', 'DD-MM-YYYY')); #INSERCAO DE VALOR VALIDO
INSERT INTO PARTIDA (TIME1, TIME2, DATA) VALUES ('CRUZEIRO', 'SANTOS', TO_DATE('21-02-2018', 'DD-MM-YYYY')); #INSERCAO DE VALOR INVALIDO

SELECT COUNT (*) FROM PARTIDA P, JOGA J
WHERE (P.TIME1 = J.TIME1 AND P.TIME2 = J.TIME2 AND EXTRACT(MONTH FROM P.DATA) = 02 AND EXTRACT(YEAR FROM P.DATA) = 2018 AND UPPER(CLASSICO) = 'S');

/*
  COUNT(*)
----------
         2
*/

SELECT T.ESTADO, AVG(T.SALDO_GOLS) AS MEDIA 
FROM TIME T 
WHERE T.ESTADO IS NOT NULL AND T.SALDO_GOLS IS NOT NULL
GROUP BY ESTADO ORDER BY ESTADO;

/*
ES      MEDIA
-- ----------
MG         17
RJ          2
SC         20
SP         15
*/

SELECT T.ESTADO, COUNT(*) AS QUANTIDADE_TIMES, AVG(T.SALDO_GOLS) AS MEDIA
FROM TIME T
WHERE T.ESTADO IS NOT NULL AND T.SALDO_GOLS IS NOT NULL
GROUP BY ESTADO
ORDER BY QUANTIDADE_TIMES

/*
ES QUANTIDADE_TIMES      MEDIA
-- ---------------- ----------
RJ                1          2
SC                1         20
MG                1         17
SP                3         15                   
*/

INSERT INTO TIME (NOME, ESTADO, TIPO, SALDO_GOLS) VALUES ('ATLETICO','MG','AMADOR',5);

SELECT T.TIPO, T.ESTADO, AVG(T.SALDO_GOLS) AS MEDIA
FROM TIME T
WHERE T.ESTADO IS NOT NULL AND T.SALDO_GOLS IS NOT NULL
GROUP BY T.TIPO, T.ESTADO
ORDER BY T.TIPO, T.ESTADO;

/*
TIPO         ES      MEDIA
------------ -- ----------
AMADOR       MG          5
AMADOR       SP          1
PROFISSIONAL MG         17
PROFISSIONAL RJ          2
PROFISSIONAL SC         20
PROFISSIONAL SP         22
*/

INSERT INTO TIME (NOME, ESTADO, TIPO, SALDO_GOLS) VALUES ('FLUMINENSE','RJ','PROFISSIONAL',-1);

SELECT ESTADO, AVG(SALDO_GOLS) AS MEDIA
FROM TIME
WHERE UPPER(TIPO) = 'PROFISSIONAL' AND SALDO_GOLS >= 1
GROUP BY ESTADO;

/*
ES      MEDIA
-- ----------
RJ          2
MG         17
SP         22
SC         20
*/

SELECT ESTADO, AVG(SALDO_GOLS) AS MEDIA 
FROM TIME
WHERE ESTADO IS NOT NULL AND SALDO_GOLS IS NOT NULL AND UPPER(TIPO) = 'PROFISSIONAL'
GROUP BY ESTADO
HAVING COUNT(*) > 1;

/*
ES      MEDIA
-- ----------
RJ ,5        
SP         22
*/

INSERT INTO TIME (NOME, ESTADO, TIPO, SALDO_GOLS) VALUES ('PAULISTA','SP','PROFISSIONAL',0);

SELECT ESTADO, AVG(SALDO_GOLS) AS MEDIA 
FROM TIME
WHERE ESTADO IS NOT NULL AND SALDO_GOLS IS NOT NULL AND UPPER(TIPO) = 'PROFISSIONAL'
GROUP BY ESTADO
HAVING COUNT(*) > 1 AND AVG(SALDO_GOLS) BETWEEN 5 AND 15;

/*
ES      MEDIA
-- ----------
SP 14,6666667
*/

SELECT P.TIME1, P.TIME2, P.LOCAL, P.DATA, J.CLASSICO
FROM PARTIDA P, JOGA J
WHERE
	(P.TIME1 = J.TIME1 AND P.TIME2 = J.TIME2) AND 
	(UPPER(P.TIME1) = 'VASCO' AND P.PLACAR LIKE '0X_' OR UPPER(P.TIME2) = 'VASCO' AND P.PLACAR LIKE '_X0') AND
	P.DATA - SYSDATE < 0;

/*
TIME1                TIME2                LOCAL           DATA     C
-------------------- -------------------- --------------- -------- -
VASCO                CHAPECOENSE                          06/06/18 S
VASCO                CHAPECOENSE                          25/02/18 S
VASCO                CHAPECOENSE          RIO DE JANEIRO  30/04/18 S
VASCO                CHAPECOENSE                          07/06/18 S
*/

SELECT P.TIME1, P.TIME2, P.DATA, P.PLACAR
FROM TIME T1, TIME T2, JOGA J, PARTIDA P
WHERE T1.NOME = J.TIME1 AND T2.NOME = J.TIME2 AND P.TIME1 = J.TIME1 AND P.TIME2 = J.TIME2 --CONDICAO DE JUNCAO DAS TABELAS
AND UPPER(J.CLASSICO) = 'S' AND UPPER(T1.TIPO) = 'PROFISSIONAL' AND UPPER(T2.TIPO) = 'PROFISSIONAL';

/*
TIME1                TIME2                DATA     PLACA
-------------------- -------------------- -------- -----
VASCO                CHAPECOENSE          25/02/18 0X0  
VASCO                CHAPECOENSE          30/04/18 0X0  
VASCO                CHAPECOENSE          06/06/18 0X0  
VASCO                CHAPECOENSE          07/06/18 0X0  
PALMEIRAS            SANTOS               01/02/18 4X2  
*/

SELECT T.NOME, T.ESTADO, D.NOME
FROM TIME T 
LEFT JOIN DIRETOR D
ON T.NOME = D.TIME;

/*
NOME                 ES NOME                
-------------------- -- --------------------
ATLETICO             MG                     
CHAPECOENSE          SC GILSON              
CRUZEIRO             MG MANO MENEZES        
FLUMINENSE           RJ                     
INTER                SP AUGUSTO             
PALMEIRAS            SP ROGER MACHADO       
PAULISTA             SP                     
SANTOS               SP JAIR                
UNIDOS                  CAMARGO             
VASCO                RJ ZE RICARDO        
*/

SELECT T.NOME, T.ESTADO,(CASE WHEN T.NOME = P.TIME1 THEN P.TIME2 ELSE P.TIME1 END) AS ADVERSARIO, P.DATA
FROM TIME T LEFT JOIN PARTIDA P
ON (T.NOME = P.TIME1 OR T.NOME = P.TIME2) AND P.DATA - SYSDATE < 0;

/*
NOME                 ES ADVERSARIO           DATA    
-------------------- -- -------------------- --------
PALMEIRAS            SP INTER                02/03/18
PALMEIRAS            SP SANTOS               01/02/18
VASCO                RJ CHAPECOENSE          25/02/18
VASCO                RJ CHAPECOENSE          30/04/18
VASCO                RJ CHAPECOENSE          06/06/18
VASCO                RJ CHAPECOENSE          07/06/18
CHAPECOENSE          SC VASCO                25/02/18
CHAPECOENSE          SC VASCO                30/04/18
CHAPECOENSE          SC VASCO                06/06/18
CHAPECOENSE          SC VASCO                07/06/18
SANTOS               SP CRUZEIRO             21/02/18

NOME                 ES ADVERSARIO           DATA    
-------------------- -- -------------------- --------
SANTOS               SP PALMEIRAS            01/02/18
UNIDOS                                               
INTER                SP PALMEIRAS            02/03/18
CRUZEIRO             MG SANTOS               21/02/18
ATLETICO             MG                              
FLUMINENSE           RJ                              
PAULISTA             SP                              
*/

SELECT T.NOME, T.ESTADO,(CASE WHEN T.NOME = P.TIME1 THEN P.TIME2 ELSE P.TIME1 END) AS ADVERSARIO, P.DATA, J.CLASSICO
FROM PARTIDA P JOIN JOGA J 
    ON P.TIME1 = J.TIME1 AND P.TIME2 = J.TIME2
RIGHT JOIN TIME T
ON (T.NOME = P.TIME1 OR T.NOME = P.TIME2) AND P.DATA - SYSDATE < 0;

/*
NOME                 ES ADVERSARIO           DATA     C
-------------------- -- -------------------- -------- -
PALMEIRAS            SP INTER                02/03/18 N
PALMEIRAS            SP SANTOS               01/02/18 S
VASCO                RJ CHAPECOENSE          25/02/18 S
VASCO                RJ CHAPECOENSE          30/04/18 S
VASCO                RJ CHAPECOENSE          06/06/18 S
VASCO                RJ CHAPECOENSE          07/06/18 S
CHAPECOENSE          SC VASCO                25/02/18 S
CHAPECOENSE          SC VASCO                30/04/18 S
CHAPECOENSE          SC VASCO                06/06/18 S
CHAPECOENSE          SC VASCO                07/06/18 S
SANTOS               SP CRUZEIRO             21/02/18 N

NOME                 ES ADVERSARIO           DATA     C
-------------------- -- -------------------- -------- -
SANTOS               SP PALMEIRAS            01/02/18 S
UNIDOS                                                 
INTER                SP PALMEIRAS            02/03/18 N
CRUZEIRO             MG SANTOS               21/02/18 N
ATLETICO             MG                                
FLUMINENSE           RJ                                
PAULISTA             SP       
*/

SELECT T.NOME
FROM PARTIDA P, TIME T
WHERE (P.TIME1 = T.NOME OR P.TIME2 = T.NOME) AND EXTRACT(YEAR FROM P.DATA) = 2018 AND P.DATA - SYSDATE < 0
GROUP BY T.NOME
HAVING COUNT(*) > 0;

/*
NOME                
--------------------
SANTOS
VASCO
PALMEIRAS
CHAPECOENSE
CRUZEIRO
INTER
*/

SELECT NOME FROM TIME
WHERE NOME IN (
    SELECT T.NOME
    FROM PARTIDA P, TIME T
    WHERE (P.TIME1 = T.NOME OR P.TIME2 = T.NOME) AND EXTRACT(YEAR FROM P.DATA) = 2018 AND P.DATA - SYSDATE < 0
    GROUP BY T.NOME
    HAVING COUNT(*) > 0
    );

/*
NOME                
--------------------
SANTOS
VASCO
PALMEIRAS
CHAPECOENSE
CRUZEIRO
INTER
*/

SELECT NOME 
FROM TIME T 
WHERE(
    EXISTS(SELECT T.NOME 
        FROM PARTIDA P 
        WHERE (P.TIME1 = T.NOME OR P.TIME2 = T.NOME) AND EXTRACT(YEAR FROM P.DATA) = 2018 AND P.DATA - SYSDATE < 0
        GROUP BY T.NOME
        HAVING COUNT(*) > 0
    )
);

/*
NOME                
--------------------
CHAPECOENSE
CRUZEIRO
INTER
PALMEIRAS
SANTOS
VASCO
*/



SELECT NOME FROM TIME
WHERE NOME NOT IN (SELECT T.NOME
FROM PARTIDA P, TIME T
WHERE (P.TIME1 = T.NOME OR P.TIME2 = T.NOME) AND EXTRACT(YEAR FROM P.DATA) = 2018 AND P.DATA - SYSDATE < 0
GROUP BY T.NOME
HAVING COUNT(*) > 0);

/*
NOME                
--------------------
FLUMINENSE
ATLETICO
UNIDOS
PAULISTA
*/

SELECT NOME, ESTADO, SALDO_GOLS
FROM TIME 
WHERE SALDO_GOLS IN( 
    SELECT MAX(SALDO_GOLS)
    FROM TIME
    GROUP BY ESTADO
    );

/*
NOME                 ES SALDO_GOLS
-------------------- -- ----------
PALMEIRAS            SP         23
VASCO                RJ          2
CHAPECOENSE          SC         20
CRUZEIRO             MG         17
*/











