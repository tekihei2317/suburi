drop table if exists 01_numbers_1;
create table 01_numbers_1 like master_numbers_1;
insert into 01_numbers_1 (num) values (6);
insert into 01_numbers_1 (num) values (3);
insert into 01_numbers_1 (num) values (5);
insert into 01_numbers_1 (num) values (0);
insert into 01_numbers_1 (num) values (4);