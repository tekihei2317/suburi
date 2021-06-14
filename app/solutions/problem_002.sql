select
  N1.num + N2.num as sum
from
  numbers_1 N1
  inner join numbers_2 N2
  on N1.id = N2.id
;