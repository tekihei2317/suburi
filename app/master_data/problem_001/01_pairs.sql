drop table if exists 01_pairs;
create table 01_pairs like master_pairs;

insert into 01_pairs values(10, 10);
insert into 01_pairs values(4, 11);
insert into 01_pairs values(20, 12);
insert into 01_pairs values(13, 11);
insert into 01_pairs values(9, 10);