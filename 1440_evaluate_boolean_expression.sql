create table Variables
(
name varchar,
value int
);

create table Expressions
(
left_operand varchar,
operator enum,
right_operand varchar
);

insert into variables
values
('x',66),
('y',77);


insert into Expressions
values
('x','>','y'),
('x','<','y'),
('x','=','y'),
('y','>','x'),
('y','<','x'),
('x','=','x');

select t.left_operand, t.operator, t.right_operand, 
    (case when operator = '>' then if(v1_value>v2.value, "true", "false")
          when operator = '<' then if(v1_value<v2.value, "true", "false")
          when operator = '=' then if(v1_value=v2.value, "true", "false")
          end) as value
from 
   (select e.*, v1.value as v1_value
    from Expressions as e inner join Variables as v1
    on e.left_operand = v1.name) as t inner join Variables as v2 
    on t.right_operand = v2.name
