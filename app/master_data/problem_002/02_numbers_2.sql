drop table if exists 02_numbers_2;
create table 02_numbers_2 like master_numbers_2;
insert into 02_numbers_2 (num) values (8);
insert into 02_numbers_2 (num) values (2);
insert into 02_numbers_2 (num) values (7);
insert into 02_numbers_2 (num) values (8);
insert into 02_numbers_2 (num) values (0);