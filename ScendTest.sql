CREATE TABLE J (
        ID_J CHAR(4) NOT NULL,
        JNAME char(20),
        CITY char(10),
constraint pk_J PRIMARY KEY (ID_J));

select * from j;

CREATE TABLE P (
        ID_P CHAR(4) NOT NULL,
        PNAME char(20),
        COLOR char(8),
        WEIGHT integer,
        CITY char(10),
constraint pk_P PRIMARY KEY (ID_P));


CREATE TABLE S (
        ID_S CHAR(4) NOT NULL,
        SNAME char(20),
        STATUS CHAR(2),
        CITY char(10),
constraint pk_S PRIMARY KEY (ID_S));


CREATE TABLE SPJ (
        ID_S CHAR(4) NOT NULL,
        ID_P CHAR(4) NOT NULL,
        ID_J CHAR(4) NOT NULL,
        QTY integer,
        DATE_DERNIERE_LIVRAISON date,
constraint pk_SPJ PRIMARY KEY (ID_S, ID_P, ID_J),
constraint pk_SPJ_S FOREIGN KEY (ID_S) REFERENCES S(ID_S),
constraint pk_SPJ_P FOREIGN KEY (ID_P) REFERENCES P(ID_P),
constraint pk_SPJ_J FOREIGN KEY (ID_J) REFERENCES J(ID_J));


-----Q1
select pname 
from P 
WHERE WEIGHT < 16
AND CITY ='Rome'or city='London';                                    



------Q2
select jname from j
where LOWER( jname) LIKE '%i%';

------Q3
SELECT S.ID_S,P.ID_P,J.ID_J FROM P,J,S
WHERE  P.CITY <>J.CITY AND  P.CITY <> S.CITY AND J.CITY <> S.CITY;


-----Q4
SELECT DISTINCT SPJ1.ID_P , SPJ2.ID_P , SPJ1.ID_S
FROM SPJ SPJ1 , SPJ SPJ2
WHERE SPJ1.ID_S = SPJ2.ID_S AND SPJ1.ID_P > SPJ2.ID_P;






SELECT J.JNAME 
FROM J , SPJ 
WHERE( J.ID_J=SPJ.ID_J AND SPJ.ID_S='S1');
---Q6
SELECT P.COLOR 
FROM P , SPJ 
WHERE( P.ID_P=SPJ.ID_P AND SPJ.ID_S='S3');
---Q7

select id_p from p 
where city = 'London' and id_p in (select ID_P from spj);

---Q8
select DISTINCT s.id_s , s.city , p.id_p , p.city , j.id_j , j.city 
from s,p,j , spj
where s.city  <> p.city and s.city <> j.city and p.city <> j.city;


/* EX 2*/
/* Q1 */

SELECT COUNT(*), QTY
FROM spj
GROUP BY QTY;

/* Q2 */
SELECT ID_S, COUNT(*)
FROM spj
GROUP BY ID_S; 

/* Q3 */
SELECT J.jname,SUM(SPJ.qty)
FROM J,SPJ
WHERE J.ID_J = SPJ.ID_J
GROUP BY SPJ.ID_J,J.jname;


/* Q4 */
SELECT DISTINCT SPJ.ID_S, SPJ.ID_P, SPJ.ID_J, (P.WEIGHT*SPJ.QTY)  
FROM SPJ,P
WHERE SPJ.ID_P = P.ID_P;


/* Q5 */
SELECT sum(P.WEIGHT*SPJ.QTY) POIDS , ID_J
FROM SPJ,P
WHERE SPJ.ID_P = P.ID_P
GROUP BY SPJ.ID_J;

/* Q6 */
SELECT MAX(SPJ.QTY*P.WEIGHT) POIDS
FROM SPJ,P
WHERE SPJ.ID_P = P.ID_P;


/*q7*/


SELECT DISTINCT   J.ID_J, P.ID_P,SPJ.QTY TOTAL
FROM J,P,SPJ
WHERE SPJ.ID_P=P.ID_P ;

/*Q8*/
SELECT P.ID_P , J.ID_J
FROM P , J ,SPJ 
WHERE AVG( SPJ.QTY ) > 320;










--------------------------------EX 3---------------------------------









/* chargement de la table S */
insert into S values('S1','Smith','20','London');
insert into S values('S2','Jones','10','Paris');
insert into S values('S3','Blake','30','Paris');
insert into S values('S4','Clark','20','London');
insert into S values('S5','Adams','30','Athens');

/* chargement de la table P */

insert into P values('P1','Nut','Red',12,'London');
insert into P values('P2','Bolt','Green',17,'Paris');
insert into P values('P3','Screw','Blue',17,'Rome');
insert into P values('P4','Screw','Red',14,'London');
insert into P values('P5','Cam','Blue',12,'Paris');
insert into P values('P6','Cog','Red',19,'London');


/* chargement de la table J */
insert into J values('J1','Sorter','Paris');
insert into J values('J2','Display','Rome');
insert into J values('J3','OCR','Athens');
insert into J values('J4','Console','Athens');
insert into J values('J5','RAID','London');
insert into J values('J6','EDS','Oslo');
insert into J values('J7','Tape','London');



 /* chargement de la table SPJ */
insert into SPJ values('S1','P1','J1',200,'05-OCT-2001');
insert into SPJ values('S1','P1','J4',700,'10-MAY-2001');
insert into SPJ values('S2','P3','J1',400,'20-MAY-2001');
insert into SPJ values('S2','P3','J2',200,'30-JUL-2000');
insert into SPJ values('S2','P3','J3',200,'10-JUN-2001');
insert into SPJ values('S2','P3','J4',500,'03-OCT-2001');
insert into SPJ values('S2','P3','J5',600,'20-SEP-2001');
insert into SPJ values('S2','P3','J6',400,'12-MAY-2000');
insert into SPJ values('S2','P3','J7',800,'23-AUG-2001');
insert into SPJ values('S2','P5','J2',100,'23-JUN-2000');
insert into SPJ values('S3','P3','J1',200,'07-JUL-2001');
insert into SPJ values('S3','P4','J2',500,'18-MAY-2001');
insert into SPJ values('S4','P6','J3',300,'10-MAY-2001');
insert into SPJ values('S4','P6','J7',300,'16-SEP-2001');
insert into SPJ values('S5','P2','J2',200,'10-NOV-2001');
insert into SPJ values('S5','P2','J4',100,'17-APR-2001');
insert into SPJ values('S5','P5','J5',500,'08-FEB-2001');
insert into SPJ values('S5','P5','J7',100,'25-JUN-2001');
insert into SPJ values('S5','P6','J2',200,'09-FEB-2001');
insert into SPJ values('S5','P1','J4',100,'18-MAR-2000');
insert into SPJ values('S5','P3','J4',200,'19-MAY-2001');
insert into SPJ values('S5','P4','J4',800,'10-MAY-2001');
insert into SPJ values('S5','P5','J4',400,'16-DEC-2001');
insert into SPJ values('S5','P6','J4',500,'10-OCT-2001');
commit;