-- Delete old tables.

drop table if exists answer;
drop table if exists report;
drop table if exists indicator;
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

create table indicator (
	id char(5) primary key check(id ~ '^\d.\d.\d$'),
	section text not null,
	subsection text not null,
	question text not null
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
	indicator char(5),
	rating boolean not null,
	comment text,
	foreign key(report) references report(id),
	foreign key(indicator) references indicator(id),
	unique (report, indicator)
);

-- Create dummy users.
-- All passwords are bcrypted with the value 'password'.

insert into member(email, firstName, lastName, password, type) values('m.sluijk@asvo.nl', 'Marleen', 'Sluijk', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'T');
insert into member(email, firstName, lastName, password, type) values('v.arents@asvo.nl', 'Vera', 'Arents', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'T');
insert into member(email, firstName, lastName, password, type) values('e.lieverst@asvo.nl', 'Eric', 'Lieverst', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'I');
insert into member(email, firstName, lastName, password, type) values('h.schrijer@asvo.nl', 'Harry', 'Schrijer', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'D');
insert into member(email, firstName, lastName, password, type, iber) values('n.laan@asvo.nl', 'Nellie', 'Laan', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'L', 3);
insert into member(email, firstName, lastName, password, type, iber) values('j.weggemans@asvo.nl', 'Julia', 'Weggemans', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'L', 3);
insert into member(email, firstName, lastName, password, type, iber) values('g.niehof@asvo.nl', 'Gerdy', 'Niehof', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'L', 3);
insert into member(email, firstName, lastName, password, type, iber) values('k.liess@asvo.nl', 'Katja', 'Liess', '$2a$10$eH8O3Sbh6B4OMTC6mkpRJOHIEUGulHNb/8rBteqnmCVVSZZFjvTzS', 'L', 3);

-- Create indicators

insert into indicator(id, section, subsection, question) values('1.1.1', 'Pedagogisch handelen', 'Zorgt voor een ontspannen sfeer', 'Spreekt leerlingen op een positieve manier aan');
insert into indicator(id, section, subsection, question) values('1.1.2', 'Pedagogisch handelen', 'Zorgt voor een ontspannen sfeer', 'Accepteert dat leerlingen fouten maken');
insert into indicator(id, section, subsection, question) values('1.1.3', 'Pedagogisch handelen', 'Zorgt voor een ontspannen sfeer', 'Maakt zodanig contact met leerlingen dat zij zich op hun gemak voelen');

insert into indicator(id, section, subsection, question) values('1.2.1', 'Pedagogisch handelen', 'Zorgt voor veiligheid', 'Maakt de sfeer in de groep en de omgang met elkaar zonodig bespreekbaar');
insert into indicator(id, section, subsection, question) values('1.2.2', 'Pedagogisch handelen', 'Zorgt voor veiligheid', 'Treedt op wanneer er om leerlingen wordt gelachen');
insert into indicator(id, section, subsection, question) values('1.2.3', 'Pedagogisch handelen', 'Zorgt voor veiligheid', 'Bevordert solidariteit tussen leerlingen');
insert into indicator(id, section, subsection, question) values('1.2.4', 'Pedagogisch handelen', 'Zorgt voor veiligheid', 'Voorkomt pestgedrag en reageert adequaat wanneer zich dat voordoet');
insert into indicator(id, section, subsection, question) values('1.2.5', 'Pedagogisch handelen', 'Zorgt voor veiligheid', 'Houdt rekening met (culturele) verschillen en eigenaardigheden');

insert into indicator(id, section, subsection, question) values('1.3.1', 'Pedagogisch handelen', 'Toont en bevordert respect voor leerlingen', 'Laat leerlingen uitspreken');
insert into indicator(id, section, subsection, question) values('1.3.2', 'Pedagogisch handelen', 'Toont en bevordert respect voor leerlingen', 'Honoreert de inbreng van leerlingen');
insert into indicator(id, section, subsection, question) values('1.3.3', 'Pedagogisch handelen', 'Toont en bevordert respect voor leerlingen', 'Luistert naar wat leerlingen te zeggen hebben');
insert into indicator(id, section, subsection, question) values('1.3.4', 'Pedagogisch handelen', 'Toont en bevordert respect voor leerlingen', 'Stimuleert leerlingen naar elkaar te luisteren');
insert into indicator(id, section, subsection, question) values('1.3.5', 'Pedagogisch handelen', 'Toont en bevordert respect voor leerlingen', 'Bevordert dat leerlingen interesse tonen in elkaar');
insert into indicator(id, section, subsection, question) values('1.3.6', 'Pedagogisch handelen', 'Toont en bevordert respect voor leerlingen', 'Vermijdt rolbevestigende opmerkingen');
insert into indicator(id, section, subsection, question) values('1.3.7', 'Pedagogisch handelen', 'Toont en bevordert respect voor leerlingen', 'Vormt zelf voorbeeld/rolmodel van respectvolle benadering');

insert into indicator(id, section, subsection, question) values('1.4.1', 'Pedagogisch handelen', 'Ondersteunt het zelfvertrouwen van leerlingen', 'Koppelt vragen en opmerkingen van leerlingen op een positieve manier terug');
insert into indicator(id, section, subsection, question) values('1.4.2', 'Pedagogisch handelen', 'Ondersteunt het zelfvertrouwen van leerlingen', 'Maakt duidelijk bijdragen van leerlingen waardevol te vinden');

insert into indicator(id, section, subsection, question) values('1.5.1', 'Pedagogisch handelen', 'Geeft expliciet blijk van hoge verwachtingen', 'Spreekt positieve verwachtingen uit naar leerlingen over wat zij aankunnen');
insert into indicator(id, section, subsection, question) values('1.5.2', 'Pedagogisch handelen', 'Geeft expliciet blijk van hoge verwachtingen', 'Geeft er blijk van te weten wat hij/zij van leerlingen kan verwachten');
insert into indicator(id, section, subsection, question) values('1.5.3', 'Pedagogisch handelen', 'Geeft expliciet blijk van hoge verwachtingen', 'Is duidelijk voor leerlingen over wat de verwachtingen zijn');
insert into indicator(id, section, subsection, question) values('1.5.4', 'Pedagogisch handelen', 'Geeft expliciet blijk van hoge verwachtingen', 'Bevestigt als leerlingen verwachtingen waarmaken');
insert into indicator(id, section, subsection, question) values('1.5.5', 'Pedagogisch handelen', 'Geeft expliciet blijk van hoge verwachtingen', 'Bemoedigt als leerlingen verwachtingen niet waarmaken');

insert into indicator(id, section, subsection, question) values('1.6.1', 'Pedagogisch handelen', 'Richt een leeromgeving in die uitdagend en rijk is', 'Zorgt voor ondersteunende en stimulerende materialen voor (methodisch) taalleesonderwijs');
insert into indicator(id, section, subsection, question) values('1.6.2', 'Pedagogisch handelen', 'Richt een leeromgeving in die uitdagend en rijk is', 'Zorgt voor ondersteunende en stimulerende materialen voor (methodisch) reken- en wiskundeonderwijs');
insert into indicator(id, section, subsection, question) values('1.6.3', 'Pedagogisch handelen', 'Richt een leeromgeving in die uitdagend en rijk is', 'Zorgt voor ondersteunende en stimulerende materialen voor verkennen van de wereld');
insert into indicator(id, section, subsection, question) values('1.6.4', 'Pedagogisch handelen', 'Richt een leeromgeving in die uitdagend en rijk is', 'Zorgt voor een taalleeromgeving die de taalontwikkeling van leerlingen stimuleert');
insert into indicator(id, section, subsection, question) values('1.6.5', 'Pedagogisch handelen', 'Richt een leeromgeving in die uitdagend en rijk is', 'OB: Zorgt voor hoeken en materialen voor stimuleren geletterdheid en gecijferdheid');
insert into indicator(id, section, subsection, question) values('1.6.6', 'Pedagogisch handelen', 'Richt een leeromgeving in die uitdagend en rijk is', 'OB: Speel- en werkhoeken zijn thematisch ingericht');
insert into indicator(id, section, subsection, question) values('1.6.7', 'Pedagogisch handelen', 'Richt een leeromgeving in die uitdagend en rijk is', 'Zorgt voor adequate en stimulerende soft- en hardware');
insert into indicator(id, section, subsection, question) values('1.6.8', 'Pedagogisch handelen', 'Richt een leeromgeving in die uitdagend en rijk is', 'De leeromgeving sluit aan bij de actualiteit van de groep');
insert into indicator(id, section, subsection, question) values('1.6.9', 'Pedagogisch handelen', 'Richt een leeromgeving in die uitdagend en rijk is', 'Maakt leerlingen nieuwsgierig en overtuigt hen van relevantie van leerinhouden');

insert into indicator(id, section, subsection, question) values('1.7.1', 'Pedagogisch handelen', 'Beschikt over pedagogisch repertoire voor passende interventies', 'Maakt weloverwogen gebruik complimenten en correcties');
insert into indicator(id, section, subsection, question) values('1.7.2', 'Pedagogisch handelen', 'Beschikt over pedagogisch repertoire voor passende interventies', 'Anticipeert op gedrag van leerlingen');
insert into indicator(id, section, subsection, question) values('1.7.3', 'Pedagogisch handelen', 'Beschikt over pedagogisch repertoire voor passende interventies', 'Spreekt leerlingen aan op ongewenst gedrag en stimuleert gewenst gedrag');
insert into indicator(id, section, subsection, question) values('1.7.4', 'Pedagogisch handelen', 'Beschikt over pedagogisch repertoire voor passende interventies', 'Hanteert gedrags- en omgangsregels redelijk en consequent');
insert into indicator(id, section, subsection, question) values('1.7.5', 'Pedagogisch handelen', 'Beschikt over pedagogisch repertoire voor passende interventies', 'Regels zijn duidelijk en zichtbaar voor leerlingen');
insert into indicator(id, section, subsection, question) values('1.7.6', 'Pedagogisch handelen', 'Beschikt over pedagogisch repertoire voor passende interventies', 'Regels zijn functioneel voor leerlingen');

insert into indicator(id, section, subsection, question) values('2.1.1', 'Effectief benutten onderwijstijd (‘time on task’)', 'De leraar begint op tijd met de les', 'Stimuleert leerlingen op tijd te beginnen');
insert into indicator(id, section, subsection, question) values('2.1.2', 'Effectief benutten onderwijstijd (‘time on task’)', 'De leraar begint op tijd met de les', 'Handhaaft schoolregels over op tijd beginnen');
insert into indicator(id, section, subsection, question) values('2.1.3', 'Effectief benutten onderwijstijd (‘time on task’)', 'De leraar begint op tijd met de les', 'Spreekt ouders/verzorgers die leerlingen te laat brengen daarop aan');
insert into indicator(id, section, subsection, question) values('2.1.4', 'Effectief benutten onderwijstijd (‘time on task’)', 'De leraar begint op tijd met de les', 'Spreekt leerlingen die te laat komen daarop aan');

insert into indicator(id, section, subsection, question) values('2.2.1', 'Effectief benutten onderwijstijd (‘time on task’)', 'Besteedt de geplande tijd daadwerkelijk aan het lesdoel', 'Laat geen tijd verloren gaan tijdens de les');
insert into indicator(id, section, subsection, question) values('2.2.2', 'Effectief benutten onderwijstijd (‘time on task’)', 'Besteedt de geplande tijd daadwerkelijk aan het lesdoel', 'Laat geen ‘dode’ momenten ontstaan');
insert into indicator(id, section, subsection, question) values('2.2.3', 'Effectief benutten onderwijstijd (‘time on task’)', 'Besteedt de geplande tijd daadwerkelijk aan het lesdoel', 'Laat de leerlingen niet wachten');
insert into indicator(id, section, subsection, question) values('2.2.4', 'Effectief benutten onderwijstijd (‘time on task’)', 'Besteedt de geplande tijd daadwerkelijk aan het lesdoel', 'Laat zich niet afleiden door irrelevante zaken of gebeurtenissen');
insert into indicator(id, section, subsection, question) values('2.2.5', 'Effectief benutten onderwijstijd (‘time on task’)', 'Besteedt de geplande tijd daadwerkelijk aan het lesdoel', 'Houdt zelf lestijd en lesdoel in de gaten');

insert into indicator(id, section, subsection, question) values('2.3.1', 'Effectief benutten onderwijstijd (‘time on task’)', 'Laat de les verlopen volgens een adequate planning', 'Heeft de les gepland');
insert into indicator(id, section, subsection, question) values('2.3.2', 'Effectief benutten onderwijstijd (‘time on task’)', 'Laat de les verlopen volgens een adequate planning', 'De planning van de les stemt overeen met de doelen');
insert into indicator(id, section, subsection, question) values('2.3.3', 'Effectief benutten onderwijstijd (‘time on task’)', 'Laat de les verlopen volgens een adequate planning', 'Stimuleert leerlingen door te werken');
insert into indicator(id, section, subsection, question) values('2.3.4', 'Effectief benutten onderwijstijd (‘time on task’)', 'Laat de les verlopen volgens een adequate planning', 'Voorkomt irrelevante uitweidingen');
insert into indicator(id, section, subsection, question) values('2.3.5', 'Effectief benutten onderwijstijd (‘time on task’)', 'Laat de les verlopen volgens een adequate planning', 'De afwisseling in instructie en begeleiding in de groep(en) is evenwichtig');
insert into indicator(id, section, subsection, question) values('2.3.6', 'Effectief benutten onderwijstijd (‘time on task’)', 'Laat de les verlopen volgens een adequate planning', 'Zorgt in combinatiegroepen dat de instructie evenwichtig is verdeeld over beide groepen');
insert into indicator(id, section, subsection, question) values('2.3.7', 'Effectief benutten onderwijstijd (‘time on task’)', 'Laat de les verlopen volgens een adequate planning', 'Zorgt dat leerlingen weten aan welke opdracht /taak zij moeten werken');
insert into indicator(id, section, subsection, question) values('2.3.8', 'Effectief benutten onderwijstijd (‘time on task’)', 'Laat de les verlopen volgens een adequate planning', 'Zorgt dat leerlingen weten hoeveel tijd ze hebben voor taken');
insert into indicator(id, section, subsection, question) values('2.3.9', 'Effectief benutten onderwijstijd (‘time on task’)', 'Laat de les verlopen volgens een adequate planning', 'Zorgt voor relevante opdrachten als leerlingen minder dan de geplande tijd nodig hebben');

insert into indicator(id, section, subsection, question) values('3.1.1', 'Taakgerichte werksfeer', 'Zorgt voor een ordelijk verloop van de les', 'Het in- en uitgaan van de klas verloopt ordelijk');
insert into indicator(id, section, subsection, question) values('3.1.2', 'Taakgerichte werksfeer', 'Zorgt voor een ordelijk verloop van de les', 'Treedt tijdig en passend op bij ordeverstoringen');
insert into indicator(id, section, subsection, question) values('3.1.3', 'Taakgerichte werksfeer', 'Zorgt voor een ordelijk verloop van de les', 'Houdt overzicht over de groep');
insert into indicator(id, section, subsection, question) values('3.1.4', 'Taakgerichte werksfeer', 'Zorgt voor een ordelijk verloop van de les', 'Heeft overwicht op de groep');

insert into indicator(id, section, subsection, question) values('3.2.1', 'Taakgerichte werksfeer', 'Zorgt voor een doelmatig klassenmanagement', 'Maakt duidelijk welke materialen kunnen worden gebruikt');
insert into indicator(id, section, subsection, question) values('3.2.2', 'Taakgerichte werksfeer', 'Zorgt voor een doelmatig klassenmanagement', 'De lesmaterialen liggen klaar');
insert into indicator(id, section, subsection, question) values('3.2.3', 'Taakgerichte werksfeer', 'Zorgt voor een doelmatig klassenmanagement', 'De lesmaterialen zijn ordelijk en toegankelijk georganiseerd in het lokaal');
insert into indicator(id, section, subsection, question) values('3.2.4', 'Taakgerichte werksfeer', 'Zorgt voor een doelmatig klassenmanagement', 'De lesmaterialen zijn afgestemd op het niveau en de ontwikkeling van de leerlingen');
insert into indicator(id, section, subsection, question) values('3.2.5', 'Taakgerichte werksfeer', 'Zorgt voor een doelmatig klassenmanagement', 'Hanteert een organisatie die het mogelijk maakt aandacht te schenken aan individuele leerlingen of groepjes leerlingen');

insert into indicator(id, section, subsection, question) values('3.3.1', 'Taakgerichte werksfeer', 'Maakt de gewenste leerhouding duidelijk', 'Zorgt dat de leerlingen weten of ze een beroep op de leraar mogen doen');
insert into indicator(id, section, subsection, question) values('3.3.2', 'Taakgerichte werksfeer', 'Maakt de gewenste leerhouding duidelijk', 'Zorgt dat de leerlingen weten of ze met andere leerlingen mogen overleggen');
insert into indicator(id, section, subsection, question) values('3.3.3', 'Taakgerichte werksfeer', 'Maakt de gewenste leerhouding duidelijk', 'Zorgt dat de leerlingen weten of een actieve inbreng gewenst is');

insert into indicator(id, section, subsection, question) values('3.4.1', 'Taakgerichte werksfeer', 'Voert een inzichtelijke en overdraagbare groepsadministratie', 'De groepsadministratie bevat een jaarplanning van de leerstof en het gerealiseerde leerstofaanbod van het moment (onderbouw beredeneerd en gerealiseerd)');
insert into indicator(id, section, subsection, question) values('3.4.2', 'Taakgerichte werksfeer', 'Voert een inzichtelijke en overdraagbare groepsadministratie', 'De groepsadministratie bevat op een toegankelijke manier leerlingengegevens');
insert into indicator(id, section, subsection, question) values('3.4.3', 'Taakgerichte werksfeer', 'Voert een inzichtelijke en overdraagbare groepsadministratie', 'De gegevens over klassenorganisatie, vorderingen van leerlingen en zorg aan leerlingen zijn toegankelijk en overdraagbaar');

insert into indicator(id, section, subsection, question) values('4.1.1', 'Activerende directe instructie', 'Maakt duidelijk hoe de les aansluit aan bij voorgaande lessen', 'Bespreekt het voorgaande werk m.b.t. hetzelfde onderwerp');
insert into indicator(id, section, subsection, question) values('4.1.2', 'Activerende directe instructie', 'Maakt duidelijk hoe de les aansluit aan bij voorgaande lessen', 'Haalt relevante voorkennis op en vat deze samen');
insert into indicator(id, section, subsection, question) values('4.1.3', 'Activerende directe instructie', 'Maakt duidelijk hoe de les aansluit aan bij voorgaande lessen', 'Vermeldt hoe de les aansluit bij wat voorafgegaan is');
insert into indicator(id, section, subsection, question) values('4.1.4', 'Activerende directe instructie', 'Maakt duidelijk hoe de les aansluit aan bij voorgaande lessen', 'Noteert voorkennis op het bord (‘Wat weten we al?’)');

insert into indicator(id, section, subsection, question) values('4.2.1', 'Activerende directe instructie', 'Verduidelijkt bij aanvang van de les de lesdoelen', 'Informeert de leerlingen bij de aanvang van de les over de lesdoelen');
insert into indicator(id, section, subsection, question) values('4.2.2', 'Activerende directe instructie', 'Verduidelijkt bij aanvang van de les de lesdoelen', 'Noteert de lesdoelen op het bord (‘Wat gaan we leren?’)');
insert into indicator(id, section, subsection, question) values('4.2.3', 'Activerende directe instructie', 'Verduidelijkt bij aanvang van de les de lesdoelen', 'Maakt duidelijk wat het doel van de opdrachten is en wat de leerlingen ervan zullen leren');

insert into indicator(id, section, subsection, question) values('4.3.1', 'Activerende directe instructie', 'Maakt voor leerlingen de opbouw van de les inzichtelijk', 'Zorgt voor duidelijk herkenbare componenten in de les (bijv. uitleg, begeleid inoefenen, zelfstandig verwerken)');
insert into indicator(id, section, subsection, question) values('4.3.2', 'Activerende directe instructie', 'Maakt voor leerlingen de opbouw van de les inzichtelijk', 'Maakt aan kinderen duidelijk volgens welke stappen de les gaat verlopen');
insert into indicator(id, section, subsection, question) values('4.3.3', 'Activerende directe instructie', 'Maakt voor leerlingen de opbouw van de les inzichtelijk', 'Maakt bij iedere nieuwe stap in de les duidelijk hoe deze past in het totaal');

insert into indicator(id, section, subsection, question) values('4.4.1', 'Activerende directe instructie', 'Geeft duidelijke uitleg van de leerstof en opdrachten', 'Legt uit in opeenvolgende stappen');
insert into indicator(id, section, subsection, question) values('4.4.2', 'Activerende directe instructie', 'Geeft duidelijke uitleg van de leerstof en opdrachten', 'Stelt vragen die door leerlingen worden begrepen');
insert into indicator(id, section, subsection, question) values('4.4.3', 'Activerende directe instructie', 'Geeft duidelijke uitleg van de leerstof en opdrachten', 'Vat van tijd tot tijd de leerstof samen');
insert into indicator(id, section, subsection, question) values('4.4.4', 'Activerende directe instructie', 'Geeft duidelijke uitleg van de leerstof en opdrachten', 'Zorgt voor aanschouwelijke en ondersteunende middelen die leerdoelen ondersteunen');
insert into indicator(id, section, subsection, question) values('4.4.5', 'Activerende directe instructie', 'Geeft duidelijke uitleg van de leerstof en opdrachten', 'Geeft blijk van beheersing vakinhoud van de les');
insert into indicator(id, section, subsection, question) values('4.4.6', 'Activerende directe instructie', 'Geeft duidelijke uitleg van de leerstof en opdrachten', 'Geeft blijk van kennis didactische opbouw van de leerinhouden');

insert into indicator(id, section, subsection, question) values('4.5.1', 'Activerende directe instructie', 'Geeft duidelijke uitleg van het gebruik van didactische hulpmiddelen', 'Zorgt dat elke leerling weet wat hij/zij moet doen');
insert into indicator(id, section, subsection, question) values('4.5.2', 'Activerende directe instructie', 'Geeft duidelijke uitleg van het gebruik van didactische hulpmiddelen', 'Maakt duidelijk welke materialen en didactische hulpmiddelen gebruikt kunnen worden');

insert into indicator(id, section, subsection, question) values('4.6.1', 'Activerende directe instructie', 'Betrekt alle leerlingen bij de les', 'Geeft opdrachten die leerlingen aanzetten tot actieve deelname');
insert into indicator(id, section, subsection, question) values('4.6.2', 'Activerende directe instructie', 'Betrekt alle leerlingen bij de les', 'Stelt vragen die leerlingen aanzetten tot nadenken');
insert into indicator(id, section, subsection, question) values('4.6.3', 'Activerende directe instructie', 'Betrekt alle leerlingen bij de les', 'Zorgt ervoor dat leerlingen tijdens de instructie goed luisteren en tijdens de verwerking doorwerken');
insert into indicator(id, section, subsection, question) values('4.6.4', 'Activerende directe instructie', 'Betrekt alle leerlingen bij de les', 'Wacht na het stellen van vragen voldoende lang om leerlingen te laten nadenken');
insert into indicator(id, section, subsection, question) values('4.6.5', 'Activerende directe instructie', 'Betrekt alle leerlingen bij de les', 'Geeft ook leerlingen de beurt die niet hun hand opsteken');

insert into indicator(id, section, subsection, question) values('4.7.1', 'Activerende directe instructie', 'Hanteert bij uitleg werkvormen die leerlingen activeren', 'Maakt gebruik van gespreks- en discussievormen');
insert into indicator(id, section, subsection, question) values('4.7.2', 'Activerende directe instructie', 'Hanteert bij uitleg werkvormen die leerlingen activeren', 'Zorgt voor geleide (in)oefening');
insert into indicator(id, section, subsection, question) values('4.7.3', 'Activerende directe instructie', 'Hanteert bij uitleg werkvormen die leerlingen activeren', 'Laat leerlingen in groepen/hoeken werken');
insert into indicator(id, section, subsection, question) values('4.7.4', 'Activerende directe instructie', 'Hanteert bij uitleg werkvormen die leerlingen activeren', 'Maakt gebruik van ICT');

insert into indicator(id, section, subsection, question) values('4.8.1', 'Activerende directe instructie', 'Geeft feedback aan leerlingen', 'Gaat tijdens de instructie na of leerlingen de leerstof hebben begrepen');
insert into indicator(id, section, subsection, question) values('4.8.2', 'Activerende directe instructie', 'Geeft feedback aan leerlingen', 'Gaat tijdens de verwerking na of leerlingen de opdrachten op een juiste manier uitvoeren');
insert into indicator(id, section, subsection, question) values('4.8.3', 'Activerende directe instructie', 'Geeft feedback aan leerlingen', 'Refereert bij feedback expliciet aan de doelen');
insert into indicator(id, section, subsection, question) values('4.8.4', 'Activerende directe instructie', 'Geeft feedback aan leerlingen', 'Refereert bij feedback expliciet aan de fasering van de les of van de opdracht');
insert into indicator(id, section, subsection, question) values('4.8.5', 'Activerende directe instructie', 'Geeft feedback aan leerlingen', 'Geeft feedback op de wijze waarop leerlingen tot hun antwoord komen');
insert into indicator(id, section, subsection, question) values('4.8.6', 'Activerende directe instructie', 'Geeft feedback aan leerlingen', 'Geeft feedback op het sociaal functioneren bij de uitgevoerde taak (groepsgebeuren)');

insert into indicator(id, section, subsection, question) values('4.9.1', 'Activerende directe instructie', 'Gaat na of de lesdoelen bereikt zijn', 'Laat de leerlingen vertellen wat ze geleerd hebben');
insert into indicator(id, section, subsection, question) values('4.9.2', 'Activerende directe instructie', 'Gaat na of de lesdoelen bereikt zijn', 'Vat samen (op het bord) wat kinderen hebben geleerd');
insert into indicator(id, section, subsection, question) values('4.9.3', 'Activerende directe instructie', 'Gaat na of de lesdoelen bereikt zijn', 'Grijpt expliciet terug op doelen');
insert into indicator(id, section, subsection, question) values('4.9.4', 'Activerende directe instructie', 'Gaat na of de lesdoelen bereikt zijn', 'Laat ze vertellen wat goed ging, wat niet goed ging en wat ze de volgende keer anders gaan doen');
insert into indicator(id, section, subsection, question) values('4.9.5', 'Activerende directe instructie', 'Gaat na of de lesdoelen bereikt zijn', 'Gaat na wat de prestaties van de leerlingen zijn');

insert into indicator(id, section, subsection, question) values('5.1.1', 'Strategieën voor denken en leren', 'Stimuleert reflectie door middel van interactieve instructie- en werkvormen', 'Is niet alleen zelf aan het woord maar stimuleert reflectie door middel van interactie met leerlingen');
insert into indicator(id, section, subsection, question) values('5.1.2', 'Strategieën voor denken en leren', 'Stimuleert reflectie door middel van interactieve instructie- en werkvormen', 'Zorgt voor werkvormen waarbij interactie tussen leerlingen leidt tot reflectie');

insert into indicator(id, section, subsection, question) values('5.2.1', 'Strategieën voor denken en leren', 'Laat leerlingen hardop denken', 'Geeft leerlingen de gelegenheid hardop oplossingen te bedenken');
insert into indicator(id, section, subsection, question) values('5.2.2', 'Strategieën voor denken en leren', 'Laat leerlingen hardop denken', 'Vraagt leerlingen oplossingen te verbaliseren');

insert into indicator(id, section, subsection, question) values('5.3.1', 'Strategieën voor denken en leren', 'Leert leerlingen strategieën voor denken en leren', 'Leert leerlingen oplossingsmethodieken (algoritme, analogie, regeltoepassing)');
insert into indicator(id, section, subsection, question) values('5.3.2', 'Strategieën voor denken en leren', 'Leert leerlingen strategieën voor denken en leren', 'Leert leerlingen het gebruik van ordeningsmiddelen aan');
insert into indicator(id, section, subsection, question) values('5.3.3', 'Strategieën voor denken en leren', 'Leert leerlingen strategieën voor denken en leren', 'Geeft leerlingen aanwijzingen voor het oplossen van problemen');
insert into indicator(id, section, subsection, question) values('5.3.4', 'Strategieën voor denken en leren', 'Leert leerlingen strategieën voor denken en leren', 'Biedt leerlingen checklists voor het oplossen van problemen');
insert into indicator(id, section, subsection, question) values('5.3.5', 'Strategieën voor denken en leren', 'Leert leerlingen strategieën voor denken en leren', 'Demonstreert denkstrategieën door mondeling of hardop denken');
insert into indicator(id, section, subsection, question) values('5.3.6', 'Strategieën voor denken en leren', 'Leert leerlingen strategieën voor denken en leren', 'Vereenvoudigt problemen door ze in stukken te hakken');

insert into indicator(id, section, subsection, question) values('5.4.1', 'Strategieën voor denken en leren', 'Laat leerlingen reflecteren op (diverse) oplossingsstrategieën', 'Laat leerlingen verschillende oplossingsstrategieën met elkaar vergelijken');
insert into indicator(id, section, subsection, question) values('5.4.2', 'Strategieën voor denken en leren', 'Laat leerlingen reflecteren op (diverse) oplossingsstrategieën', 'Brengt structuur aan in de verschillende oplossingsstrategieën');
insert into indicator(id, section, subsection, question) values('5.4.3', 'Strategieën voor denken en leren', 'Laat leerlingen reflecteren op (diverse) oplossingsstrategieën', 'Laat leerlingen de handigste oplossingsstrategie bepalen');
insert into indicator(id, section, subsection, question) values('5.4.4', 'Strategieën voor denken en leren', 'Laat leerlingen reflecteren op (diverse) oplossingsstrategieën', 'Evalueert de bruikbaarheid van oplossingsstrategieën');
insert into indicator(id, section, subsection, question) values('5.4.5', 'Strategieën voor denken en leren', 'Laat leerlingen reflecteren op (diverse) oplossingsstrategieën', 'Geeft leerlingen niet alleen feedback op het resultaat maar ook op het proces');

insert into indicator(id, section, subsection, question) values('5.5.1', 'Strategieën voor denken en leren', 'Stimuleert het hanteren van controleactiviteiten', 'Schenkt aandacht aan schattend rekenen / voorspellend lezen');
insert into indicator(id, section, subsection, question) values('5.5.2', 'Strategieën voor denken en leren', 'Stimuleert het hanteren van controleactiviteiten', 'Laat oplossingen relateren aan de context');
insert into indicator(id, section, subsection, question) values('5.5.3', 'Strategieën voor denken en leren', 'Stimuleert het hanteren van controleactiviteiten', 'Stimuleert het gebruik van alternatieve oplossingen en strategieën');

insert into indicator(id, section, subsection, question) values('5.6.1', 'Strategieën voor denken en leren', 'Bevordert het toepassen van het geleerde', 'Plaatst de leerstof in een betekenisvolle context');
insert into indicator(id, section, subsection, question) values('5.6.2', 'Strategieën voor denken en leren', 'Bevordert het toepassen van het geleerde', 'Vraagt leerlingen waarvoor het geleerde (ook) gebruikt kan worden');
insert into indicator(id, section, subsection, question) values('5.6.3', 'Strategieën voor denken en leren', 'Bevordert het toepassen van het geleerde', 'Bevordert het bewust toepassen van het geleerde in andere (verschillende) leergebieden');

insert into indicator(id, section, subsection, question) values('6.1.1', 'Systematisch volgen van vorderingen', 'Observeert regelmatig en neemt regelmatig toetsen af', 'Maakt gebruik van methodegebonden toetsen');
insert into indicator(id, section, subsection, question) values('6.1.2', 'Systematisch volgen van vorderingen', 'Observeert regelmatig en neemt regelmatig toetsen af', 'De methodegebonden toetsen worden afgenomen onder de afgesproken codities');
insert into indicator(id, section, subsection, question) values('6.1.3', 'Systematisch volgen van vorderingen', 'Observeert regelmatig en neemt regelmatig toetsen af', 'De methodeonafhankelijke toetsen worden onder de goede condities afgenomen en volgens de toetskalender');
insert into indicator(id, section, subsection, question) values('6.1.4', 'Systematisch volgen van vorderingen', 'Observeert regelmatig en neemt regelmatig toetsen af', 'Registreerd gegevens over de vorderingen bij het nakijken van werk');

insert into indicator(id, section, subsection, question) values('6.2.1', 'Systematisch volgen van vorderingen', 'Volgt de sociaal-emitionele ontwikkelingen', 'Bepaalt jaarlijks de sociaal-emotionele ontwikkeling');
insert into indicator(id, section, subsection, question) values('6.2.2', 'Systematisch volgen van vorderingen', 'Volgt de sociaal-emitionele ontwikkelingen', 'De school gebruikt hiervoor een genomeerd volginstrument');
insert into indicator(id, section, subsection, question) values('6.2.3', 'Systematisch volgen van vorderingen', 'Volgt de sociaal-emitionele ontwikkelingen', 'Benut de systematisch verzamelde informatie bij het bepalen van de onderwijsbehoeften van de leerlingen');

insert into indicator(id, section, subsection, question) values('6.3.1', 'Systematisch volgen van vorderingen', 'Analyseert gegevens over de vorderingen an leerlingen', 'Maakt foutenanalyses van vorderingentoetsen en diagnoatische toetsen bij de methodes');
insert into indicator(id, section, subsection, question) values('6.3.2', 'Systematisch volgen van vorderingen', 'Analyseert gegevens over de vorderingen an leerlingen', 'De school stelt niet allee vast waar leerlingen op uitvallen, maar ook waarom');
insert into indicator(id, section, subsection, question) values('6.3.3', 'Systematisch volgen van vorderingen', 'Analyseert gegevens over de vorderingen an leerlingen', 'Voert regelmatig met leerlingen diagnostische gesprekjes om meer inzicht te krijgen in mogelijke oorzaken van stagnaties in hun ontwikkeling');
insert into indicator(id, section, subsection, question) values('6.3.4', 'Systematisch volgen van vorderingen', 'Analyseert gegevens over de vorderingen an leerlingen', 'Past de didactische aanpak voor de groep of individuele leerlingen aan op basis van de analyse');
insert into indicator(id, section, subsection, question) values('6.3.5', 'Systematisch volgen van vorderingen', 'Analyseert gegevens over de vorderingen an leerlingen', 'Past de pedagogische aanpak aan op basis van gedocumenteerde kennis op het gebied van sociaal-emotionele ontwikkeling');

insert into indicator(id, section, subsection, question) values('6.4.1', 'Systematisch volgen van vorderingen', 'Administreert de vorderingen overzichtelijk in de groepsadministratie', 'Beschikt over groepsoverzichten van toetsresultaten in groepsmap (LVS)');
insert into indicator(id, section, subsection, question) values('6.4.2', 'Systematisch volgen van vorderingen', 'Administreert de vorderingen overzichtelijk in de groepsadministratie', 'Beschikt over leerlingprofielen in groepsmap (LVS)');
insert into indicator(id, section, subsection, question) values('6.4.3', 'Systematisch volgen van vorderingen', 'Administreert de vorderingen overzichtelijk in de groepsadministratie', 'Plant en registreert interventies naar aanleiding van toets- en observatiegegevens, van nagekeken werk en diagnostische gesprekken');
insert into indicator(id, section, subsection, question) values('6.4.4', 'Systematisch volgen van vorderingen', 'Administreert de vorderingen overzichtelijk in de groepsadministratie', 'De leraar hanteert bij haar dagelijks handelen het groepsplan wat zichtbaar is in de dag- en weekplanning');

insert into indicator(id, section, subsection, question) values('7.1.1', 'Strategieën voor denken en leren', 'Stemt instructie af op relevante verschillen tussen leerlingen', 'Zet leerlingen die minder instructie nodig hebben (alvast) aan het werk');
insert into indicator(id, section, subsection, question) values('7.1.2', 'Strategieën voor denken en leren', 'Stemt instructie af op relevante verschillen tussen leerlingen', 'Geeft aanvullende instructie aan groepjes of individuele leerlingen');
insert into indicator(id, section, subsection, question) values('7.1.3', 'Strategieën voor denken en leren', 'Stemt instructie af op relevante verschillen tussen leerlingen', 'Richt zich niet alleen op de middenmoot');
insert into indicator(id, section, subsection, question) values('7.1.4', 'Strategieën voor denken en leren', 'Stemt instructie af op relevante verschillen tussen leerlingen', 'De instructie sluit aan op kennis over hoe de leerling leert');

insert into indicator(id, section, subsection, question) values('7.2.1', 'Strategieën voor denken en leren', 'Stemt de verwerking van de leerstof af op relevante verschillen tussen leerlingen', 'Maakt tussen leerlingen verschil in de omvang van opdrachten');
insert into indicator(id, section, subsection, question) values('7.2.2', 'Strategieën voor denken en leren', 'Stemt de verwerking van de leerstof af op relevante verschillen tussen leerlingen', 'Laat sommige leerlingen gebruik maken van hulpmaterialen');
insert into indicator(id, section, subsection, question) values('7.2.3', 'Strategieën voor denken en leren', 'Stemt de verwerking van de leerstof af op relevante verschillen tussen leerlingen', 'Geeft niet alle leerlingen dezelfde tijd voor de opdracht');
insert into indicator(id, section, subsection, question) values('7.2.4', 'Strategieën voor denken en leren', 'Stemt de verwerking van de leerstof af op relevante verschillen tussen leerlingen', 'De verwerkingsopdracht sluit aan op kennis hoe de leerling leert');

insert into indicator(id, section, subsection, question) values('7.3.1', 'Strategieën voor denken en leren', 'Biedt zwakke leerlingen extra leer- en instructietijd', 'Geeft zwakke leerlingen extra leertijd');
insert into indicator(id, section, subsection, question) values('7.3.2', 'Strategieën voor denken en leren', 'Biedt zwakke leerlingen extra leer- en instructietijd', 'Geeft zwakke leerlingen extra oefeningen');
insert into indicator(id, section, subsection, question) values('7.3.3', 'Strategieën voor denken en leren', 'Biedt zwakke leerlingen extra leer- en instructietijd', 'Geeft zwakke leerlingen ‘voor’- of ‘na’-instructie');

insert into indicator(id, section, subsection, question) values('7.4.1', 'Strategieën voor denken en leren', 'Het taalgebruik van de leerkracht past bij de taalbehoeften van de leerlingen', 'Het taalgebruik van de leerkracht voldoet aan de regels van de standaardtaal');
insert into indicator(id, section, subsection, question) values('7.4.2', 'Strategieën voor denken en leren', 'Het taalgebruik van de leerkracht past bij de taalbehoeften van de leerlingen', 'Het taalgebruik van de leerkracht stemt overeen met het ontwikkelingsniveau van de groep');
insert into indicator(id, section, subsection, question) values('7.4.3', 'Strategieën voor denken en leren', 'Het taalgebruik van de leerkracht past bij de taalbehoeften van de leerlingen', 'De leerkracht stemt zijn taal af op het niveau van individuele leerlingen');
insert into indicator(id, section, subsection, question) values('7.4.4', 'Strategieën voor denken en leren', 'Het taalgebruik van de leerkracht past bij de taalbehoeften van de leerlingen', 'De leerkracht brengt responsieve interactie op gang (interactie die de taalverwerving bevordert)');

insert into indicator(id, section, subsection, question) values('8.1.1', 'Leerlingen zijn actief betrokken', 'Er is een goede individuele betrokkenheid van leerlingen bij de instructie', 'Leerlingen letten op tijdens de instructie');
insert into indicator(id, section, subsection, question) values('8.1.2', 'Leerlingen zijn actief betrokken', 'Er is een goede individuele betrokkenheid van leerlingen bij de instructie', 'Leerlingen nemen actief deel aan leer- of kringgesprekken');
insert into indicator(id, section, subsection, question) values('8.1.3', 'Leerlingen zijn actief betrokken', 'Er is een goede individuele betrokkenheid van leerlingen bij de instructie', 'Leerlingen stellen vragen');
insert into indicator(id, section, subsection, question) values('8.1.4', 'Leerlingen zijn actief betrokken', 'Er is een goede individuele betrokkenheid van leerlingen bij de instructie', 'Leerlingen luisteren actief bij de instructie');
insert into indicator(id, section, subsection, question) values('8.1.5', 'Leerlingen zijn actief betrokken', 'Er is een goede individuele betrokkenheid van leerlingen bij de instructie', 'Leerlingen vragen geïnteresseerd door');

insert into indicator(id, section, subsection, question) values('8.2.1', 'Leerlingen zijn actief betrokken', 'Leerlingen werken op betrokken wijze aan hun taak', 'Leerlingen werken geconcentreerd en taakgericht aan de opdrachten');
insert into indicator(id, section, subsection, question) values('8.2.2', 'Leerlingen zijn actief betrokken', 'Leerlingen werken op betrokken wijze aan hun taak', 'Leerlingen gebruiken hun tijd efficiënt');

insert into indicator(id, section, subsection, question) values('8.3.1', 'Leerlingen zijn actief betrokken', 'Leerlingen zijn actief gericht op leren', 'Leerlingen nemen zelf initiatieven');
insert into indicator(id, section, subsection, question) values('8.3.2', 'Leerlingen zijn actief betrokken', 'Leerlingen zijn actief gericht op leren', 'Leerlingen werken zelfstandig');
insert into indicator(id, section, subsection, question) values('8.3.3', 'Leerlingen zijn actief betrokken', 'Leerlingen zijn actief gericht op leren', 'De leerkracht hanteert activerende werkvormen');
insert into indicator(id, section, subsection, question) values('8.3.4', 'Leerlingen zijn actief betrokken', 'Leerlingen zijn actief gericht op leren', 'Er zijn gevarieerde werkvormen die een beroep doen op uiteenlopende leerstijlen');
insert into indicator(id, section, subsection, question) values('8.3.5', 'Leerlingen zijn actief betrokken', 'Leerlingen zijn actief gericht op leren', 'Leerlingen geven blijk van het nemen van verantwoordelijkheid voor hun eigen leerproces');

insert into indicator(id, section, subsection, question) values('9.1.1', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Biedt leerlingen een structuur om zelfstandig te werken', 'Laat leerlingen werken met dag-, week- of maandtaken');
insert into indicator(id, section, subsection, question) values('9.1.2', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Biedt leerlingen een structuur om zelfstandig te werken', 'Biedt leerlingen een stappenplan voor het zelfstandig werken');
insert into indicator(id, section, subsection, question) values('9.1.3', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Biedt leerlingen een structuur om zelfstandig te werken', 'Laat leerlingen een eigen planning maken');

insert into indicator(id, section, subsection, question) values('9.2.1', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Biedt leerlingen keuzemogelijkheden', 'Laat de leerlingen eigen leervragen formuleren');
insert into indicator(id, section, subsection, question) values('9.2.2', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Biedt leerlingen keuzemogelijkheden', 'Laat leerlingen kiezen tussen alleen werken of samenwerken');
insert into indicator(id, section, subsection, question) values('9.2.3', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Biedt leerlingen keuzemogelijkheden', 'Laat leerlingen zelf volgorde, tijdstip, aanpak, plaats of hoeveelheid oefenstof bepalen');

insert into indicator(id, section, subsection, question) values('9.3.1', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Stelt zich coachend op en helpt op aanvraag', 'Geeft leerlingen de gelegenheid eerst zelf oplossingen te bedenken');
insert into indicator(id, section, subsection, question) values('9.3.2', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Stelt zich coachend op en helpt op aanvraag', 'Geeft leerlingen de gelegenheid van hun fouten te leren');
insert into indicator(id, section, subsection, question) values('9.3.3', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Stelt zich coachend op en helpt op aanvraag', 'Laat leerlingen zelfstandig oplossing uitproberen');
insert into indicator(id, section, subsection, question) values('9.3.4', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Stelt zich coachend op en helpt op aanvraag', 'Reageert adequaat op hulpvragen van leerlingen, overeenkomstig uiteenlopende niveaus van zelfstandigheid');

insert into indicator(id, section, subsection, question) values('9.4.1', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Benut middelen die zelfstandig werken en leren mogelijk maken', 'Gebruikt zelf-corrigerende materialen');
insert into indicator(id, section, subsection, question) values('9.4.2', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Benut middelen die zelfstandig werken en leren mogelijk maken', 'Zorgt dat er diverse leermiddelen beschikbaar zijn om één probleem op te lossen');
insert into indicator(id, section, subsection, question) values('9.4.3', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Benut middelen die zelfstandig werken en leren mogelijk maken', 'Gebruikt methoden die tot zelfstandig werken uitnodigen');

insert into indicator(id, section, subsection, question) values('9.5.1', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Leert leerlingen hun leerproces en leerresultaat zelfstandig evalueren', 'Laat leerlingen hun eigen werk corrigeren');
insert into indicator(id, section, subsection, question) values('9.5.2', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Leert leerlingen hun leerproces en leerresultaat zelfstandig evalueren', 'Laat leerlingen het van klasgenoten corrigeren');
insert into indicator(id, section, subsection, question) values('9.5.3', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Leert leerlingen hun leerproces en leerresultaat zelfstandig evalueren', 'Laat leerlingen conclusies trekken uit het gecorrigeerde werk');
insert into indicator(id, section, subsection, question) values('9.5.4', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Leert leerlingen hun leerproces en leerresultaat zelfstandig evalueren', 'Laat leerlingen hun eigen werkwijze en die van klasgenoten evalueren');

insert into indicator(id, section, subsection, question) values('9.6.1', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Bevordert dat leerlingen samenwerken', 'Geeft leerlingen de gelegenheid elkaar te helpen');
insert into indicator(id, section, subsection, question) values('9.6.2', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Bevordert dat leerlingen samenwerken', 'Geeft opdrachten waarmee samenwerken mogelijk/nodig is');
insert into indicator(id, section, subsection, question) values('9.6.3', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Bevordert dat leerlingen samenwerken', 'Geeft leerlingen de gelegenheid samen te spelen of samen opdrachten uit te voeren');
insert into indicator(id, section, subsection, question) values('9.6.4', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Bevordert dat leerlingen samenwerken', 'Bevordert het zelf oplossen van ruzies of misverstanden');

insert into indicator(id, section, subsection, question) values('9.7.1', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Leert leerlingen op doelmatige wijze samenwerken', 'Samenwerking is functioneel voor doel en/of proces');
insert into indicator(id, section, subsection, question) values('9.7.2', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Leert leerlingen op doelmatige wijze samenwerken', 'Er is sprake bij de samenwerking van wederzijdse afhankelijkheid');
insert into indicator(id, section, subsection, question) values('9.7.3', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Leert leerlingen op doelmatige wijze samenwerken', 'De leerkracht stelt eisen aan de kwaliteit van de samenwerking');

insert into indicator(id, section, subsection, question) values('9.8.1', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Geeft leerlingen feedback op getoonde zelfstandigheid en kwaliteit samenwerken', 'Geeft feedback op de door de leerling gekozen aanpak');
insert into indicator(id, section, subsection, question) values('9.8.2', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Geeft leerlingen feedback op getoonde zelfstandigheid en kwaliteit samenwerken', 'Geeft feedback op de door de leerling gekozen planning');
insert into indicator(id, section, subsection, question) values('9.8.3', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Geeft leerlingen feedback op getoonde zelfstandigheid en kwaliteit samenwerken', 'Geeft feedback op de door de leerling gekozen mate van ondersteuning');
insert into indicator(id, section, subsection, question) values('9.8.4', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Geeft leerlingen feedback op getoonde zelfstandigheid en kwaliteit samenwerken', 'Geeft feedback op de mate van samenwerking');
insert into indicator(id, section, subsection, question) values('9.8.5', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Geeft leerlingen feedback op getoonde zelfstandigheid en kwaliteit samenwerken', 'Geeft feedback op de individuele invulling van taken en rollen bij de samenwerking');
insert into indicator(id, section, subsection, question) values('9.8.6', 'Verantwoordelijkheid leerlingen voor organisatie en proces', 'Geeft leerlingen feedback op getoonde zelfstandigheid en kwaliteit samenwerken', 'Geeft feedback op de meerwaarde van samenwerking voor het resultaat');

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
