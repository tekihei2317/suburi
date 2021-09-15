drop table if exists 01_numbers_2;
create table 01_numbers_2 like master_numbers_2;
insert into 01_numbers_2 (num) values (6);
insert into 01_numbers_2 (num) values (9);
insert into 01_numbers_2 (num) values (0);
insert into 01_numbers_2 (num) values (6);
insert into 01_numbers_2 (num) values (5);