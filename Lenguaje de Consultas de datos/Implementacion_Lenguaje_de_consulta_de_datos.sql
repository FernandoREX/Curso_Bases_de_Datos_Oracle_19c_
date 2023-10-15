/*
   Autor: Fernando Rosas Gómez
   Fecha de Creación: 09/10/2023
   
   NOTA:
   Este código no esta apto para ejecutar, solo muestra las instrucciones.

   Descripción:
   Este script SQL realiza varias consultas en la base de datos utilizando las tablas 
   "employees" y "jobs" del usuario "HR". Cada consulta se enfoca en obtener información 
   específica de los empleados y departamentos de acuerdo con diferentes criterios.

   Ejercicios.

    a) Muestre la clave de los departamentos, nombre y salario de los empleados, donde
       el departamento asignando sea mayor a 100, ordenelo por numero de departamento.

    b) Proporcione las claves de los departamentos, puestos, nombres y salarios de los 
       empleados que sean gerente de ventas o empleado de almacén

    c) Obtenga el nombre, email, telefono, salario, y comisión de los representantes de 
       ventas, ordenados en forma descendente de acurdo a su comisión

    d) Obtenga el nombre, email, teléfono y fecha de ingreso de los empleados que ingresaron
       entre el año de 2002 y 2005, ordenelos por la fecha de ingreso

    e) Muestre la clave, nombre, puesto y fecha de ingreso de los empleados coyo apellido 
       tenga en el segundo caracter la leta "i"

*/

-- Consulta 1: Muestra la descripción de la tabla "employees".
SQL> DESC employees
 Nombre                                    ┐Nulo?   Tipo
 ----------------------------------------- -------- ----------------------------
 EMPLOYEE_ID                               NOT NULL NUMBER(6)
 FIRST_NAME                                         VARCHAR2(20)
 LAST_NAME                                 NOT NULL VARCHAR2(25)
 EMAIL                                     NOT NULL VARCHAR2(25)
 PHONE_NUMBER                                       VARCHAR2(20)
 HIRE_DATE                                 NOT NULL DATE
 JOB_ID                                    NOT NULL VARCHAR2(10)
 SALARY                                             NUMBER(8,2)
 COMMISSION_PCT                                     NUMBER(2,2)
 MANAGER_ID                                         NUMBER(6)
 DEPARTMENT_ID                                      NUMBER(4)

-- Consulta 2: Muestra la descripción de la tabla "departments".
SQL> DESC departments
 Nombre                                    ┐Nulo?   Tipo
 ----------------------------------------- -------- ----------------------------
 DEPARTMENT_ID                             NOT NULL NUMBER(4)
 DEPARTMENT_NAME                           NOT NULL VARCHAR2(30)
 MANAGER_ID                                         NUMBER(6)
 LOCATION_ID                                        NUMBER(4)

-- Consulta 3: Selecciona empleados cuyo departamento tiene un ID mayor a 100, ordenados por departamento.
SQL>  SELECT DEPARTMENT_ID Departamento_ID, FIRST_NAME Nombre, LAST_NAME Apellido, SALARY Salario
  2   FROM employees
  3   WHERE DEPARTMENT_ID > 100
  4   ORDER BY DEPARTMENT_ID;

/*
   Descripción de la Consulta 3:
   Esta consulta selecciona los empleados cuyo departamento tiene un ID mayor a 100.
   Luego, muestra la clave del departamento, el nombre y el salario de los empleados,
   ordenados por el número de departamento.
*/

-- Consulta 4: Selecciona empleados que son gerentes de ventas o empleados de almacén.
SQL> SELECT E.DEPARTMENT_ID, J.JOB_TITLE, E.FIRST_NAME, E.LAST_NAME, E.SALARY
  2  FROM employees E
  3  JOIN jobs J USING(JOB_ID)
  4  WHERE J.JOB_TITLE IN ('Sales Manager', 'Stock Clerk');

/*
   Descripción de la Consulta 4:
   Esta consulta selecciona empleados que son gerentes de ventas o empleados de almacén.
   Utiliza una unión entre las tablas "employees" y "jobs" para obtener información de empleados
   y sus títulos de trabajo. Luego, muestra el departamento, el título del trabajo, el nombre y
   el salario de los empleados que cumplen con los criterios especificados.
*/

-- Consulta 5: Selecciona representantes de ventas ordenados por comisión descendente.
SQL> SELECT FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, SALARY, COMMISSION_PCT
  2  FROM employees
  3  WHERE JOB_ID = 'SA_REP'
  4  ORDER BY COMMISSION_PCT DESC;

/*
   Descripción de la Consulta 5:
   Esta consulta selecciona a los representantes de ventas (cuyo ID de trabajo es 'SA_REP')
   y muestra su nombre, apellido, correo electrónico, número de teléfono, salario y comisión.
   Los resultados se ordenan en orden descendente de acuerdo con el porcentaje de comisión.
*/

-- Consulta 6: Selecciona empleados contratados entre 2002 y 2005, ordenados por fecha de ingreso.
SQL> SELECT FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, SALARY, HIRE_DATE
  2  FROM employees
  3  WHERE HIRE_DATE BETWEEN '01/01/02' AND '31/12/05'
  4  ORDER BY HIRE_DATE;

/*
   Descripción de la Consulta 6:
   Esta consulta selecciona empleados contratados entre los años 2002 y 2005.
   Muestra el nombre, apellido, correo electrónico, número de teléfono, salario y fecha de ingreso de
   los empleados que cumplen con este criterio. Los resultados se ordenan por fecha de ingreso.
*/

-- Consulta 7: Selecciona empleados cuyo apellido tiene una "i" en el segundo carácter.
SQL> SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_TITLE, HIRE_DATE
  2  FROM employees
  3  JOIN jobs USING(JOB_ID)
  4  WHERE LAST_NAME LIKE '_i%';

/*
   Descripción de la Consulta 7:
   Esta consulta selecciona empleados cuyo apellido tiene una "i" en el segundo carácter.
   Utiliza una unión entre las tablas "employees" y "jobs" para obtener información de empleados
   y sus títulos de trabajo. Luego, muestra el ID de empleado, el nombre, el apellido, el título del
   trabajo y la fecha de ingreso de los empleados que cumplen con este criterio.
*/
