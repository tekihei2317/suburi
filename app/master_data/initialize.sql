drop database if exists problem_1;
create database problem_1;
use problem_1;

drop table if exists master_pairs;
create table master_pairs (
  a integer not null,
  b integer not null
);