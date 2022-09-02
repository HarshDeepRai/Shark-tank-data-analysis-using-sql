 show databases;
use project1;
show tables;
describe data;
select * from data;
select distinct(brand) from data;
/*pitches converted to deals*/

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select Amountinvestedlakhs , case when Amountinvestedlakhs>0 then 1 else 0 end as converted_not_converted from data) a;

select sum(male) from data;

-- total female

select sum(female) from data;

/*gender ratio*/

select sum(female)/sum(male) from data;

-- total invested amount

select sum(amountinvestedlakhs) from data;

-- avg equity taken

select avg(a.equitytaken) from
(select * from data where equitytaken>0) a;

/*highest deal taken*/

select max(amountinvestedlakhs) from data; 

/*higheest equity taken*/

select max(equitytaken) from data;

/*number of startups having at least 1 women*/

select sum(a.female_count) startups from (
select female,case when female>0 then 1 else 0 end as female_count from data) a;

-- pitches converted having atleast 1 women
select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from data where deal!='No Deal')) a)b;
-- avg team members
select avg(teammembers) from data;
-- amount invested per deal

select avg(a.amountinvestedlakhs) amount_invested_per_deal from
(select * from data where deal!='No Deal') a;

-- avg age group of contestants

select avgage,count(avgage) cnt from data group by avgage order by cnt desc;

-- location group of contestants

select location,count(location) cnt from data group by location order by cnt desc;

-- sector group of contestants

select sector,count(sector) cnt from data group by sector order by cnt desc;


/*partner deals*/

select partners,count(partners) cnt from data  where partners!='-' group by partners order by cnt desc;

-- which is the startup in which the highest amount has been invested in each domain/sector
select c.* from 
(select brand,sector,amountinvestedlakhs,rank() over(partition by sector order by amountinvestedlakhs desc) rnk 

from data) c where c.rnk=1;
