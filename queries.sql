-- QUERIES

-- QUERY 1
-- desc: Find the recipe with the most diverse set of ingredients.

SELECT r.RecipeID, r.RecipeName, COUNT(DISTINCT ri.ingredientID) AS IngredientCount
                FROM Recipe r
                JOIN recipe_ingredient ri ON r.RecipeID = ri.RecipeID
                GROUP BY r.RecipeID, r.RecipeName
                ORDER BY IngredientCount DESC
                LIMIT 1;

-- QUERY 2
-- desc: Calculate the average rating for each difficulty level of recipes, excluding recipes without reviews.

SELECT r.Difficulty, AVG(rv.Rating) AS AverageRating
                FROM Recipe r
                JOIN Reviews rv ON r.RecipeID = rv.RecipeID
                GROUP BY r.Difficulty;

-- QUERY 3
-- desc: Find the top 5 selling ingredients and calculate the total quantity sold in the year 2022.

SELECT i.IngredientID, i.Name AS IngredientName, SUM(si.Qty) AS TotalQuantitySold
                FROM Ingredients i
                JOIN supplier_ingredient si ON i.IngredientID = si.ingredientID
                JOIN Shipment s ON si.ingredientID = s.RecipeID
                WHERE YEAR(s.OrderDate) = 2022
                GROUP BY i.IngredientID, i.Name
                ORDER BY TotalQuantitySold DESC
                LIMIT 5;

-- QUERY 4
-- desc: Find all recipes per supplier that contain ingredients greater than the average quantity sold by the supplier.

SELECT s.SupplierID, s.Name AS SupplierName, i.IngredientID, i.Name AS IngredientName, ri.Qty AS IngredientQuantity
                FROM Suppliers s
                JOIN Ingredients i ON s.SupplierID = i.SupplierID
                JOIN supplier_ingredient ri ON i.IngredientID = ri.ingredientID
                WHERE ri.Qty > (
                    SELECT AVG(si.Qty)
                    FROM supplier_ingredient si
                    WHERE si.supplierID = s.SupplierID
                )
                ORDER BY s.SupplierID, i.IngredientID;


-- QUERY 5
-- desc: List the cuisine that has the largest delivery time per supplier for all states.

WITH AvgDeliveryPerSupplier AS (
                    SELECT
                        a.StateProvince,
                        s.Name AS SupplierName,
                        r.Cuisine,
                        DATEDIFF(ss.DeliveryDate, ss.OrderDate) AS DeliveryTime
                    FROM Shipment ss
                    JOIN Customers c ON ss.CustomerID = c.CustomerID
                    JOIN Address a ON c.AddressID = a.AddressID
                    JOIN Recipe r ON ss.RecipeID = r.RecipeID
                    JOIN Suppliers s ON r.RecipeID = s.SupplierID
                )
                SELECT StateProvince, SupplierName, Cuisine, MAX(DeliveryTime) AS MaxDeliveryTime
                FROM AvgDeliveryPerSupplier
                GROUP BY StateProvince, SupplierName;

-- QUERY 6
-- desc: Display top 5 recipes with ingredients and cooking time in descending order

SELECT R.RecipeName, R.TOTALTIME,
                (SELECT GROUP_CONCAT(I.Name)
                 FROM recipe_ingredient RI
                 JOIN Ingredients I ON RI.ingredientID = I.IngredientID
                 WHERE RI.RecipeID = R.RecipeID) AS Ingredients
                FROM Recipe R
                ORDER BY R.TOTALTIME DESC
                LIMIT 5;

-- QUERY 7
-- desc: Display top 5 customers who spent the most between June 2022 and January 2023

SELECT C.FirstName, C.LastName, SUM(BaseCost) AS TotalSpending
            FROM Customers C
            JOIN Subscription S ON C.SubscriptionID = S.SubscriptionID
            JOIN Shipment SH ON C.CustomerID = SH.CustomerID
            WHERE SH.OrderDate BETWEEN '2022-06-01' AND '2023-01-31'
            GROUP BY C.CustomerID
            ORDER BY TotalSpending DESC
            LIMIT 5;

-- QUERY 8
-- desc: Display delivery status for CustomerID 1 and OrderDate '2022-10-13'

SELECT ShipmentStatus, DeliveryDate, DATEDIFF(DeliveryDate, OrderDate) AS DaysForDelivery
                FROM Shipment
                WHERE CustomerID = $customerID
                  AND OrderDate = '$orderDate'
                  AND RecipeID = (
                      SELECT RecipeID
                      FROM Shipment
                      WHERE CustomerID = $customerID
                        AND OrderDate = '$orderDate'
                  );

-- QUERY 9
-- desc: List subscriptions with expiry date in less than 6 months

SELECT S.SubscriptionName, S.Description, S.BaseCost, S.DietaryRestrictions, C.customerID, C.FirstName, C.LastName 
    FROM Subscription S JOIN subscription_dates sd ON S.SubscriptionID = sd.SubscriptionID 
    JOIN Customers C ON C.CustomerID = sd.customerID 
    WHERE sd.endDate <= DATE_ADD(CURDATE(), INTERVAL 6 MONTH);

--QUERY 10
--desc: Select the recipe that has the highest number of allergens

SELECT r.RecipeID, r.RecipeName, COUNT(DISTINCT i.Allergen) AS NumAllergens
                FROM Recipe r
                JOIN recipe_ingredient ri ON r.RecipeID = ri.RecipeID
                JOIN Ingredients i ON ri.ingredientID = i.IngredientID
                WHERE i.Allergen IS NOT NULL
                GROUP BY r.RecipeID, r.RecipeName
                ORDER BY NumAllergens DESC
                LIMIT 1;

-- QUERY 11
-- desc: Average rating of recipes for each different ingredient, showing the bottom 10.

SELECT i.Name AS IngredientName, AVG(rv.Rating) AS AvgRating
                FROM Ingredients i
                JOIN recipe_ingredient ri ON i.IngredientID = ri.ingredientID
                JOIN Recipe r ON ri.RecipeID = r.RecipeID
                LEFT JOIN Reviews rv ON r.RecipeID = rv.RecipeID
                GROUP BY i.Name
                ORDER BY AvgRating ASC
                LIMIT 10;

-- QUERY 12
-- desc: Find the recipe with that require the most number of unique suppliers

WITH MaxSuppliers AS (
            SELECT MAX(UniqueSuppliersCount) AS MaxCount
            FROM (
                SELECT r.RecipeID, COUNT(DISTINCT si.supplierID) as UniqueSuppliersCount
                FROM Recipe r
                JOIN recipe_ingredient ri ON r.RecipeID = ri.RecipeID
                JOIN Ingredients i ON ri.ingredientID = i.IngredientID
                JOIN supplier_ingredient si ON i.IngredientID = si.ingredientID 
                GROUP BY r.RecipeID
                ) AS SQ
            )
        SELECT r.RecipeID, r.RecipeName, COUNT(DISTINCT si.supplierID) as UniqueSuppliersCount
        FROM Recipe r
        JOIN recipe_ingredient ri ON r.RecipeID = ri.RecipeID
        JOIN Ingredients i ON ri.ingredientID = i.IngredientID
        JOIN supplier_ingredient si ON i.IngredientID = si.ingredientID 
        GROUP BY r.RecipeID, r.RecipeName
        HAVING COUNT(DISTINCT si.supplierID) = (SELECT MaxCount FROM MaxSuppliers)
        ORDER BY UniqueSuppliersCount DESC;

-- QUERY 13
-- desc: Month over month % of total orders

WITH MonthlyTotal AS (
        SELECT
            YEAR(OrderDate) AS Year,
            MONTH(OrderDate) AS Month,
            Count(distinct ShipmentID) AS TotalOrders
        FROM Shipment
        GROUP BY 1,2
         )
        SELECT
        Year,
        Month,
        TotalOrders,
        LAG(TotalOrders) OVER(ORDER BY Year, Month) AS PreviousMonthOrders,
        CASE 
            WHEN LAG(TotalOrders) OVER(ORDER BY Year, Month) = 0 THEN NULL
            ELSE CONCAT(CAST(ROUND(((TotalOrders - LAG(TotalOrders) OVER(ORDER BY Year, Month)) / LAG(TotalOrders) OVER(ORDER BY Year, Month)) * 100,2) AS CHAR(25)),'%')
        END AS MoM_PercentChange
        FROM MonthlyTotal
        ORDER BY Year, Month;

-- QUERY 14
-- desc: Top 2 rated recipes for each Subcription name

WITH AvgRatings AS (
        SELECT
            s.SubscriptionName,
            r.RecipeName,
            SUM(rev.Rating) AS AverageRating
        FROM Reviews rev
        JOIN Recipe r ON rev.RecipeID = r.RecipeID
        JOIN recipe_subscription rs ON r.RecipeID = rs.RecipeID
        JOIN Subscription s ON rs.SubscriptionID = s.SubscriptionID
        GROUP BY s.SubscriptionName, r.RecipeName
        )
        SELECT * 
        FROM 
        (SELECT
        SubscriptionName,
        RecipeName,
        AverageRating,
        RANK() OVER(PARTITION BY SubscriptionName ORDER BY AverageRating DESC) as Ranking
        FROM AvgRatings
        ORDER BY SubscriptionName, Ranking) A 
        where Ranking<=2;

-- QUERY 15
-- desc: Recipes with ingredients that have the 'fish' allergen

SELECT DISTINCT
        r.RecipeID,
        r.RecipeName
        FROM Recipe r
        JOIN recipe_ingredient ri ON r.RecipeID = ri.RecipeID
        JOIN Ingredients i ON ri.ingredientID = i.IngredientID
        WHERE i.Allergen LIKE '%fish%'
        ORDER BY r.RecipeID;

-- QUERY 16
-- desc: Supplier of ingredient used in the most recipes

WITH IngredientUsage AS (
        SELECT
            ri.ingredientID,
            COUNT(DISTINCT ri.RecipeID) AS RecipeCount
        FROM recipe_ingredient ri
        GROUP BY ri.ingredientID
        ORDER BY RecipeCount DESC
        LIMIT 1
        )
        SELECT
        s.Name AS SupplierName,
        i.Name AS IngredientName,
        iu.RecipeCount
        FROM IngredientUsage iu
        JOIN Ingredients i ON iu.ingredientID = i.IngredientID
        JOIN supplier_ingredient si ON i.IngredientID = si.ingredientID
        JOIN Suppliers s ON si.supplierID = s.SupplierID;

-- QUERY 17
-- desc: Monthly Invoicing Breakdown by Supplier to accurately run analytics on billing, segmented by supplier and billing cycle

WITH invoicingBase AS
        (
            SELECT Suppliers.Name AS 'Supplier'
                 , Ingredients.Name AS 'Ingredient'
                 , supplier_ingredient.Purchase_date AS 'Purchase Date'
                 , supplier_ingredient.Qty AS 'Purchase Quantity'
                 , Ingredients.buyPrice AS 'Unit Price'
                 , ROUND(Ingredients.buyPrice * supplier_ingredient.Qty,2) AS 'Amount Paid'
            FROM supplier_ingredient
            JOIN Suppliers
                ON Suppliers.SupplierID = supplier_ingredient.supplierID
            JOIN Ingredients
                ON supplier_ingredient.ingredientID = Ingredients.IngredientID
        )
        SELECT Supplier
             , DATE_FORMAT(`Purchase Date`, '%Y-%m') AS 'Year-Month'
             , ROUND(SUM(`Amount Paid`),2) AS 'Total Paid'
        FROM invoicingBase
        GROUP BY 1,2
        ORDER BY 1 ASC, 2 ASC;

-- QUERY 18
--desc: Inventory Planning: breaking down In Stock Quantity into 5 buckets based on their expiration to improve buying decisions

WITH InventoryExpiry AS
        (
            SELECT IngredientID
                , InStockQty
                , CASE WHEN Expiry < 15 THEN '1 - Expiring within 15 Days'
                       WHEN Expiry < 30 THEN '2 - Expiring within 30 Days'
                       WHEN Expiry < 60 THEN '3 - Expiring within 2 Months'
                       WHEN Expiry < 90 THEN '4 - Expiring within 3 Months'
                       ELSE '5 - Expiring after 3 months' END AS ExpirationClass
            FROM Ingredients
        )
        SELECT ExpirationClass
            , SUM(InStockQty) AS 'In Stock Quantity'
        FROM InventoryExpiry
        GROUP BY 1;

-- QUERY 19
--desc: Breakdown of Payment Method by Credit Card Issuer for Partnering with Credit Card Issuers for higher reward points if a certain card is used

WITH monthstobepaid AS (
            SELECT sd.SubscriptionID, TIMESTAMPDIFF(MONTH, sd.startDate, sd.endDate) as Months
            FROM subscription_dates sd
        ) 
        SELECT 
            pi.CreditCardIssuer, 
            COUNT(pi.PaymentMethodID) as NumberofUsers, 
            ROUND(SUM(s.BaseCost * m.Months),2) as TotalAmountPaid
        FROM 
            PaymentInfo pi
        JOIN 
            Customers c ON pi.PaymentMethodID = c.PaymentMethodID
        JOIN 
            Subscription s ON c.SubscriptionID = s.SubscriptionID
        JOIN 
            monthstobepaid m ON c.SubscriptionID = m.SubscriptionID
        GROUP BY 
            pi.CreditCardIssuer
        ORDER BY NumberofUsers DESC, TotalAmountPaid DESC;

-- QUERY 20
-- desc: List key supplier providing most ingredients

SELECT S.Name AS SupplierName, COUNT(I.IngredientID) AS IngredientCount
                FROM Suppliers S
                JOIN Ingredients I ON S.SupplierID = I.SupplierID
                GROUP BY S.SupplierID
                ORDER BY IngredientCount DESC
                LIMIT 1;

