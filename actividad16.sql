USE actividades;

-- Actividad 1
SELECT NOMBRE FROM articulos;
SELECT NOMBRE,PRECIO FROM articulos;
SELECT NOMBRE FROM articulos WHERE PRECIO <= 200;
SELECT * FROM articulos WHERE PRECIO BETWEEN 60 AND 120;
SELECT NOMBRE,PRECIO*166.386 AS PRECIO FROM articulos;
SELECT AVG(PRECIO) AS PRECIO_MEDIO FROM articulos;
SELECT AVG(PRECIO) AS PRECIO_MEDIO FROM articulos WHERE FABRICANTE = 2;
SELECT COUNT(NOMBRE) AS NUMERO_DE_ARTICULOS FROM articulos WHERE PRECIO>=180;
SELECT NOMBRE,PRECIO from articulos WHERE PRECIO>=180 ORDER BY PRECIO DESC,NOMBRE ASC;
SELECT a.NOMBRE AS ARTICULO, a.CODIGO AS COD_ARTICULO, a.PRECIO, f.CODIGO AS COD_FABRICANTE, f.NOMBRE AS FABRICANTE FROM articulos AS a, fabricantes AS f WHERE a.FABRICANTE = f.CODIGO;
SELECT a.NOMBRE AS ARTICULO, a.PRECIO AS PRECIO, f.NOMBRE AS FABRICANTE FROM articulos AS a, fabricantes AS f WHERE a.FABRICANTE = f.CODIGO;
SELECT f.CODIGO AS COD_FABRICANTE, AVG(a.PRECIO) AS MEDIA_PRECIO from articulos AS a, fabricantes AS f WHERE a.FABRICANTE = f.CODIGO GROUP BY f.CODIGO;
SELECT f.NOMBRE AS FABRICANTE, AVG(a.PRECIO) AS PRECIO_MEDIO FROM fabricantes AS f, articulos AS a WHERE a.FABRICANTE = f.CODIGO GROUP BY f.CODIGO;
SELECT DISTINCT f.NOMBRE AS NOM_FABRICANTE from articulos AS a, fabricantes AS f where a.FABRICANTE = f.CODIGO AND (SELECT avg(a.PRECIO) >= 150 GROUP BY f.NOMBRE);
SELECT NOMBRE, PRECIO FROM articulos where PRECIO = (select MIN(PRECIO) from articulos);
SELECT a.NOMBRE, a.PRECIO, f.NOMBRE FROM articulos AS a, fabricantes AS f WHERE a.FABRICANTE = f.CODIGO AND a.PRECIO = (SELECT max(a2.PRECIO) FROM articulos AS a2 WHERE a2.FABRICANTE = f.CODIGO);
INSERT INTO articulos (CODIGO, NOMBRE, PRECIO, FABRICANTE) VALUES (11, 'Altavoces', 70, 2);
UPDATE articulos SET NOMBRE = 'Impresora Láser' WHERE CODIGO = 8;
UPDATE articulos SET PRECIO = PRECIO*0.9;
UPDATE articulos SET PRECIO = PRECIO-10 WHERE PRECIO >= 120;

-- Actividad 2
SELECT APELLIDOS FROM empleados;
SELECT DISTINCT APELLIDOS FROM empleados;
SELECT * FROM empleados WHERE APELLIDOS = 'Smith';
SELECT * FROM empleados WHERE APELLIDOS = 'Smith' OR APELLIDOS='Rogers';
SELECT * FROM empleados WHERE DEPARTAMENTO = 14;
SELECT * FROM empleados WHERE DEPARTAMENTO = 37 OR DEPARTAMENTO=77;
SELECT * FROM empleados WHERE APELLIDOS LIKE 'P%';
SELECT SUM(PRESUPUESTO) AS PRESUPUESTO_TOTAL from departamentos;
SELECT e.DNI, e.NOMBRE, e.APELLIDOS, d.CODIGO AS COD_DEPARTAMENTO, d.NOMBRE AS DEPARTAMENTO, d.PRESUPUESTO FROM empleados AS e, departamentos AS d;
SELECT e.NOMBRE, e.APELLIDOS, d.NOMBRE AS DEPARTAMENTO, d.PRESUPUESTO FROM empleados AS e, departamentos AS d;
SELECT e.NOMBRE, e.APELLIDOS FROM empleados AS e, departamentos AS d WHERE e.DEPARTAMENTO = d.CODIGO AND d.PRESUPUESTO > 60000;
SELECT * FROM departamentos WHERE PRESUPUESTO > (SELECT AVG(PRESUPUESTO) FROM departamentos);
SELECT d.NOMBRE FROM departamentos AS d, empleados AS e WHERE (SELECT count(CODIGO) FROM empleados WHERE DEPARTAMENTO = d.CODIGO) > 2 GROUP BY d.NOMBRE;
INSERT INTO departamentos (NOMBRE, PRESUPUESTO, CODIGO) VALUES ('Calidad',40000,11);
INSERT INTO empleados VALUES ('89267109','Ester','Vazquez',11);
UPDATE departamentos SET PRESUPUESTO = PRESUPUESTO * 0.9;
UPDATE empleados SET DEPARTAMENTO = 14 WHERE DEPARTAMENTO = 77;
DELETE FROM empleados WHERE DEPARTAMENTO = 14;
DELETE FROM empleados WHERE DEPARTAMENTO = (SELECT CODIGO FROM departamentos WHERE PRESUPUESTO > 60000);
DELETE FROM empleados;

-- Actividad 3
SELECT * FROM almacenes;
SELECT * FROM cajas WHERE VALOR > 150;
SELECT DISTINCT contenido FROM cajas;
SELECT AVG(valor) AS VALOR_MEDIO FROM cajas GROUP BY contenido;
SELECT AVG(valor) AS VALOR_MEDIO FROM cajas GROUP BY almacen;
SELECT almacen FROM cajas GROUP BY almacen HAVING AVG(valor)>150 ;
SELECT c.NUMREFERENCIA, a.LUGAR FROM cajas AS c, almacenes AS a WHERE c.almacen = a.CODIGO;
SELECT almacen, count(NUMREFERENCIA) AS Numero_Cajas FROM cajas GROUP BY almacen;
SELECT CODIGO FROM almacenes WHERE capacidad < (SELECT count(NUMREFERENCIA) FROM cajas WHERE almacen = CODIGO);
SELECT c.NUMREFERENCIA FROM cajas AS c WHERE c.almacen = (SELECT CODIGO FROM almacenes WHERE LUGAR = 'Bilbao') ;
INSERT INTO almacenes VALUES (11,'Barcelona', 3);
INSERT cajas VALUES ('H5RT', 'Papel', 200, 2);
UPDATE cajas SET valor=valor*0.15;
UPDATE cajas AS c SET c.valor=c.valor*0.2 WHERE c.valor > (SELECT * FROM (SELECT AVG(valor) FROM cajas) AS Z);
DELETE FROM cajas WHERE valor<100;
DELETE FROM  cajas WHERE almacen = (SELECT * FROM (SELECT CODIGO FROM almacenes WHERE capacidad < (SELECT count(NUMREFERENCIA) FROM cajas WHERE almacen = CODIGO)) AS z);

-- Actividad 4
SELECT nombre FROM peliculas;
SELECT DISTINCT calificacionedad FROM peliculas;
SELECT * FROM peliculas WHERE calificacionedad IS NULL;
SELECT * FROM salas WHERE pelicula IS NULL;
SELECT * FROM salas LEFT JOIN peliculas ON salas.pelicula = peliculas.codigo;
SELECT * FROM salas RIGHT JOIN peliculas ON salas.pelicula = peliculas.codigo;
SELECT peliculas.nombre FROM salas RIGHT JOIN peliculas ON salas.pelicula = peliculas.codigo WHERE salas.pelicula IS NULL;
INSERT INTO peliculas VALUES (10, 'Uno, Dos, Tres', '+7');
UPDATE peliculas SET calificacionedad = 'no recomendables para menores de 13 años' WHERE calificacionedad IS NULL;
DELETE FROM salas WHERE pelicula IN (SELECT codigo FROM peliculas WHERE calificacionedad = 'G');  
