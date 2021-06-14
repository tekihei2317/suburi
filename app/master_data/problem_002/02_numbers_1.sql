drop table if exists 02_numbers_1;
create table 02_numbers_1 like master_numbers_1;
insert into 02_numbers_1 (num) values (3);
insert into 02_numbers_1 (num) values (3);
insert into 02_numbers_1 (num) values (5);
insert into 02_numbers_1 (num) values (8);
insert into 02_numbers_1 (num) values (2);