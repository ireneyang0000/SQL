---solution 1
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    select salary from (
        select distinct salary, 
              DENSE_RANK() over (order by salary desc) as row_num
        from Employee) temp
    where row_num=N
  );
END

---solution 2

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  SET N = N - 1;
  RETURN (
      select distinct(salary) from employee order by salary desc LIMIT 1 OFFSET N
  );
END