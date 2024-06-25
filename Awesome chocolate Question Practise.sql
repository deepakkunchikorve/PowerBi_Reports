select * from sales;

select SaleDate , Amount, customers from sales;

select saledate, amount, boxes, amount / boxes 'Amount per Boxes' from sales;

select * from sales
where amount > 10000;

select * from sales
where amount > 10000
order by amount desc;

select * from sales
where geoid = 'g1' 
order by PID, amount desc;

select * from sales
where amount > 10000 and saledate >= '2022-01-01';

select saledate , amount from sales
where amount > 10000 and year(saledate) = 2022
order by amount desc;

select * from sales 
where boxes > 0 and boxes <= 50;

select * from sales 
where boxes between 0 and 50;

select saledate, amount, boxes, weekday(saledate) as 'day of weeek'
from sales
where weekday(saledate) = 4;

select * from people;

select * from people
where team = 'Delish' or team ='jucies';

select * from people
where team in ('Delish');

select * from people
where Salesperson like '%B%';

SELECT 
    saledate,
    amount,
    CASE
        WHEN amount < 1000 THEN 'Under 1k'
        WHEN amount < 5000 THEN 'Under 5k'
        WHEN amount < 10000 THEN 'Under 10k'
        ELSE '10k or More'
    END as  'Amount Category'
    from sales;
    
-- JOINS IN SQL

select * from sales;

select * from people;

select s.saledate, s.amount , p.salesperson, s.spid, p.spid
from sales s
join people p
on p.spid = s.spid;

select s.saledate, s.amount, pr.product
from sales s
left join products pr
on pr.pid = s.pid;

select s.saledate, s.amount, p.salesperson, pr.product, p.team
from sales s
join people p
on p.spid = s.spid
join products pr
on pr.pid = s.pid;

select s.saledate, s.amount, p.salesperson, pr.product, p.team
from sales s
join people p
on p.spid = s.spid
join products pr
on pr.pid = s.pid
where s.amount < 500
and p.team = 'Delish';

select s.saledate, s.amount, p.salesperson, pr.product, p.team
from sales s
join people p
on p.spid = s.spid
join products pr
on pr.pid = s.pid
where s.amount < 500
and p.team ='' ;

select s.saledate, s.amount, p.salesperson, pr.product, p.team, g.geo
from sales s
join people p
on p.spid = s.spid
join products pr
on pr.pid = s.pid
join geo g
on g.GeoID = s.GeoID
where s.amount < 500
and p.team ='' 
and geo in('New Zealand' , 'India')
order by saledate;

-- GROUP BY AND AGGREGATION

select g.geo, sum(amount), avg(amount), sum(boxes)
from sales s
join geo g
on g.geoid = s.geoid
group by g.geo;


select pr.category, p.team, sum(boxes),sum(amount)
from sales s
join people p
on p.spid = s.spid
join products pr
on pr.pid = s.pid 
where p.team <> ''
group by pr.category,p.team
order by pr.category,p.team;

select pr.product, sum(s.amount) as ' Total Amount'
from sales s
join products pr
on pr.pid = s.pid
group by pr.product
order by `Total Amount` desc
limit 10 ;


