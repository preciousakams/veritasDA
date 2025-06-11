select count(*) as accountInfo from Account_info;

select count(*) as customerInfo from Account_info; 

select top 100 * from Account_info;
select top 100 * from Customer_info;

--account Exploration


select creditScore, count(*) as creditCount
from Account_info
group by CreditScore
order by creditCount desc;

select tenure, count(*) as tenureCount
from Account_info
group by Tenure
order by tenureCount desc;

select exited, count(*) from Account_info
group by exited;

select ActiveMember, count(*) from Account_info
group by ActiveMember;

select sum(Balance) from Account_info;

select Products, count(*) from Account_info
group by Products;

select CreditCard, count(*) from Account_info
group by CreditCard;

--- Customer Exploration

select LastName, count(*) as lastname1 from Customer_info
group by LastName 
order by lastname1 desc;

select count(LastName) as lastname1 from Customer_info;

select Country, count(*) from Customer_info
group by Country;

select Gender, count(*) from Customer_info
group by Gender

select Age, count(*) from Customer_info
group by Age;

select Age, count(*) as ageGroup from Customer_info
group by Age
order by Age desc;

select Age, count(*) as ageGroup from Customer_info
group by Age
order by ageGroup desc;

select top 100 * from Account_info a
left join Customer_info c on a.CustomerId = c.CustomerId;

-- churn analysis
select creditScore, count (*) from Account_info
where Exited = 1
group by CreditScore;

select Tenure, count (*) from Account_info
where Exited = 1
group by Tenure;

select CreditScore, sum(Balance) exitedBal from Account_info
where Exited = 1
group by CreditScore
order by exitedBal desc;

select CreditScore, sum(Balance) exitedBal from Account_info
where Exited = 0
group by CreditScore
order by exitedBal desc;

select CreditCard, count(*) exitedBal from Account_info
where Exited = 0
group by CreditCard;

select CreditCard, count(*) exitedBal from Account_info
where Exited = 1
group by CreditCard;

select ActiveMember, count(*) exitedBal from Account_info
where Exited = 1
group by ActiveMember;

select ActiveMember, count(*) exitedBal from Account_info
where Exited = 0
group by ActiveMember;

select c.country, count(*) exitedBal from Account_info a
left join Customer_info c on a.CustomerId = c.CustomerId
where a.Exited = 1
group by c.Country;

select c.country, count(*) exitedBal from Account_info a
left join Customer_info c on a.CustomerId = c.CustomerId
where a.Exited = 0
group by c.Country;

select c.Gender, count(*) exitedBal from Account_info a
left join Customer_info c on a.CustomerId = c.CustomerId
where a.Exited = 1
group by c.Gender;

select c.Gender, count(*) exitedBal from Account_info a
left join Customer_info c on a.CustomerId = c.CustomerId
where a.Exited = 0
group by c.Gender;

select c.Age, count(*) exitedBal from Account_info a
left join Customer_info c on a.CustomerId = c.CustomerId
where a.Exited = 1
group by c.Age;

select c.Age, count(*) exitedBal from Account_info a
left join Customer_info c on a.CustomerId = c.CustomerId
where a.Exited = 0
group by c.Age;

-- Age Grouping

Drop view if exists Updated_Customer_info
GO
create view Updated_Customer_info as 

select customerid, lastName, Country, Gender, Age,
case
	when Age between 18 And 20 then '18-20'
	when Age between 21 And 30 Then '21-30'
	when Age between 31 And 40 Then '31-40'
	when Age between 41 And 50 Then '41-50'
	when Age between 51 And 60 Then '51-60'
	when Age >= 61 Then '61+'
End As Age_group
from customer_info;
GO

select Age_group, count (*) from Updated_Customer_info
group by Age_group;

-- Modify Account info

Drop view if exists updated_account_info
GO
create view updated_account_info as

select CustomerId, CreditScore, Tenure, Balance, Products,
case
	when CreditCard = 0 then 'No Credit Card'
	when CreditCard = 1 then 'Has Credit Card'
End As CreditCard,

case 
	when ActiveMember = 0 then 'Inactive Members'
	when ActiveMember = 1 then 'Active Members'
end as ActiveMemeber,

case 
	when Exited = 0 then 'Existing Customers'
	when Exited = 1 then 'Churned Customers'
end as Exited,

--EquifaxRating
case
	when CreditScore between 0 And 438 then 'Poor'
	when CreditScore between 439 And 530 Then 'Fair'
	when CreditScore between 531 And 670 Then 'Good'
	when CreditScore between 671 And 810 Then 'Very Good'
	when CreditScore between 811 And 1000 Then 'Excellent'
End As CreditScore_group
from Account_info;
GO
-- KPI

Drop view if exists creditCard
GO
create view creditCard as

select CreditCard, count(*) CardType from updated_account_info
group by CreditCard;
GO

Drop view if exists  members 
GO
create view members as

select ActiveMemeber, count(*) MemberType from updated_account_info
group by ActiveMemeber;
GO

Drop view if exists Exited
GO
create view Exited as

select Exited, count(*) ExitedType from updated_account_info
group by Exited;
GO

Drop view if exists churned

GO
create view churned as
select customerid,Tenure, Exited from updated_account_info
where Exited = 'Churned Customers'
group by customerid,Tenure, Exited;
GO

Drop view if exists Inactive
GO
create view Inactive as
select customerid,Tenure, Exited, ActiveMemeber as InactiveMembers from updated_account_info
where ActiveMemeber = 'Inactive Members'
group by customerid,Tenure, Exited,ActiveMemeber;
GO

select Exited, sum(Balance) from Account_info
group by Exited;

select Exited, sum(Balance) from updated_account_info
group by Exited;



select Exited,COUNT(ActiveMember) from Account_info
where ActiveMember = 0
group by Exited;

select ActiveMember,COUNT(*) from Account_info
group by ActiveMember;
































