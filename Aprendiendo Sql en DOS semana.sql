
--2 - Crear una tabla (create table - sp_tables - sp_columns - drop table)
 if object_id('usuarios') is not null
  drop table usuarios;

 create table usuarios (
  nombre varchar(30),
  clave varchar(10)
 );

 --go

--3 - Insertar y recuperar registros de una tabla (insert into - select)



---4 -Tipos de datos basicos en SQL
create table libros(
	titulo varchar(80),
	autor varchar(40),
	editorial varchar(30),
	precio float,
	cantidad integer
);

insert into libros(titulo, autor, editorial, precio, cantidad) values('Jonathan saca una A', 'El profe', 'La ucne', 2050.98, 1);

select * from libros;

--5 -Recuperar algunos campos 
go --Se utilisa para ejecutar un blique de cidugi en parte

select * from usuarios; --aqui se selecionaron todos los campos de usuario

select nombre from usuarios; --aqui solo se seleciono un campo de la tabla usuario

--6 -Recuuperar solo algunos reguistros 
select * from libros
	where titulo = 'Jonathan saca A'; --Aqui solo se recupero todos los titulos que sean iguales, se puede hacer con cualquier otro campo

--7 -Operadores relacionales

select * from libros	
	where titulo <> 'Jonathan saca A'; --se recura todo lo que sea diferente de eso

-- Seleccionamos los registros cuyo autor sea diferente de 'Borges'
select * from libros
  where autor<>'Borges';

-- Seleccionamos los registros cuyo precio supere los 20 pesos, sólo el título y precio
select titulo,precio
  from libros
  where precio>20;

-- Recuperamos aquellos libros cuyo precio es menor o igual a 30
select * from libros
  where precio<=30;

-- 8-Borrado de reguistro 

insert into usuarios (nombre,clave) values ('Marcelo','River');

insert into usuarios (nombre,clave) values ('Susana','chapita');

insert into usuarios (nombre,clave) values ('CarlosFuentes','Boca');

insert into usuarios (nombre,clave) values ('FedericoLopez','Boca');

select * from usuarios;

-- Eliminamos el registro cuyo nombre de usuario es "Marcelo"
delete from usuarios
   where nombre='Marcelo';

select * from usuarios;

-- Intentamos eliminarlo nuevamente (no se borra registro)
delete from usuarios
 where nombre='Marcelo';

select * from usuarios;

-- Eliminamos todos los registros cuya clave es 'Boca'
delete from usuarios
  where clave='Boca';

select * from usuarios;

-- Eliminemos todos los registros
delete from usuarios;

select * from usuarios;

-- 9- Reguistro Usuario

update usuarios set clave='payaso' --aqui se actualisa la calve en donde le nombre sea gual a ese texto
  where nombre='JuanaJuarez';

select * from usuarios;

update usuarios set nombre='Marceloduarte', clave='Marce' -- aqui cuando el nombre sea igual a Marcelo se va a cambiar a Marceloduarte y la clave a marce 
  where nombre='Marcelo';

select * from usuarios;

-- 10 -Comentarios

--insert into libros (titulo,autor,editorial)
/*  values ('El aleph','Borges','Emece');

select * from libros --mostramos los registros de libros; 

select titulo, autor 
 /*mostramos títulos y
 nombres de los autores*/
  from libros;
  3*/

  --Aqui todo esta comentado de diferentes manera, se puede optar por -- o por 

--11 -Valor null

select * from libros;

-- Recuperemos los registros que contengan el valor "null" en el campo "precio":
select * from libros
  where precio is null;

-- La sentencia anterior tendrá una salida diferente a la siguiente:
select * from libros
  where precio=0;

-- Recuperemos los libros cuyo nombre de editorial es "null":
 select * from libros
  where editorial is null;

-- Ahora veamos los libros cuya editorial almacena una cadena vacía:
 select * from libros
  where editorial=''; 

-- Para recuperar los libros cuyo precio no sea nulo tipeamos:
 select * from libros
  where precio is not null;



--12 -primary key

  create table usuarios2(
  nombre varchar(20),
  clave varchar(10),
  primary key(nombre)
);

go

exec sp_columns usuarios2;

insert into usuarios2 (nombre, clave)
  values ('juanperez','Boca');
insert into usuarios2 (nombre, clave)
  values ('raulgarcia','River');

--  Intentamos ingresar un valor de clave primaria existente (genera error):
/*insert into usuarios2 (nombre, clave)
  values ('juanperez','payaso');

-- Intentamos ingresar el valor "null" en el campo clave primaria (genera error):
insert into usuarios2 (nombre, clave)
  values (null,'payaso');

-- Intentemos actualizar el nombre de un usuario colocando un nombre existente (genera error):
update usuarios2 set nombre='juanperez'
  where nombre='raulgarcia';*/




--13 Identyti

go

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',23);

select * from libros;

insert into libros (titulo,autor,editorial,precio)
  values('Uno','Richard Bach','Planeta',18);
insert into libros (titulo,autor,editorial,precio)
  values('Aprenda PHP','Mario Molina','Siglo XXI',45.60);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de maravillas','Lewis Carroll','Paidos',15.50);

select * from libros;

exec sp_columns libros;

-- Eliminemos el último registro:
delete from libros
  where autor='Lewis Carroll';

-- Ingresamos un quinto registro
insert into libros (titulo, autor, editorial, precio)
  values('Martin Fierro','Jose Hernandez','Paidos',25); 

--  El campo código se guardó el valor secuencial sin considerar que el valor "4" ya no existe:
select * from libros;

-- Identity funciona para que un valor sea acendiente y comiense desde el ultimo numero o desde 1,
   --mayormente se utilisa con el primary key.






--14 Otras características del atributo Identity

create table libros(
  codigo int identity(100,2),
  titulo varchar(20),
  autor varchar(30),
  precio float
);
go

insert into libros (titulo,autor,precio)
  values('El aleph','Borges',23);
insert into libros (titulo,autor,precio)
  values('Uno','Richard Bach',18);
insert into libros (titulo,autor,precio)
  values('Aprenda PHP','Mario Molina',45.60);

select * from libros;

-- Para saber cuál es el valor de inicio del campo "identity" de la tabla "libros":
select ident_seed('libros');

-- Si intentamos ingresar un valor para el campo "codigo" (genera error):
insert into libros (codigo,titulo,autor,precio)
  values(106,'Martin Fierro','Jose Hernandez',25);

-- Para permitir ingresar un valor en un campo de identidad activamos la opción "identity_insert":
set identity_insert libros on;

-- Recordemos que si "identity_insert" está en ON, la instrucción "insert" DEBE explicitar un valor:
insert into libros (codigo,titulo,autor)
 values (100,'Matematica estas ahi','Paenza');

-- Note que ingresamos un valor de código que ya existe; esto está permitido porque
-- el atributo "identity" no implica unicidad.
insert into libros (codigo,titulo,autor)
 values (1,'Ilusiones','Richard Bach');

-- Si no se coloca un valor para el campo de identidad, 
-- la sentencia no se ejecuta y aparece un mensaje de error:
insert into libros (titulo,autor)
 values ('Uno','Richard Bach');

-- Para desactivar la opción "identity_insert" 
set identity_insert libros off;

-- Intentemos ingresar un valor para el campo "codigo" (genera error):
insert into libros (codigo,titulo,autor)
  values (300,'Uno','Richard Bach');
  
  --Aqui se le asigna un valor inicial (100) y se le dice de cuanto se va a aumentar, 
   -- en este caso aumenta de 2 en 2

--15 Truncate table

create table libros(
  codigo int identity,
  titulo varchar(30),
  autor varchar(20),
  editorial varchar(15),
  precio float
);

go

insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',25.60);
insert into libros (titulo,autor,editorial,precio)
  values ('Uno','Richard Bach','Planeta',18);

select * from libros;

-- Truncamos la tabla:
truncate table libros;

-- Ingresamos nuevamente algunos registros:
insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',25.60);
insert into libros (titulo,autor,editorial,precio)
  values ('Uno','Richard Bach','Planeta',18);

-- Si seleccionamos todos los registros vemos que la secuencia se reinició en 1:
select * from libros;

-- Eliminemos todos los registros con "delete":
delete from libros;

-- Ingresamos nuevamente algunos registros:
insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',25.60);
insert into libros (titulo,autor,editorial,precio)
  values ('Uno','Richard Bach','Planeta',18);

-- Seleccionamos todos los registros y vemos que la secuencia continuó:
select * from libros;

-- este elimina todo los datos d ela tabla y deja la estructura de la tabla intacta
-- a diferencia de el otro que borra los xatos pero si tienes un primary key continua en el numero donde se borro





--17 -Tipo de dato de texto

/*
Tenemos los siguientes tipos:

varchar(x): define una cadena de caracteres de longitud variable en la cual determinamos el máximo de caracteres con el argumento "x" que va entre paréntesis.
Si se omite el argumento coloca 1 por defecto. Su rango va de 1 a 8000 caracteres.
char(x): define una cadena de longitud fija determinada por el argumento "x". Si se omite el argumento coloca 1 por defecto. Su rango es de 1 a 8000 caracteres.
Si la longitud es invariable, es conveniente utilizar el tipo char; caso contrario, el tipo varchar.
Ocupa tantos bytes como se definen con el argumento "x".
"char" viene de character, que significa caracter en inglés.
text: guarda datos binarios de longitud variable, puede contener hasta 2000000000 caracteres. No admite argumento para especificar su longitud.
nvarchar(x): es similar a "varchar", excepto que permite almacenar caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
nchar(x): es similar a "char" excpeto que acepta caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
ntext: es similar a "text" excepto que permite almacenar caracteres Unicode, puede contener hasta 1000000000 caracteres. No admite argumento para especificar su longitud.
*/

if object_id('visitantes') is not null
  drop table visitantes;

/* Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" 
   algunos datos de las personas que visitan o compran en su stand para luego enviarle 
   publicidad de sus productos. */
create table visitantes(
  nombre varchar(30),
  edad integer,
  sexo char(1),
  domicilio varchar(30),
  ciudad varchar(20),
  telefono varchar(11)
);

go

-- Intentamos ingresar una cadena de mayor longitud que la definida 
-- en el campo sexo (se genera un error):
insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Juan Juarez',32,'m','Avellaneda 789','Cordoba','4234567');
  --aqui en sexo esta masculino, pero solo aepta 1 caracter y se dejara en m

-- Ingresamos un número telefónico olvidando las comillas, es decir, 
-- como un valor numérico (lo transforma a cadena):
insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Marcela Morales',43,'f','Colon 456','Cordoba',4567890);

select * from visitantes;




--18 -Tipo de dato (numérico)\

create table libros(
  codigo smallint identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(15),
  precio smallmoney,
  cantidad tinyint
);

go

-- Intentemos ingresar un valor fuera del rango definido, una cantidad 
-- que supera el rango del tipo "tinyint", el valor 260 (genera error):
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('El aleph','Borges','Emece',25.60,260);

-- Intentamos ingresar un precio que supera el rango del tipo "smallmoney",
-- el valor 250000 (genera error):
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('El aleph','Borges','Emece',250000,100);

-- Intentamos ingresar una cadena que SQL Server no pueda convertir a valor 
-- numérico en el campo "precio" (genera error):
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Uno','Richard Bach','Planeta','a50.30',100);

-- Ingresamos una cadena en el campo "cantidad" (lo convierte a valor numérico):
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Uno','Richard Bach','Planeta',50.30,'100');

select * from libros;





--19 -Tipo de dato (fecha y hora)

-- Seteamos el formato de la fecha para que guarde día, mes y año:
set dateformat dmy;

insert into empleados values('Ana Gomez','22222222','12-01-1980');
insert into empleados values('Bernardo Huerta','23333333','15-03-81');
insert into empleados values('Carla Juarez','24444444','20/05/1983');
insert into empleados values('Daniel Lopez','25555555','2.5.1990');

-- Note que el formato de visualización es "y-m-d".
select * from empleados;

-- Mostramos los datos de los empleados cuya fecha de ingreso es anterior a '01-01-1985':
select * from empleados where fechaingreso<'01-01-1985';

-- Actualizamos el nombre a "Maria Carla Juarez' 
-- del empleado cuya fecha de ingreso es igual a '20/05/1983':
update empleados set nombre='Maria Carla Juarez' where fechaingreso='20.5.83';

select * from empleados;

-- 20-Insertar

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(15)
);

go

-- Si ingresamos valores para todos los campos, podemos omitir la lista de campos:
insert into libros
  values ('Uno','Richard Bach','Planeta');

-- Podemos ingresar valores para algunos de los campos:
insert into libros (titulo, autor)
  values ('El aleph','Borges');

-- No podemos omitir el valor para un campo declarado "not null",
-- como el campo "titulo" (genera error):
insert into libros (autor,editorial)
  values ('Lewis Carroll','Planeta');

select * from libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) not null default 'Desconocido', 
  editorial varchar(20),
  precio decimal(5,2),
  cantidad tinyint default 0
);

go

-- Ingresamos un registro omitiendo los valores para el campo "autor" y "cantidad":
insert into libros (titulo,editorial,precio)
  values('Java en 10 minutos','Paidos',50.40);

select * from libros;

-- Si ingresamos un registro sin valor para el campo "precio", 
-- que admite valores nulos, se ingresará "null" en ese campo:
insert into libros (titulo,editorial)
  values('Aprenda PHP','Siglo XXI');

select * from libros;

-- Visualicemos la estructura de la tabla:
exec sp_columns libros;

-- Podemos emplear "default" para dar el valor por defecto a algunos campos:
insert into libros (titulo,autor,precio,cantidad)
  values ('El gato con botas',default,default,100);

select * from libros;

-- Como todos los campos de "libros" tienen valores predeterminados, podemos tipear:
insert into libros default values;

select * from libros;

-- Podemos ingresar el valor "null" en el campo "cantidad":
insert into libros (titulo,autor,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll',null);













--21 -Ingresar algunos campos (insert into) 
create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) not null default 'Desconocido', 
  editorial varchar(20),
  precio decimal(5,2),
  cantidad tinyint default 0
);

go

-- Ingresamos un registro omitiendo los valores para el campo "autor" y "cantidad":
insert into libros (titulo,editorial,precio)
  values('Java en 10 minutos','Paidos',50.40);

select * from libros;

-- Si ingresamos un registro sin valor para el campo "precio", 
-- que admite valores nulos, se ingresará "null" en ese campo:
insert into libros (titulo,editorial)
  values('Aprenda PHP','Siglo XXI');

select * from libros;

-- Visualicemos la estructura de la tabla:
exec sp_columns libros;

-- Podemos emplear "default" para dar el valor por defecto a algunos campos:
insert into libros (titulo,autor,precio,cantidad)
  values ('El gato con botas',default,default,100);

select * from libros;

-- Como todos los campos de "libros" tienen valores predeterminados, podemos tipear:
insert into libros default values;

select * from libros;

-- Podemos ingresar el valor "null" en el campo "cantidad":
insert into libros (titulo,autor,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll',null);

  












  -- 22-Columnas calculadas (operadores aritméticos y de concatenación)
  create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  cantidad tinyint default 0,
  primary key (codigo)
);

go

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25);
insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

-- Queremos saber el monto total en dinero de cada libro: 
select titulo, precio,cantidad,
  precio*cantidad
  from libros;

-- Conocer el precio de cada libro con un 10% de descuento:
select titulo,precio,
  precio-(precio*0.1)
  from libros;

-- Actualizar los precios con un 10% de descuento:
update libros set precio=precio-(precio*0.1);

select * from libros;

-- Queremos una columna con el título, el autor y la editorial de cada libro:
select titulo+'-'+autor+'-'+editorial
  from libros;


  -- simbolos matematicas




  --23 -Alias


  go

insert into agenda
  values('Juan Perez','Avellaneda 908','4252525');
insert into agenda
  values('Marta Lopez','Sucre 34','4556688');
insert into agenda
  values('Carlos Garcia','Sarmiento 1258',null);

select nombre as NombreYApellido,
  domicilio,telefono
  from agenda;

select nombre as 'Nombre y apellido',
  domicilio,telefono
  from agenda;

select nombre 'Nombre y apellido',
  domicilio,telefono
  from agenda;


  --aplicando a alias a las colunnas






  --25 -Funciones para el manejo de cadenas

  go

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25);
insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

-- Mostramos sólo los 12 primeros caracteres de los títulos de los libros y
-- sus autores, empleando la función "substring()":
select substring(titulo,1,12) as titulo
  from libros;

-- Mostramos sólo los 12 primeros caracteres de los títulos de los libros y
-- sus autores, ahora empleando la función "left()":
select left(titulo,12) as titulo
  from libros;

-- Mostramos los títulos de los libros y sus precios convirtiendo este último a cadena
-- de caracteres con un solo decimal, empleando la función "str":
select titulo,
  str(precio,6,1)
  from libros;

-- Mostramos los títulos de los libros y sus precios convirtiendo este último a cadena
-- de caracteres especificando un solo argumento:
select titulo,
  str(precio)
  from libros;

-- Mostramos los títulos, autores y editoriales de todos libros, al último
-- campo lo queremos en mayúsculas:
select titulo, autor, upper(editorial)
   from libros;


   --26 - Funciones matematicas

 -abs(x): retorna el valor absoluto del argumento "x".
select abs(-20);

 -ceiling(x): redondea hacia arriba el argumento "x".
 select ceiling(12.34);

 -floor(x): redondea hacia abajo el argumento "x". Ejemplo:

 select floor(12.34);
retorna 12.

- %: %: devuelve el resto de una división. Ejemplos:

 select 10%3;
retorna 1.

 select 10%2;
retorna 0.

-power(x,y): retorna el valor de "x" elevado a la "y" potencia. Ejemplo:

 select power(2,3);
retorna 8.

-round(numero,longitud): --retorna un número redondeado a la longitud especificada. "longitud" debe ser tinyint, 
--smallint o int. Si "longitud" es positivo, el número de decimales es redondeado según "longitud"; 
--si es negativo, el número es redondeado desde la parte entera según el valor de "longitud". Ejemplos:

 select round(123.456,1);
retorna "123.400", es decir, redondea desde el primer decimal.

 select round(123.456,2);
retorna "123.460", es decir, redondea desde el segundo decimal.

 select round(123.456,-1);
retorna "120.000", es decir, redondea desde el primer valor entero (hacia la izquierda).

 select round(123.456,-2);
retorna "100.000", es decir, redondea desde el segundo valor entero (hacia la izquierda).

-sign(x): si el argumento es un valor positivo devuelve 1;-1 si es negativo y si es 0, 0.

-square(x): retorna el cuadrado del argumento. Ejemplo:

 select square(3); retorna 9.
-srqt(x): devuelve la raiz cuadrada del valor enviado como argumento.