use problem_1;
drop table if exists 02_pairs;
create table 02_pairs like master_pairs;

insert into 02_pairs values(14, 17);
insert into 02_pairs values(10, 13);
insert into 02_pairs values(8, 7);
insert into 02_pairs values(15, 14);
insert into 02_pairs values(12, 1);