use E_commerse;

select * from customer c inner join `orders` o on o.CUS_ID = c.CUS_ID where o.ORD_AMOUNT>=3000;
select cus_gender from customer c inner join `orders` o on o.CUS_ID=c.CUS_ID where o.ORD_AMOUNT>=3000;
select COUNT(cus_gender) from (select cus_gender from customer c inner join `orders` o on o.CUS_ID=c.CUS_ID where o.ORD_AMOUNT>=3000) as cg group by cus_gender;
select cg.cus_gender, COUNT(cus_gender) from (select cus_gender from customer c inner join `orders` o on o.CUS_ID=c.CUS_ID where o.ORD_AMOUNT>=3000) as cg group by cus_gender;
select cus_gender,COUNT(cus_gender)  from customer c inner join `orders` o on o.CUS_ID=c.CUS_ID where o.ORD_AMOUNT>=3000 group by cus_gender;


select * from `orders` o inner join product p on o.PROD_ID=p.PRO_ID where o.CUS_ID=2;
select ORD_ID,ORD_AMOUNT,DATE,o.CUS_ID,o.PROD_ID,p.PRO_NAME from `orders` o inner join product p on o.PROD_ID=p.PRO_ID where o.CUS_ID=2;
select o.ORD_ID,o.ORD_AMOUNT,o.ORD_DATE,o.CUS_ID,o.PROD_ID,p.PRO_NAME from `orders` o inner join product p on (o.PROD_ID=p.PRO_ID and o.CUS_ID=2);

select * from `orders`;
select * from product_details;
select * from product;

select `orders`.*,product.pro_name from `orders` ,product_details,product where `orders`.cus_id=2 and `orders`.prod_id=product_details.prod_id and product_details.pro_id=product.pro_id;

select * from product_details;
select SUPP_ID, count(PROD_ID) from product_details GROUP by SUPP_ID;
select SUPP_ID, count(PROD_ID) as no_of_products from product_details GROUP by SUPP_ID;
select SUPP_ID from (select SUPP_ID, count(PROD_ID) as no_of_products from product_details GROUP by SUPP_ID) as pd where pd.no_of_products >=2;

select * from supplier where supp_id in (select supp_id from product_details group by supp_id having count(supp_id)>1);

select s.* from supplier s join (select supp_id, count(supp_id) from product_details group by supp_id having count(supp_id) > 1) as pd on pd.supp_id = s.supp_id;


select min(ORD_AMOUNT) from `orders`;
Select c.cat_name, c.cat_id 
from category c inner join 
	(Select p.cat_id, opd.* from product p inner join 
		(Select pd.pro_id, om.* from product_details pd inner join 
			(Select o.PROD_ID, min(o.ORD_AMOUNT) from `orders-directory`.order o) as om on om.prod_id = pd.prod_id) as opd on opd.PRO_ID = p.pro_id) as popd on c.cat_id = popd.cat_id;

select * from category where cat_id in(select cat_id from product where pro_id 
in
( select pro_id from product_details P inner join `orders` O on O.prod_id=P.prod_id where O.ORD_AMOUNT=(select min(ORD_AMOUNT) from `orders`)));

select category.* from `orders` inner join product_details on `orders`.prod_id=product_details.prod_id inner join product on product.pro_id=product_details.pro_id inner join category on category.cat_id=product.cat_id where `order`.ORD_AMOUNT = (select min(ORD_AMOUNT) from `order`);

select * from `orders` where DATE > '2021-10-05';

select b.pro_id,b.pro_name from product b inner join ( select a.PRO_ID from product_details as a inner join `orders` as o on o.PROD_ID = a.PROD_ID where DATE > '2021-10-05') q on b.pro_id=q.pro_id;

select a.PRO_ID from product_details as a inner join `orders` as o on o.PROD_ID = a.PROD_ID where o.ORD_DATE > '2021-10-05';

SELECT 
    p.PRO_ID, p.PRO_NAME
FROM
    `orders` o
        INNER JOIN
    `product_details` prod ON o.prod_id = prod.prod_id
        INNER JOIN
    product p ON p.pro_id = prod.pro_id
WHERE
    o.ORD_DATE > '2021-10-05';

select product.PRO_ID, product.PRO_NAME from `orders` INNER JOIN product_details on product_details.PROD_ID = `orders`.PROD_ID inner join product on product.PRO_ID= product_details.PRO_ID WHERE `orders`. DATE > '2021-10-05';

select s.SUPP_ID. SUPP_NAME from supplier s inner join rating r on s.SUPP_ID = r.SUPP_ID;

select s.SUPP_ID, s.SUPP_NAME, r.RAT_RATSTARS from supplier s inner JOIN rating r on s.SUPP_ID = r.SUPP_ID order by r.RAT_RATSTARS desc limit 3;

select supplier.SUPP_ID, supplier.SUPP_NAME, customer.CUS_NAME, rating.RAT_RATSTARS from supplier inner JOIN rating on supplier.SUPP_ID=rating.SUPP_ID INNER JOIN customer on rating.CUS_ID = customer.CUS_ID order by rating.RAT_RATSTARS desc LIMIT 3;

select sum(ord_amount) from `orders` INNER join customer on `orders`.CUS_ID= customer.CUS_ID where customer.CUS_GENDER='M';

select sum(ord_amount) from `orders` INNER join customer on `orders`.CUS_ID= customer.CUS_ID and customer.CUS_GENDER='M';

select * from customer left OUTER join `orders` on customer.CUS_ID = `orders`.CUS_ID;

call supplierRatings();

