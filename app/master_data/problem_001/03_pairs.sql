drop table if exists 03_pairs;
create table 03_pairs like master_pairs;

insert into 03_pairs values(8, 13);
insert into 03_pairs values(18, 18);
insert into 03_pairs values(2, 7);
insert into 03_pairs values(15, 14);
insert into 03_pairs values(13, 0);