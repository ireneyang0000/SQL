with highest as 
(
select *,rank() over (partition by exam_id order by score desc) as high_rank
    from exam
    
),
lowest as 
(
select *,rank() over (partition by exam_id order by score) as low_rank
    from exam
    
)
select student_id, student_name
from student
where student_id in (select distinct student_id from exam)
and student_id not in (select distinct student_id from highest where high_rank = 1)
and student_id not in (select distinct student_id from lowest where low_rank = 1)