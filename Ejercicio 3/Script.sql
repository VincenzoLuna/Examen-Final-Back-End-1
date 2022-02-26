drop schema if exists Colegio;
create schema Colegio;

create table Colegio.Cursos(
	Nombre_Curso varchar(15) primary key,
    Descripcion_Curso varchar(70) not null,
    Precio_Curso int not null
);
insert into colegio.cursos value(
	'Historia','Nos enseña la historia en general',400
);
insert into colegio.cursos value(
	'Matemática','Nos enseña las matemáticas en general',500
);
insert into colegio.cursos value(
	'Ingles','Nos enseña el idioma más usado del mundo',300
);


create table Colegio.Profesores(
	Nombre_Profesor varchar(30) primary key,
    Descripcion_Profesor varchar(70) not null,
    Foto_Profesor blob
);
insert into colegio.profesores value(
	'Juan Gálvez','Profesor con maestría en España',''
);
insert into colegio.profesores value(
	'Henry Quispe','Ingeniero de la Universidad de Piura',''
);


create table Colegio.Alumnos(
	DNI char(8) primary key,
    Nombre_Alumno varchar(30) not null,
    Celular char(9) not null,
    Email varchar(45) not null
);
insert into colegio.alumnos value(
	'75960558','Vincenzo Luna','954107586','vincenzo.luna@gmail.com'
);
insert into colegio.alumnos value(
	'76890678','Henry Fernandez','967898056','henry.fernandez@gmail.com'
);




create table Colegio.Profesores_Cursos(
	Nombre_Profesor varchar(30) not null,
    Curso varchar(15) not null,
    foreign key (Nombre_Profesor) references colegio.Profesores(Nombre_Profesor) on delete cascade,
    foreign key (Curso) references colegio.Cursos(Nombre_Curso) on delete cascade
);
insert into colegio.profesores_cursos value(
	'Juan Gálvez','Historia'
);
insert into colegio.profesores_cursos value(
	'Henry Quispe','Historia'
);
insert into colegio.profesores_cursos value(
	'Henry Quispe','Matemática'
);
insert into colegio.profesores_cursos value(
	'Juan Gálvez','Matemática'
);
insert into colegio.profesores_cursos value(
	'Juan Gálvez','Ingles'
);




create table Colegio.Alumnos_Cursos(
	DNI char(8) not null,
    Curso varchar(15) not null,
    foreign key (DNI) references colegio.Alumnos(DNI) on delete cascade,
    foreign key (Curso) references colegio.Cursos(Nombre_Curso) on delete cascade
);
insert into colegio.alumnos_cursos value(
	'75960558','Ingles'
);
insert into colegio.alumnos_cursos value(
	'75960558','Matemática'
);
insert into colegio.alumnos_cursos value(
	'75960558','Historia'
);
insert into colegio.alumnos_cursos value(
	'76890678','Matemática'
);
insert into colegio.alumnos_cursos value(
	'76890678','Historia'
);


select * from colegio.cursos;
select * from colegio.profesores;
select * from colegio.alumnos;
select * from colegio.profesores_cursos;
select * from colegio.alumnos_cursos;


-- Pregunta 1
select * from colegio.alumnos_cursos where Curso = "Ingles";

-- Pregunta 2
select count(Nombre_Profesor) as conteo_profesores, 
colegio.profesores_cursos.Curso,
colegio.cursos.Descripcion_Curso,
colegio.cursos.Precio_Curso
from colegio.profesores_cursos
JOIN colegio.cursos
on colegio.profesores_cursos.Curso = colegio.cursos.Nombre_Curso
group by Curso
having conteo_profesores>1;

-- Pregunta 3
select count(Curso) as conteo_cursos,
colegio.alumnos_cursos.DNI,
colegio.alumnos.Nombre_Alumno,
colegio.alumnos.Celular,
colegio.alumnos.Email
from colegio.alumnos_cursos
JOIN colegio.alumnos
on colegio.alumnos_cursos.DNI = colegio.alumnos.DNI
group by DNI
having conteo_cursos>1;

-- Pregunta 4
select
colegio.alumnos_cursos.curso,
colegio.alumnos_cursos.DNI,
colegio.alumnos.Nombre_Alumno,
colegio.alumnos.Celular,
colegio.alumnos.Email
from colegio.alumnos_cursos
JOIN colegio.alumnos
on colegio.alumnos_cursos.DNI = colegio.alumnos.DNI
where Curso in ('Historia','Matemática');