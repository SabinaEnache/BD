--crearea tabelelor

--clienti
create table clienti (
id_client number(4),
nume varchar2(20) constraint null_nume_c not null,
prenume varchar2(20) constraint null_prenume not null,
metoda_plata varchar2(5),
constraint pk_clienti primary key(id_client),
constraint check_metoda_plata check(metoda_plata in ('cash','card'))
);

--mese
create table mese(
id_masa number(2),
locuri number(1) constraint null_locuri not null,
locuri_ocupate number(1),
constraint pk_mese primary key(id_masa),
constraint check_locuri check(locuri_ocupate <= locuri)
);

--mese_clienti
create table mese_clienti(
id_masa number(2),
id_client number(4),
constraint pk_mese_clienti primary key (id_masa, id_client),
constraint fk_mese_clienti_mese foreign key(id_masa) references mese(id_masa),
constraint fk_mese_clienti_clienti foreign key(id_client) references clienti(id_client)
);

--angajati
create table angajati(
id_angajat number(5),
nume varchar2(20) constraint null_nume_a not null,
prenume varchar2(20) constraint null_prenume_a not null,
telefon varchar2(10) constraint null_telefon not null,
data_angajare date constraint null_data_ang not null,
salariu number(6,2) constraint null_salariu not null,
constraint pk_angajati primary key(id_angajat)
);

--evenimente
create table evenimente(
data date,
organizator number(5),
tip varchar2(20),
artist varchar2(50),
constraint pk_data primary key(data),
constraint fk_evenimente_angajati foreign key(organizator) references angajati(id_angajat),
constraint check_tip check(tip in ('concert','comedie','jocuri'))
);

--comenzi
create table comenzi(
id_comanda number(10),
id_client number(4),
id_angajat number(6),
data_ora timestamp,
valoare number(5,2),
constraint pk_comenzi primary key(id_comanda),
constraint fk_comenzi_clienti foreign key(id_client) references clienti(id_client),
constraint fk_comenzi_angajati foreign key(id_angajat) references angajati(id_angajat)
);


--produse
create table produse(
id_produs number(5),
nume varchar(20) constraint null_nume_p not null,
pret number(4,2) constraint null_pret not null,
constraint pk_produse primary key(id_produs)
);


--produse_comenzi
create table produse_comenzi(
id_comanda number(10),
id_produs number(5),
nr_bucati number(2) constraint null_nr_buc not null,
constraint pk_produse_comenzi primary key (id_comanda, id_produs),
constraint fk_produse_comenzi_comenzi foreign key(id_comanda) references comenzi(id_comanda),
constraint fk_produse_comenzi_produse foreign key(id_produs) references produse(id_produs)
);

--ingrediente
create table ingrediente(
id_ingredient number(5),
nume varchar2(20) constraint null_nume_i not null,
cantitate number(3),
unitate_masura varchar2(5),
constraint pk_ingrediente primary key(id_ingredient)
);


--ingrediente_produse
create table ingrediente_produse(
id_produs number(5),
id_ingredient number(5),
constraint pk_ingrediente_produse primary key (id_produs, id_ingredient),
constraint fk_ip_produse foreign key(id_produs) references produse(id_produs),
constraint fk_ip_ingrediente foreign key(id_ingredient) references ingrediente(id_ingredient)
);

--inventar
create table inventar(
id number(10),
id_ingredient number(5),
cantitate number(5),
unitate_masura varchar2(10),
pret number(3), --per unitate
data date,
constraint pk_inventar primary key(id),
constraint fk_inventar_ingrediente foreign key(id_ingredient) references ingrediente(id_ingredient)
);

--furnizor
create table furnizor(
id_furnizor number(5),
nume varchar(30) constraint null_nume_f not null,
telefon varchar2(10) constraint null_telefo_f not null,
email varchar2(20),
adresa varchar2(50) constraint null_adresa not null,
constraint pk_furnizor primary key(id_furnizor)
);

--furnizor_inventar
create table furnizor_inventar(
id_furnizor number(5),
id number(10),
constraint pk_furnizor_inventar primary key (id_furnizor, id),
constraint fk_fi_inventar foreign key(id) references inventar(id),
constraint fk_fi_furnizor foreign key(id_furnizor) references furnizor(id_furnizor)
);

--inserarea datelor in tabele
create sequence micunealta_secreta
increment by 1
start with 1;

insert into clienti
values(micunealta_secreta.nextval, 'Popescu', 'Ion', 'cash');
insert into clienti
values(micunealta_secreta.nextval, 'Enache', 'Sabina','card');
insert into clienti
values(micunealta_secreta.nextval,'Dumitru','Vasile','cash');
insert into clienti
values(micunealta_secreta.nextval, 'Cercel','Adela','cash');
insert into clienti
values(micunealta_secreta.nextval,'Prodan','Bianca','card');
insert into clienti
values(micunealta_secreta.nextval,'Enache','Aida','card');
insert into clienti
values(micunealta_secreta.nextval,'Nicolae','Mariana','card'); 
insert into clienti
values(micunealta_secreta.nextval,'Tunaru', 'Camelia','cash'); 
insert into clienti
values(micunealta_secreta.nextval,'Sava', 'Catalin', 'card');
insert into clienti
values(micunealta_secreta.nextval,'Dumitrescu', 'Eugen','cash');
insert into clienti
values(micunealta_secreta.nextval,'Voinea','Ana','cash');

select * from clienti;

--mese 
create sequence micunealta_secreta2
increment by 1
start with 1;

insert into mese
values(micunealta_secreta2.nextval,4,1);
insert into mese
values(micunealta_secreta2.nextval,4,3);
insert into mese
values(micunealta_secreta2.nextval,4,0);
insert into mese
values(micunealta_secreta2.nextval,2,0);
insert into mese 
values(micunealta_secreta2.nextval,2,2);
insert into mese
values(micunealta_secreta2.nextval,2,0);
insert into mese
values(micunealta_secreta2.nextval,4,4);
insert into mese
values(micunealta_secreta2.nextval,4,0);
insert into mese 
values(micunealta_secreta2.nextval, 8 ,0);
insert into mese
values(micunealta_secreta2.nextval, 8, 0);

select * from mese;

--clienti mese
insert into mese_clienti
values(1,1);
insert into mese_clienti
values(5,2);
insert into mese_clienti
values(5,6);
insert into mese_clienti
values(2,3);
insert into mese_clienti
values(2,4);
insert into mese_clienti
values(2,5);
insert into mese_clienti
values(7,8);
insert into mese_clienti
values(7,9);
insert into mese_clienti
values(7,10);
insert into mese_clienti
values(7,11);

select * from mese_clienti;

--angajati
insert into angajati
values(1,'Enache','Sabina','074xxxxxxx','10-May-2023',3500);
insert into angajati
values(2,'Popescu','Andreea','073xxxxxxx','13-May-2023',2500);
insert into angajati
values(3,'Bravu','Catalin','072xxxxxx','13-May-2023',2500);
select * from angajati;
insert into angajati
values(4,'Gheorghe','Bianca','075xxxxxxx', '10-May-2023', 3000);
insert into angajati
values(5,'Popovici','Bianca','0743xxxxxx','10-Jun-2023', 2500);

select * from angajati;

--evenimente 
insert into evenimente
values('10-July-2023',1,'concert','Sabina');
insert into evenimente
values('27-May-2023',1,'comedie','Dragos');
insert into evenimente
values('15-Jun-2023',2,'concert','Smiley');
insert into evenimente(data,organizator,tip)
values('1-June-2023',1,'jocuri');
insert into evenimente(data,organizator,tip)
values('6-Aug-2023','3','jocuri');
insert into evenimente(data,organizator)
values ('11-Jun-2023',1);

select * from evenimente;

--produse 
create sequence micunealta_secreta3
increment by 1
start with 1;

insert into produse
values(micunealta_secreta3.nextval, 'Latte', 13);
insert into produse
values(micunealta_secreta3.nextval, 'Flavoured Latte', 14);
insert into produse
values(micunealta_secreta3.nextval, 'Iced Latte', 14);
insert into produse
values(micunealta_secreta3.nextval, 'Cappuccino', 11);
insert into produse
values(micunealta_secreta3.nextval, 'Flavoured Cappuccino', 12);
insert into produse
values(micunealta_secreta3.nextval,'Flat White', 14);
insert into produse
values(micunealta_secreta3.nextval,'Americano',10);
insert into produse
values(micunealta_secreta3.nextval, 'Espresso', 10);
insert into produse
values(micunealta_secreta3.nextval, 'Cold Brew Latte', 15);
insert into produse
values(micunealta_secreta3.nextval, 'Peach Iced Tea', 13);
insert into produse
values(micunealta_secreta3.nextval, 'Berry Iced Tea', 13);
insert into produse
values(micunealta_secreta3.nextval, 'Matcha Latte', 16);
insert into produse
values(micunealta_secreta3.nextval, 'Ceai', 10);
insert into produse
values(micunealta_secreta3.nextval, 'Prajitura zilei', 17);
insert into produse
values(micunealta_secreta3.nextval, 'Biscuite', 6);
insert into produse
values(micunealta_secreta3.nextval, 'Sandvis', 10);
insert into produse
values(micunealta_secreta3.nextval, 'Chai Latte', 17);

select * from produse;

--comenzi
insert into comenzi
values(1,7,1, '11-Jun-2023 13:42:00', 14);
insert into comenzi
values(2,5,1, '11-Jun-2023 10:37:00', 10);
insert into comenzi
values(3,1,1,'11-Jun-2023 11:23;00', 13);
insert into comenzi
values(4,2,2,'11-Jun-2023 14:15:00', 21);
insert into comenzi
values(5,6,2,'12-Jun-2023 14:16:00', 12);
insert into comenzi
values(6,3,2,'11-Jun-2023 14:44:00', 10);
insert into comenzi
values(7,4,2,'11-Jun-2023 15:45:00', 16);
insert into comenzi
values(8,2,2,'12-Jun-2023 17:38:00', 13);
insert into comenzi
values(9,5,3,'11-Jun-2023 18:03:00', 27);
insert into comenzi
values(10,4,3,'11-Jun-2023 18:07:00', 23);

select * from comenzi;

--produse_comenzi
insert into produse_comenzi
values(1,2,1);
insert into produse_comenzi
values(2,7,1);
insert into produse_comenzi
values(3,1,1);
insert into produse_comenzi
values(4,9,1);
insert into produse_comenzi
values(4,15,1);
insert into produse_comenzi
values(5,5,1);
insert into produse_comenzi
values(6,13,1);
insert into produse_comenzi
values(7,12,1);
insert into produse_comenzi
values(8,10,1);
insert into produse_comenzi
values(9,13,1);
insert into produse_comenzi
values(9,14,1);
insert into produse_comenzi
values(10,11,1);
insert into produse_comenzi
values(10,16,1);

select * from produse_comenzi;

--ingrediente  
create sequence micunealta_secreta4
increment by 1
start with 1;

insert into ingrediente values(micunealta_secreta4.nextval,'Espresso', 30, 'ml');
insert into ingrediente values(micunealta_secreta4.nextval, 'Lapte', 210, 'ml');
insert into ingrediente values(micunealta_secreta4.nextval, 'Concentrat Cold Brew', 60, 'ml');
insert into ingrediente values(micunealta_secreta4.nextval, 'Concentrat Peach Tea', 60, 'ml');
insert into ingrediente values(micunealta_secreta4.nextval, 'Concentrat Berry Tea', 60, 'ml');
insert into ingrediente values(micunealta_secreta4.nextval, 'Matcha', 20, 'g');
insert into ingrediente values(micunealta_secreta4.nextval, 'Ceai Verde', 1, 'plic');
insert into ingrediente values(micunealta_secreta4.nextval, 'Ceai Negru', 1, 'plic');
insert into ingrediente values(micunealta_secreta4.nextval, 'Ceai Chai', 1, 'plic');
insert into ingrediente values(micunealta_secreta4.nextval, 'Ceai Fructe', 1, 'plic');
insert into ingrediente values(micunealta_secreta4.nextval, 'Apa fierbinte', 240, 'ml');
insert into ingrediente values(micunealta_secreta4.nextval, 'Gheata', 150, 'g');
insert into ingrediente values(micunealta_secreta4.nextval, 'Apa', 150, 'ml');
insert into ingrediente values(micunealta_secreta4.nextval, 'Sirop Vanilie', 15, 'ml');
insert into ingrediente values(micunealta_secreta4.nextval, 'Sirop Ciocolata', 15, 'ml');
insert into ingrediente values(micunealta_secreta4.nextval, 'Sirop Alune', 15, 'ml');
insert into ingrediente
values(micunealta_secreta4.nextval, 'Sirop Cocos', 15, 'ml');
insert into ingrediente
values(micunealta_secreta4.nextval, 'Sirop Tiramisu', 15, 'ml');
insert into ingrediente
values(micunealta_secreta4.nextval, 'Sirop Caramel', 15, 'ml');
insert into ingrediente
values(micunealta_secreta4.nextval, 'Sirop Caramel Sarat', 15, 'ml');
insert into ingrediente
values(micunealta_secreta4.nextval, 'Sirop Turta Dulce', 15, 'ml');
insert into ingrediente
values(micunealta_secreta4.nextval, 'Frisca', 15, 'g');
insert into ingrediente
values(micunealta_secreta4.nextval, 'Prajitura', 150, 'g');
insert into ingrediente
values(micunealta_secreta4.nextval, 'Biscuite', 50, 'g');
insert into ingrediente
values(micunealta_secreta4.nextval, 'Sandvis', 250, 'g');

select * from ingrediente;

--ingrediente_produse 

insert into ingrediente_produse                 --latte
values(1,1);
insert into ingrediente_produse                 
values(1,2);

insert into ingrediente_produse                 --toate tipurile de flavoured latte
values(2,1);
insert into ingrediente_produse                 
values(2,2);
insert into ingrediente_produse                 
values(2,14);
insert into ingrediente_produse                 
values(2,15);
insert into ingrediente_produse                 
values(2,16);
insert into ingrediente_produse                 
values(2,17);
insert into ingrediente_produse                 
values(2,18);
insert into ingrediente_produse                 
values(2,19);
insert into ingrediente_produse                 
values(2,20);
insert into ingrediente_produse                 
values(2,21);

insert into ingrediente_produse        --iced latte
values(3,1);
insert into ingrediente_produse                 
values(3,2);
insert into ingrediente_produse                 
values(3,12);

insert into ingrediente_produse          --cappucino
values(4,1);
insert into ingrediente_produse                 
values(4,2);

insert into ingrediente_produse     --toate tipurile de flavoured cappuccino
values(5,1);
insert into ingrediente_produse                 
values(5,2);
insert into ingrediente_produse                 
values(5,14);
insert into ingrediente_produse                 
values(5,15);
insert into ingrediente_produse                 
values(5,16);
insert into ingrediente_produse                 
values(5,17);
insert into ingrediente_produse                 
values(5,18);
insert into ingrediente_produse                 
values(5,19);
insert into ingrediente_produse                 
values(5,20);
insert into ingrediente_produse                 
values(5,21);


insert into ingrediente_produse          --flat white
values(6,1);
insert into ingrediente_produse                 
values(6,2);

insert into ingrediente_produse           --americano
values(7,1);
insert into ingrediente_produse                 
values(7,11);

insert into ingrediente_produse                --espresso
values(8,1);

insert into ingrediente_produse                --cold brew latte
values(9,2);
insert into ingrediente_produse                 
values(9,3);
insert into ingrediente_produse                 
values(9,12);
insert into ingrediente_produse                 
values(9,14);

insert into ingrediente_produse              --berry iced tea
values(10,4);
insert into ingrediente_produse                 
values(10,12);
insert into ingrediente_produse                 
values(10,13);

insert into ingrediente_produse             --peach iced tea
values(11,5);
insert into ingrediente_produse                 
values(11,12);
insert into ingrediente_produse                 
values(11,13);

insert into ingrediente_produse         --matcha latte
values(12,6);
insert into ingrediente_produse                 
values(12,2);
insert into ingrediente_produse                 
values(12,14);

insert into ingrediente_produse             --toate tipurile de ceai
values(13,11);
insert into ingrediente_produse                 
values(13,7);
insert into ingrediente_produse
values(13,8);
insert into ingrediente_produse
values(13,9);
insert into ingrediente_produse                 
values(13,10);
insert into ingrediente_produse      --prajitura
values(14,23);
insert into ingrediente_produse     --biscuite
values(15,24);
insert into ingrediente_produse     --sandvis
values(16,25);
insert into ingrediente_produse    --chai latte
values(17,9);
insert into ingrediente_produse                 
values(17,2);
insert into ingrediente_produse                 
values(17,22);

select * from ingrediente_produse;

--inventar
create sequence micunealta_secreta5
increment by 1
start with 1;

insert into inventar 
values(micunealta_secreta5.nextval, 1, 5, 'kg', 95, '10-May-2023');
insert into inventar 
values(micunealta_secreta5.nextval, 2, 15, 'L', 6, '10-May-2023');
insert into inventar 
values(micunealta_secreta5.nextval, 3, 8, 'sticla', 99, '10-May-2023');
insert into inventar 
values(micunealta_secreta5.nextval, 4, 8, 'sticla', 55, '10-May-2023');
insert into inventar 
values(micunealta_secreta5.nextval, 5, 8, 'sticla', 55, '10-May-2023');
insert into inventar 
values(micunealta_secreta5.nextval, 6, 3, 'cutie', 71, '10-May-2023');
insert into inventar 
values(micunealta_secreta5.nextval, 7, 2, 'cutie', 15, '10-May-2023');
insert into inventar 
values(micunealta_secreta5.nextval, 8, 2, 'cutie', 15, '10-May-2023');
insert into inventar 
values(micunealta_secreta5.nextval, 9, 2, 'cutie', 20, '10-May-2023');
insert into inventar 
values(micunealta_secreta5.nextval, 10, 2, 'cutie', 15, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 14, 4, 'sticla', 55, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 15, 4, 'sticla', 55, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 16, 4, 'sticla', 55, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 17, 4, 'sticla', 55, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 18, 4, 'sticla', 55, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 19, 4, 'sticla', 55, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 20, 4, 'sticla', 55, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 21, 4, 'sticla', 55, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 22, 7, 'L', 21, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 23, 15, 'buc', 12, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 24, 15, 'buc', 3, '10-May-2023');
insert into inventar
values(micunealta_secreta5.nextval, 25, 15, 'buc', 7, '10-May-2023');

select * from inventar;


--furnizor
insert into furnizor
values(1,'kfea','07xxxxxxxx','kfea.ro@gmail.com','kfea.ro');
insert into furnizor
values(2,'MegaImage','07xxxxxxxx','mega_image@gmial.com','mega-image.ro');
insert into furnizor
values(3,'kofiti','07xxxxxxxx','kofiti@gmail.ro','kofiti.ro');
insert into furnizor
values(4,'Monin','07xxxxxxxx','monin@gmail.com','monin.com');
insert into furnizor
values(5,'caffeonline','07xxxxxxxx','caffeon@gmail.com','caffeeonline.ro');
insert into furnizor
values(6,'LaDorna','07xxxxxxxx','ladorna@gmail.com','ladorna.ro');
insert into furnizor
values(7,'biogama','07xxxxxxxx','biogama@gmail.com','biogama.ro');
insert into furnizor
values(8,'Sabina','07xxxxxxxx','sabina@gmail.com','sabina.ro');

select * from furnizor;

--furnizor_inventar
insert into furnizor_inventar values(1,1);
insert into furnizor_inventar values(2,2);
insert into furnizor_inventar values(3,3);
insert into furnizor_inventar values(4,4);
insert into furnizor_inventar values(4,5);
insert into furnizor_inventar values(7,6);
insert into furnizor_inventar values(5,7);
insert into furnizor_inventar values(5,8);
insert into furnizor_inventar values(5,9);
insert into furnizor_inventar values(5,10);
insert into furnizor_inventar values(4,11);
insert into furnizor_inventar values(4,12);
insert into furnizor_inventar values(4,13);
insert into furnizor_inventar values(4,14);
insert into furnizor_inventar values(4,15);
insert into furnizor_inventar values(4,16);
insert into furnizor_inventar values(4,17);
insert into furnizor_inventar values(4,18);
insert into furnizor_inventar values(6,19);
insert into furnizor_inventar values(8,20);
insert into furnizor_inventar values(8,21);
insert into furnizor_inventar values(8,22);

select * from furnizor_inventar;



---CERINTE EX 12----


--1. Afisati numele si prenumele angajatilor si daca acestia au organizat evenimente, 
--se va afisa tipul evenimentului. Daca angajatul nu a organizat niciun eveniment, 
--se va afisa un mesaj corespunzator. (ORDER BY, NVL, DECODE)
with ev_ang as (
                select a.nume nume_angajat, a.prenume prenume_angajat,
                       nvl(e.tip, 'Nu a organizat eveniment') tip_eveniment
                from angajati a, evenimente e 
                where a.id_angajat = e.organizator(+))
select nume_angajat, prenume_angajat, tip_eveniment, DECODE(tip_eveniment, 'Nu a organizat eveniment', 'NU', 'DA') eveniment
from ev_ang
order by 1;


--2. Afisati numele produselor, cantitatea vanduta si valoarea totala castigata din produsele
--vandute pe data de 11 jun 2023. (1 functie pe siruri de caractere, 1 functie pe data calendaristica)
select p.nume Denumire, sum(nr_bucati) Cantitate, sum(pret*nr_bucati) Valoare
from produse p, produse_comenzi pc, comenzi c
where p.id_produs = pc.id_produs and pc.id_comanda = c.id_comanda
and lower(to_char(c.data_ora,'dd-mon-yyyy')) like '%11-jun-2023%'
group by p.nume;


--3. Afisati toti clientii care au plasat cel putin o comanda cu un produs ce contine cel putin
--3 ingrediente si care au id ul par (SUBCERERE NESINCRONIZATA CU 3 TABELE CU FUNCTII DE GRUP SI FILTRARE LA NIVEL DE GRUP IN CLAUZA DE FROM)

SELECT c.prenume
FROM clienti c, (select id_client
                 from comenzi co, produse_comenzi pc, produse p
                 where co.id_comanda = pc.id_comanda 
                 and pc.id_produs = p.id_produs
                 and p.id_produs in (select distinct ip.id_produs 
                                     from ingrediente_produse ip 
                                     where id_ingredient3 is not null)
                 group by id_client
                 having id_client in (2,4,6,8)) temp
WHERE c.id_client = temp.id_client;


--4. Afisati numele si pretul marit cu 10% al produselor cu ingrediente furnizate de kfea
--(SUBCERERE SINCRONIZATA CU MINIM 3 TABELE)

select p.nume, p.pret+p.pret*0.10 "pret nou"
from produse p
where p.id_produs in (select distinct p.id_produs
                      from inventar i, furnizor_inventar if, furnizor f, ingrediente_produse ip
                      where p.id_produs = ip.id_produs 
                      and ip.id_ingredient1 = i.id_ingredient
                      and i.id=if.id and if.id_furnizor=f.id_furnizor
                      and lower(f.nume)='kfea')
order by 1;


--5. Mariti salariile angajatilor cu 20% daca sunt angajati din mai si cu 10% daca sunt 
--angajati din iunie. daca sunt angajati in orice alta luna, salariul ramane nemodificat
--(1 FUNCTIE PE DATA CALENDARISTICA, EXPRESIA CASE)
select id_angajat, nume || ' '||prenume Nume, salariu "Salariu vechi", case
                                when to_char(data_angajare,'mon')='may' then salariu+salariu*0.20
                                when to_char(data_angajare,'mon')='jun' then salariu+salariu*0.10
                                else salariu
                                end as "Salariu nou"
from angajati;



---CERINTE EX 13---
--1. mariti salariul angajatilor cu 15% angajatilor care au cea mai mare vechime
select * from angajati;

update angajati
set salariu = salariu + salariu * 0.15 
where months_between(sysdate, data_angajare) = (select max(months_between(sysdate, data_angajare)) from angajati);

select * from angajati;

rollback;



--2. stergeti evenimentele care sunt organizate de anagajatul cu salariul cel mai mare
select * from evenimente;

delete from evenimente ev
where organizator = (select id_angajat from angajati where salariu = (select max(salariu) from angajati)); 

select * from evenimente;




--3. concediati angajatii care nu au completat nicio comanda

select * from angajati;

delete from angajati
where id_angajat not in (select a.id_angajat from angajati a, comenzi c where c.id_angajat = a.id_angajat(+));

select * from angajati;



