-- Delete old tables.

drop table if exists answer;
drop table if exists report;
drop table if exists member;

-- Create new tables.

create table member (
	id serial primary key,
	email varchar(30) unique not null,
	firstName varchar(30) not null,
    middleName varchar(30),
	lastName varchar(30) not null,
	password char(60) not null,
	type char(1) not null default 'L' check (type = 'L' or type = 'I' or type = 'T' or type = 'D'),
	iber integer,
	foreign key(iber) references member(id)
);

create table report (
	id serial primary key,
	creator integer not null,
	target integer not null,
	createdAt timestamp default timestamp 'now()' not null,
	updatedAt timestamp default timestamp 'now()' not null,
	comment text,
	foreign key(creator) references member(id),
	foreign key(target) references member(id)
);

create table answer (
	id serial primary key,
	report integer not null,
	indicator char(5) check(indicator ~ '^\d.\d.\d$'),
	rating boolean not null,
	comment text,
	foreign key(report) references report(id),
	unique (report, indicator)
);

-- Create dummy users.
-- All passwords are bcrypted with the value 'password'.

insert into member (email, firstName, lastName, password, type) values ('m.sluijk@asvo.nl', 'Marleen', 'Sluijk', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'T');
insert into member (email, firstName, lastName, password, type) values ('v.arents@asvo.nl', 'Vera', 'Arents', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'T');
insert into member (email, firstName, lastName, password, type) values ('e.lieverst@asvo.nl', 'Eric', 'Lieverst', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'I');
insert into member (email, firstName, lastName, password, type) values ('h.schrijer@asvo.nl', 'Harry', 'Schrijer', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'D');
insert into member (email, firstName, lastName, password, type, iber) values ('n.laan@asvo.nl', 'Nellie', 'Laan', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'L', 3);
insert into member (email, firstName, lastName, password, type, iber) values ('j.weggemans@asvo.nl', 'Julia', 'Weggemans', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'L', 3);
insert into member (email, firstName, lastName, password, type, iber) values ('g.niehof@asvo.nl', 'Gerdy', 'Niehof', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'L', 3);
insert into member (email, firstName, lastName, password, type, iber) values ('k.liess@asvo.nl', 'Katja', 'Liess', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'L', 3);

-- Create dummy quiz & answers.

insert into report(creator, target, comment) values(3, 6, 'Goed');
insert into answer(report, indicator, rating, comment) values(1, '1.1.1', true, 'Okey');
insert into answer(report, indicator, rating, comment) values(1, '1.1.2', false, 'Not okey.');
insert into answer(report, indicator, rating) values(1, '1.1.3', true);
insert into answer(report, indicator, rating, comment) values(1, '1.2.1', true, 'Okey');
insert into answer(report, indicator, rating) values(1, '3.3.2', false);
insert into answer(report, indicator, rating, comment) values(1, '4.1.2', true, 'Nono');

insert into report(creator, target, comment) values(3, 7, 'Slecht');
insert into answer(report, indicator, rating) values(2, '1.1.1', false);
insert into answer(report, indicator, rating, comment) values(2, '1.1.2', false, 'Not okey.');
insert into answer(report, indicator, rating) values(2, '1.1.3', true);
insert into answer(report, indicator, rating, comment) values(2, '1.2.2', false, 'Okey');
insert into answer(report, indicator, rating) values(2, '3.3.3', false);
insert into answer(report, indicator, rating, comment) values(2, '4.1.2', true, 'Nono');

insert into report(creator, target, comment) values(2, 6, 'Okey');
insert into answer(report, indicator, rating, comment) values(3, '1.1.2', false, 'Not okey.');
insert into answer(report, indicator, rating) values(3, '1.1.3', true);
insert into answer(report, indicator, rating) values(3, '1.2.1', false);
insert into answer(report, indicator, rating, comment) values(3, '1.2.2', false, 'Okey');
insert into answer(report, indicator, rating) values(3, '3.3.3', false);
insert into answer(report, indicator, rating, comment) values(3, '4.1.2', true, 'Nono');
insert into answer(report, indicator, rating) values(3, '5.3.1', true);
insert into answer(report, indicator, rating) values(3, '6.3.2', true);
insert into answer(report, indicator, rating, comment) values(3, '7.1.2', true, 'Prima');
