/*
   Autor: Fernando Rosas
   Fecha de Creación: 11/10/23

   Descripción:
   Este script SQL se ejecuta con el usuario "curso" y se basa en los esquemas utilizados anteriormente. 
   Realiza cuatro consultas diferentes y utiliza las tablas "trabajador", "prestamoEmp" y "ctaAhorroEmp".

   1.  Realice las siguientes consultas
    
    a) Muestre el nombre de los empleados, claves de los prestamos y cuenta de ahorro, 
       de aquellos que tienen prestamos y tengan o no cuenta de ahorros
    
    b) Muestre el nombre de los empleados, clave de las cuenta de ahorro y clave de prestamos,
       de aquellos que tienen cuenta de ahorro y sus prestamos solicitados, aun cuando no los 
       tengan

    c) Proporcione el nombre de todos los empleados, clave del prestamo, monto clave de ahorros 
       y saldos, tengan o no cuenta de ahorros o prestamos
    
    d) Obtenga el nombre de los empleados y el monto de los prestamos, aun cuando no los tenga

*/

-----------------------Tablas y datos que necesitamos------------------------

CREATE TABLE trabajador
(
numEmp CHAR(4) PRIMARY KEY,
nombreEmp varchar2(20) NOT NULL,
domEmpleado VARCHAR2(30) NOT NULL,
telEmp CHAR(10) NOT NULL
);

insert into trabajador values('E1','Alberto Juarez','Alamos 124',54343456);
insert into trabajador values('E2','Esperanza Villanueva','Musicos 1304',56789072);
insert into trabajador values('E3','Rosa Diaz','Violeta 345',45678903);
insert into trabajador values('E4','Hector Valdes','Xochimilco 65',54233456);
insert into trabajador values('E5','Luis Perez','Volcanes 45',34356789);
insert into trabajador values('E6','Roberto Espinoza','San Pablo 18',54215846);

create table prestamoEmp(
clavePrest char(4) primary key,
monto number(8,2) not null,
fechaPrest date not null,
numEmp char(4) not null,
foreign key (numEmp) references trabajador);

create table ctaAhorroEmp(
claveCta char(4) primary key,
saldo number(8,2),
fechaCta date,
numEmp char(4) not null,
foreign key (numEmp) references trabajador);

insert into prestamoEmp values('Pre1',2000,'17/04/13','E2');
insert into prestamoEmp values('Pre2',3000,'22/02/17','E2');
insert into prestamoEmp values('Pre3',7000,'2/03/15','E3');
insert into prestamoEmp values('Pre4',10000,'20/05/17','E5');
insert into prestamoEmp values('Pre5',2000,'13/07/16','E5');
insert into prestamoEmp values('Pre6',8000,'15/08/17','E3');


insert into ctaahorroEmp values('Ah1',1000,'17/08/13','E4');
insert into ctaahorroEmp values('Ah2',5000,'23/04/15','E2');
insert into ctaahorroEmp values('Ah3',4000,'30/03/14','E4');
insert into ctaahorroEmp values('Ah4',2500,'3/03/13','E3');
insert into ctaahorroEmp values('Ah5',4200,'13/07/16','E3');
insert into ctaahorroEmp values('Ah6',3000,'10/04/15','E5');
insert into ctaahorroEmp values('Ah7',5700,'15/04/17','E3');

-----------------------------------------------------------------------------

-- Consulta 1: Muestra el nombre de los empleados, claves de préstamos y cuentas de ahorro, independientemente de si tienen ambas o ninguna.

SELECT nombreEmp, clavePrest, claveCta
FROM trabajador
JOIN prestamoEmp USING (numEmp)
LEFT JOIN ctaAhorroEmp USING(numEmp);

/*
   Descripción de la Consulta 1:

   SQL> SELECT nombreEmp, clavePrest, claveCta
   2  FROM trabajador
   3  JOIN prestamoEmp USING (numEmp)
   4  LEFT JOIN ctaAhorroEmp USING(numEmp);

   Esta consulta selecciona el nombre de los empleados, las claves de préstamos y las claves de cuentas de ahorro.
   Utiliza una unión entre las tablas "trabajador" y "prestamoEmp" y una unión izquierda con "ctaAhorroEmp". 
   Muestra los resultados de empleados que tienen préstamos, independientemente de si tienen cuentas de ahorro.
*/

-- Consulta 2: Muestra el nombre de los empleados, la clave de la cuenta de ahorro y la clave de préstamos, incluso si no tienen préstamos.
SELECT nombreEmp, claveCta, clavePrest
FROM trabajador
JOIN ctaAhorroEmp USING(numEmp)
LEFT JOIN prestamoEmp USING(numEmp);


/*
   Descripción de la Consulta 2:

   SQL> SELECT nombreEmp, claveCta, clavePrest
   2  FROM trabajador
   3  JOIN ctaAhorroEmp USING(numEmp)
   4  LEFT JOIN prestamoEmp USING(numEmp);

   Esta consulta selecciona el nombre de los empleados, la clave de la cuenta de ahorro y la clave de préstamos.
   Utiliza una unión entre las tablas "trabajador" y "ctaAhorroEmp" y una unión izquierda con "prestamoEmp".
   Muestra los resultados de empleados que tienen cuentas de ahorro y, si tienen préstamos, también los muestra, incluso si no tienen préstamos.
*/

-- Consulta 3: Proporciona el nombre de todos los empleados, la clave del préstamo, el saldo de la cuenta y el monto, tengan o no cuentas de ahorro o préstamos.
SELECT nombreEmp, clavePrest, saldo, monto
FROM trabajador
LEFT JOIN ctaAhorroEmp USING(numEmp)
LEFT JOIN prestamoEmp USING(numEmp);


/*
   Descripción de la Consulta 3:

   SQL> SELECT nombreEmp, clavePrest, saldo, monto
   2  FROM trabajador
   3  LEFT JOIN ctaAhorroEmp USING(numEmp)
   4  LEFT JOIN prestamoEmp USING(numEmp);

   Esta consulta selecciona el nombre de todos los empleados, la clave del préstamo, el saldo de la cuenta y el monto.
   Utiliza una unión izquierda con "ctaAhorroEmp" y otra unión izquierda con "prestamoEmp".
   Muestra los resultados de todos los empleados, independientemente de si tienen cuentas de ahorro o préstamos.
*/

-- Consulta 4: Obtiene el nombre de los empleados y el monto de los préstamos, incluso si no tienen préstamos.
SELECT nombreEmp, monto
FROM trabajador
LEFT JOIN prestamoEmp USING(numEmp);


/*
   Descripción de la Consulta 4:

   SQL> SELECT nombreEmp, monto
   2  FROM trabajador
   3  LEFT JOIN prestamoEmp USING(numEmp);

   Esta consulta selecciona el nombre de los empleados y el monto de los préstamos.
   Utiliza una unión izquierda con "prestamoEmp".
   Muestra los resultados de todos los empleados, incluso si no tienen préstamos.
*/
