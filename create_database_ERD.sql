
-- CREATE TABLE
-- Create table statements are in the correct order so that they can be added one by one without any dependencies issues
-- Address
CREATE TABLE Address (
    AddressID INT PRIMARY KEY NOT NULL,
    StreetAddress VARCHAR(200) NOT NULL,
    City VARCHAR(100) NOT NULL,
    StateProvince VARCHAR(100) NOT NULL,
    Country VARCHAR(150) NOT NULL,
    ZIPCode VARCHAR(20) NOT NULL
);

-- Recipe
CREATE TABLE Recipe (
    RecipeID INT PRIMARY KEY NOT NULL,
    RecipeName VARCHAR(200) NOT NULL,
    Description TEXT NOT NULL,
    PREPTIME INT NOT NULL,
    TOTALTIME INT NOT NULL,
    Difficulty VARCHAR(100) NOT NULL,
    Cuisine VARCHAR(100) NOT NULL
);

-- Suppliers (before Ingredients because Ingredients references this)
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(100) NOT NULL,
    AddressID INT NOT NULL,
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Ingredients
CREATE TABLE Ingredients (
    IngredientID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(100) NOT NULL,
    SupplierID INT NOT NULL,
    InStockQty INT NOT NULL,
    UnitOfMeasurement VARCHAR(100) NOT NULL,
    buyPrice DOUBLE NOT NULL,
    Expiry INT,
    Allergen VARCHAR(100),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Subscription
CREATE TABLE Subscription (
    SubscriptionID INT PRIMARY KEY NOT NULL,
    SubscriptionName VARCHAR(100) NOT NULL,
    Description VARCHAR(100),
    BaseCost DOUBLE NOT NULL,
    DietaryRestrictions VARCHAR(200)
);

-- PaymentInfo
CREATE TABLE PaymentInfo (
    PaymentMethodID VARCHAR(100) PRIMARY KEY NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    CreditCardIssuer VARCHAR(100) NOT NULL,
    CreditCardToken VARCHAR(255) NOT NULL,
    AddressID INT NOT NULL,
    CardExpiry DATE NOT NULL,
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    SubscriptionID INT,
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    AddressID INT NOT NULL,
    PaymentMethodID VARCHAR(100),
    FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentInfo(PaymentMethodID)
);

-- Shipment
CREATE TABLE Shipment (
    ShipmentID INT PRIMARY KEY NOT NULL,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    ShipmentStatus VARCHAR(100) NOT NULL,
    PaymentStatus VARCHAR(100) NOT NULL,
    DeliveryDate DATE NOT NULL,
    RecipeID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID)
);

-- Reviews
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY NOT NULL,
    CustomerID INT NOT NULL,
    RecipeID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating >= 0 AND Rating <= 5),
    Comments VARCHAR(500),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID)
);

-- subscription_dates
CREATE TABLE subscription_dates (
    customerID INT NOT NULL,
    SubscriptionID INT NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    PRIMARY KEY (customerID, subscriptionID),
    FOREIGN KEY (customerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (subscriptionID) REFERENCES Subscription(SubscriptionID)
);

-- supplier_ingredient
CREATE TABLE supplier_ingredient (
    ingredientID INT NOT NULL,
    supplierID INT NOT NULL,
    Purchase_date DATE NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY (ingredientID, supplierID),
    FOREIGN KEY (ingredientID) REFERENCES Ingredients(IngredientID),
    FOREIGN KEY (supplierID) REFERENCES Suppliers(SupplierID)
);

-- recipe_subscription
CREATE TABLE recipe_subscription(
    subscriptionID INT NOT NULL,
    RecipeID INT NOT NULL,
    PRIMARY KEY (subscriptionID, RecipeID),
    FOREIGN KEY (subscriptionID) REFERENCES Subscription(SubscriptionID),
    FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID)
);

-- recipe_ingredient
CREATE TABLE recipe_ingredient (
    ingredientID INT NOT NULL,
    RecipeID INT NOT NULL,
    nb_ingredients INT NOT NULL,
    PRIMARY KEY (ingredientID, RecipeID),
    FOREIGN KEY (ingredientID) REFERENCES Ingredients(IngredientID),
    FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID)
);


/* Address insert statements*/

INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (1, '123 Elm St', 'Montreal', 'QC', 'Canada', '62704');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (2, '456 Maple Ave', 'Boston', 'MA', 'USA', '62521');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (3, '789 Oak Blvd', 'Montreal', 'QC', 'Canada', '62701');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (4, '101 Pine Lane', 'Boston', 'MA', 'USA', '62702');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (5, '202 Cedar Rd', 'Montreal', 'QC', 'Canada', '62703');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (6, '303 Birch Dr', 'Boston', 'MA', 'USA', '62705');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (7, '404 Redwood St', 'Montreal', 'QC', 'Canada', '62706');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (8, '505 Fir Ct', 'Boston', 'MA', 'USA', '62707');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (9, '606 Spruce Way', 'Montreal', 'QC', 'Canada', '62708');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (10, '707 Chestnut St', 'Boston', 'MA', 'USA', '62709');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (11, '808 Willow Rd', 'Montreal', 'QC', 'Canada', '62710');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (12, '910 Ash Ln', 'Boston', 'MA', 'USA', '62711');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (13, '1011 Cedar Dr', 'Montreal', 'QC', 'Canada', '62712');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (14, '1112 Maple St', 'Boston', 'MA', 'USA', '62713');
INSERT INTO Address (AddressID, StreetAddress, City, StateProvince, Country, ZIPCode) VALUES (15, '1213 Oak Ave', 'Montreal', 'QC', 'Canada', '62714');

/*Recipe insert statements*/

INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (1, 'Grilled Steak with Asparagus and Mushrooms', 'Savory grilled steak paired with tender asparagus and sautéed mushrooms.', 20, 40, 'Medium', 'American');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (2, 'Lamb Chops with Brussels Sprouts', 'Juicy lamb chops complemented by roasted Brussels sprouts.', 15, 45, 'Medium', 'European');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (3, 'Baked Salmon with Broccoli and Lemon Butter', 'Delicate salmon fillet baked with fresh broccoli and tangy lemon butter sauce.', 10, 30, 'Easy', 'American');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (4, 'Spiced Chicken Thighs with Caramelized Onions and Peppers', 'Spicy chicken thighs paired with sweet caramelized onions and bell peppers.', 25, 50, 'Medium', 'International');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (5, 'Steak Fajita Bowls', 'Juicy steak slices served in a bowl with fajita veggies and rice.', 20, 40, 'Medium', 'Mexican');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (6, 'Salmon with Mango Salsa', 'Baked salmon topped with a refreshing mango salsa.', 15, 30, 'Easy', 'Tropical');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (7, 'Shrimp Pasta with Garlic and Chili', 'Pasta tossed with spicy shrimp, garlic, and chili.', 15, 30, 'Easy', 'Italian');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (8, 'Seared Tuna Salad', 'Fresh tuna seared to perfection, served over a bed of mixed greens.', 10, 20, 'Easy', 'Mediterranean');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (9, 'Mussels in White Wine Sauce', 'Mussels steamed in a delicious garlic and white wine sauce.', 10, 30, 'Medium', 'European');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (10, 'Thai Green Curry', 'A rich and creamy green curry with a hint of spice.', 20, 40, 'Medium', 'Thai');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (11, 'Chickpea Spinach Curry', 'A hearty vegetarian curry made with chickpeas and spinach.', 15, 35, 'Easy', 'Indian');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (12, 'Lentil Soup', 'A nourishing soup made with lentils and vegetables.', 10, 40, 'Easy', 'Mediterranean');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (13, 'Stuffed Bell Peppers', 'Bell peppers stuffed with a savory rice and meat mixture.', 30, 60, 'Medium', 'American');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (14, 'Classic Family-Friendly Cheese Burger', 'Juicy burger with cheese, lettuce, tomato, and onions.', 15, 30, 'Easy', 'American');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (15, 'Vegetable Pasta', 'Pasta tossed with fresh sautéed vegetables and herbs.', 10, 25, 'Easy', 'Italian');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (16, 'Chicken Tenders', 'Crispy breaded chicken tenders served with a side of dipping sauce.', 10, 30, 'Easy', 'American');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (17, 'Vegetable Quesadillas', 'Crispy tortillas filled with sautéed vegetables and cheese.', 15, 30, 'Easy', 'Mexican');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (18, 'Chicken Salad with Avocado Dressing', 'Refreshing salad topped with grilled chicken and creamy avocado dressing.', 20, 40, 'Easy', 'International');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (19, 'Shrimp and Asparagus Stir-Fry', 'Shrimp and asparagus cooked in a savory sauce.', 15, 25, 'Medium', 'Asian');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (20, 'Broccoli and Beef Bowl', 'Savory beef strips stir-fried with broccoli florets.', 20, 35, 'Medium', 'Asian');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (21, 'Zucchini Noodle Spaghetti with Turkey Meatballs', 'A low-carb take on spaghetti using zucchini noodles and turkey meatballs.', 20, 45, 'Medium', 'Italian');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (22, 'Chicken Stir-Fry', 'Chicken pieces stir-fried with mixed vegetables in a tangy sauce.', 15, 30, 'Medium', 'Asian');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (23, 'Caprese Avocado Toast', 'Toasted bread topped with mozzarella, tomatoes, basil, and avocado slices.', 5, 10, 'Easy', 'Mediterranean');
INSERT INTO Recipe (RecipeID, RecipeName, Description, PREPTIME, TOTALTIME, Difficulty, Cuisine) VALUES (24, 'Cheesy Chicken and Broccoli', 'Baked chicken and broccoli in a creamy cheese sauce.', 15, 40, 'Medium', 'American');

/*Supplier insert statements*/

INSERT INTO Suppliers (SupplierID, Name, Email, Phone, AddressID) VALUES (1, 'FreshHarvest Delights', 'steve@FHDelight.com', '123-456-780', 11);
INSERT INTO Suppliers (SupplierID, Name, Email, Phone, AddressID) VALUES (2, 'GourmetGateway', 'melissa@gourmetgateway.com', '123-456-781', 12);
INSERT INTO Suppliers (SupplierID, Name, Email, Phone, AddressID) VALUES (3, 'GreenGrove Goods', 'supplier@greengrovecatering.com', '123-456-782', 13);
INSERT INTO Suppliers (SupplierID, Name, Email, Phone, AddressID) VALUES (4, 'OceanTide Seafoods', 'contact@ots.food.com', '123-456-783', 14);
INSERT INTO Suppliers (SupplierID, Name, Email, Phone, AddressID) VALUES (5, 'Sunlit Groceries Inc.', 'sales@sunlitgroceries.com', '123-456-784', 15);

/*Ingredient insert statements*/

INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (1, 'Steak', 1, '', 72, 'pieces', 6.71, 140);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (2, 'Salt', 2, '', 20, 'grams', 0.78, 52);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (3, 'Pepper', 3, '', 28, 'grams', 1.3, 116);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (4, 'Olive oil', 4, '', 48, 'liters', 7.88, 27);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (5, 'Asparagus', 5, '', 74, 'cups', 6.2, 163);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (6, 'Garlic cloves', 1, '', 39, 'pieces', 3.95, 114);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (7, 'Butter', 2, 'Milk', 40, 'grams', 3.59, 137);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (8, 'Parsley', 3, '', 100, 'grams', 3.13, 161);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (9, 'Lamb chop', 4, '', 83, 'pieces', 3.9, 164);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (10, 'Rosemary', 5, '', 36, 'tablespoons', 3.51, 85);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (11, 'Brussels sprouts', 1, '', 83, 'cups', 2.84, 150);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (12, 'Balsamic vinegar', 2, '', 68, 'milliliters', 1.58, 14);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (13, 'Salmon fillet', 3, 'Fish', 73, 'pieces', 8.32, 88);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (14, 'Lemon', 4, '', 41, 'pieces', 4.05, 159);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (15, 'Broccoli', 5, '', 88, 'cups', 1.08, 23);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (16, 'Chicken Thigh', 1, '', 38, 'pieces', 19.44, 41);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (17, 'Paprika', 2, '', 97, 'teaspoons', 3.57, 130);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (18, 'Cumin', 3, '', 33, 'teaspoons', 1.82, 143);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (19, 'Onion', 4, '', 91, 'cups', 1.54, 136);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (20, 'Bell pepper', 5, '', 78, 'cups', 1.42, 134);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (21, 'Chili', 1, '', 97, 'teaspoons', 2.0, 144);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (22, 'Rice', 2, '', 27, 'cups', 2.97, 359);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (23, 'Mango', 3, '', 38, 'pieces', 4.51, 175);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (24, 'Jalapeno', 4, '', 50, 'cups', 17.12, 63);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (25, 'Cilantro', 5, '', 78, 'teaspoons', 7.21, 158);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (26, 'Lime', 1, '', 35, 'pieces', 1.31, 129);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (27, 'Spaghetti pasta', 2, 'Wheat', 31, 'grams', 4.4, 100);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (28, 'Shrimp', 3, 'Shellfish', 77, 'cups', 1.26, 45);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (29, 'Tuna steak', 4, 'Fish', 3, 'pieces', 0.86, 101);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (30, 'Arugula', 5, '', 11, 'pieces', 0.9, 145);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (31, 'Spinach', 1, '', 41, 'cups', 4.25, 80);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (32, 'Romaine', 2, '', 91, 'cups', 0.52, 46);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (33, 'Tomato', 3, '', 80, 'grams', 1.67, 95);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (34, 'Cucumber', 4, '', 33, 'pieces', 3.86, 95);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (35, 'Mussels', 5, 'Shellfish', 92, 'grams', 10.21, 127);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (36, 'White wine', 1, '', 38, 'milliliters', 2.88, 127);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (37, 'Cocunut milk', 2, '', 81, 'milliliters', 4.32, 180);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (38, 'Curry paste', 3, '', 52, 'milliliters', 2.05, 40);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (39, 'Zucchini', 4, '', 13, 'pieces', 0.81, 174);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (40, 'Snap peas', 5, '', 34, 'cups', 2.52, 78);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (41, 'Tofu', 1, 'Soy', 95, 'grams', 3.61, 72);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (42, 'Soy sauce', 2, 'Soy', 65, 'teaspoons', 1.77, 126);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (43, 'Sugar', 3, '', 48, 'grams', 1.02, 75);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (44, 'Basil', 4, '', 43, 'teaspoons', 2.83, 109);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (45, 'Chickpeas', 5, '', 26, 'grams', 1.6, 104);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (46, 'Green lentils', 1, '', 51, 'milliliters', 4.26, 29);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (47, 'Carrot', 2, '', 73, 'milliliters', 0.69, 107);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (48, 'Vegetable broth', 3, '', 33, 'milliliters', 1.59, 101);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (49, 'Back beans', 4, '', 74, 'grams', 1.43, 128);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (50, 'Corn kernel', 5, '', 91, 'tablespoons', 1.58, 146);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (51, 'Salsa', 1, '', 90, 'teaspoons', 0.72, 29);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (52, 'Ground beef', 2, '', 61, 'cups', 1.65, 117);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (53, 'Burger buns', 3, 'Wheat', 52, 'grams', 4.28, 121);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (54, 'Lettuce', 4, '', 69, 'tablespoons', 1.39, 47);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (55, 'Pickles', 5, '', 24, 'liters', 2.07, 44);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (56, 'Cheddar', 1, 'Milk', 20, 'milliliters', 1.72, 47);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (57, 'Marinara ', 2, '', 15, 'tablespoons', 4.2, 75);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (58, 'Breadcrumbs', 3, 'Wheat', 96, 'tablespoons', 4.26, 31);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (59, 'Parmesan', 4, 'Milk', 99, 'cups', 19.18, 13);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (60, 'Eggs', 5, 'Eggs', 55, 'pieces', 0.73, 153);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (61, 'Tortilla', 1, 'Wheat', 62, 'pieces', 2.8, 54);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (62, 'Sour cream', 2, 'Milk', 16, 'cups', 1.97, 168);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (63, 'Chicken Breast', 3, '', 5, 'pieces', 2.03, 93);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (64, 'Avocado', 4, '', 9, 'pieces', 0.63, 55);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (65, 'Greek yogurt', 5, 'Milk', 18, 'liters', 0.64, 70);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (66, 'Ginger', 1, '', 41, 'teaspoons', 0.79, 175);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (67, 'Sesame seeds', 2, '', 82, 'teaspoons', 3.93, 83);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (68, 'Ground turkey', 3, '', 28, 'grams', 3.96, 10);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (69, 'Almond flour', 4, 'Tree nuts', 33, 'grams', 2.59, 15);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (70, 'Slice of bread', 5, 'Wheat', 88, 'grams', 3.95, 169);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (71, 'Mozarella', 1, 'Milk', 72, 'grams', 4.16, 108);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (72, 'Chicken broth', 2, '', 62, 'cups', 4.52, 117);
INSERT INTO Ingredients (IngredientID, Name, SupplierID, Allergen, InStockQty, UnitOfMeasurement, BuyPrice, Expiry) VALUES (73, 'Cream', 3, 'Milk', 26, 'milliliters', 4.66, 175);

/*Subscription insert statements*/

INSERT INTO Subscription (SubscriptionID, SubscriptionName, Description, BaseCost, DietaryRestrictions) VALUES (1, 'Meat and veggies', 'can''t go wrong with the classics', 32.78, '');
INSERT INTO Subscription (SubscriptionID, SubscriptionName, Description, BaseCost, DietaryRestrictions) VALUES (2, 'Veggie', 'perfect for vegans and vegetarians', 29.23, 'No meat, plant-based');
INSERT INTO Subscription (SubscriptionID, SubscriptionName, Description, BaseCost, DietaryRestrictions) VALUES (3, 'Family friendly', 'picky eaters approved', 19.89, '');
INSERT INTO Subscription (SubscriptionID, SubscriptionName, Description, BaseCost, DietaryRestrictions) VALUES (4, 'Fit and wholesome', 'calorie smart & carb smart meals', 30.97, 'Low carb, high protein');
INSERT INTO Subscription (SubscriptionID, SubscriptionName, Description, BaseCost, DietaryRestrictions) VALUES (5, 'Quick and easy', '20 min or less', 15.91, '');
INSERT INTO Subscription (SubscriptionID, SubscriptionName, Description, BaseCost, DietaryRestrictions) VALUES (6, 'Pescatarian', 'sustainably sourced seafood', 39.71, 'No meat, fish allowed');

/*recipe_subscription insert statements*/

INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (1, 1);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (1, 2);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (1, 3);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (1, 4);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (1, 5);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (2, 6);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (2, 7);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (2, 8);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (2, 9);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (3, 10);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (3, 11);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (3, 12);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (3, 13);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (4, 14);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (4, 15);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (3, 15);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (4, 16);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (4, 17);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (3, 17);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (5, 18);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (5, 19);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (5, 20);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (5, 21);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (6, 22);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (6, 23);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (3, 23);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (6, 7);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (6, 24);
INSERT INTO recipe_subscription (subscriptionID, RecipeID) VALUES (4, 24);

/*recipe_ingredient insert statements*/

INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (15, 3, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (22, 5, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 11, 3);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 2, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (39, 21, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (33, 11, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (14, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 16, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (18, 12, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (11, 2, 12);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (70, 23, 4);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (19, 9, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (8, 12, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (56, 14, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (32, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (56, 24, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 16, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 24, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 12, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 1, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (21, 5, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (7, 14, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (52, 20, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 2, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (15, 24, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (7, 1, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (39, 15, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (20, 5, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (47, 12, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (8, 9, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 7, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 8, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (12, 2, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 13, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (65, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (32, 8, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (29, 8, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (51, 13, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 1, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 14, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (21, 7, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (67, 20, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (57, 15, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (26, 6, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (42, 22, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (20, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (56, 17, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 24, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (52, 14, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (19, 5, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (19, 14, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (20, 17, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (63, 22, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (60, 21, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (64, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (19, 12, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (58, 16, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (44, 23, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (17, 24, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (5, 19, 16);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 11, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 16, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 14, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (61, 17, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (43, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (13, 6, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (37, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (18, 11, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (44, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (49, 13, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (42, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (20, 4, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 4, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (42, 19, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (18, 13, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (66, 19, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (46, 12, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (15, 20, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (64, 23, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (9, 2, 4);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (27, 15, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 4, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (24, 6, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 6, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (28, 19, 20);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (33, 14, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 9, 4);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (72, 24, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 24, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (21, 11, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 4, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 19, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (73, 24, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 3, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (40, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (36, 9, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (53, 14, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 13, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (55, 14, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 8, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 24, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (31, 17, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 15, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (34, 8, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (38, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 14, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (30, 8, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (16, 4, 4);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 12, 3);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 5, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (18, 4, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 12, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (33, 12, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (35, 9, 50);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (31, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (19, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (63, 24, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 1, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (27, 7, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (59, 16, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (62, 17, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (66, 22, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 13, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (63, 18, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (19, 15, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 21, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (28, 7, 20);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (19, 11, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (17, 12, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (41, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 6, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 7, 4);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (21, 13, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 6, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (69, 21, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 11, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 1, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (25, 6, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (66, 20, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (8, 7, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (14, 8, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (17, 4, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 21, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (50, 13, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (47, 22, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 20, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 9, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (30, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (5, 1, 8);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (19, 6, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (10, 2, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (20, 13, 4);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 2, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (13, 3, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (48, 12, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (71, 23, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (1, 5, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (33, 8, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 22, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (19, 4, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (6, 22, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (33, 17, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (20, 15, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (68, 21, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 5, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (45, 11, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (8, 1, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (42, 20, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (39, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (23, 6, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (31, 8, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 8, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (31, 11, 4);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (54, 14, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (22, 13, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (38, 11, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (20, 22, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 3, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 3, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (3, 5, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (33, 23, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (26, 10, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (34, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (16, 16, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (60, 16, 2);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (33, 18, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 5, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (1, 1, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (7, 3, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (14, 3, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (2, 12, 1);
INSERT INTO recipe_ingredient (ingredientID, RecipeID, nb_ingredients) VALUES (4, 20, 1);

/*supplier ingredient insert statements*/

INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (1, 1, '2022-09-02', 73);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (2, 2, '2022-12-13', 71);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (3, 3, '2022-10-01', 28);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (4, 4, '2023-03-25', 98);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (5, 5, '2022-09-15', 85);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (6, 1, '2023-06-07', 31);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (7, 2, '2023-05-01', 81);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (8, 3, '2023-02-12', 95);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (9, 4, '2023-07-04', 54);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (10, 5, '2022-12-21', 45);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (11, 1, '2023-01-05', 36);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (12, 2, '2023-01-18', 27);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (13, 3, '2023-03-03', 49);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (14, 4, '2022-11-26', 69);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (15, 5, '2023-02-28', 26);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (16, 1, '2022-10-20', 59);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (17, 2, '2022-08-27', 96);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (18, 3, '2023-03-21', 30);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (19, 4, '2022-10-11', 40);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (20, 5, '2023-06-15', 94);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (21, 1, '2023-07-01', 99);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (22, 2, '2022-11-16', 78);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (23, 3, '2023-04-12', 86);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (24, 4, '2023-05-09', 61);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (25, 5, '2022-08-23', 66);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (26, 1, '2023-06-20', 50);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (27, 2, '2022-09-17', 87);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (28, 3, '2023-02-09', 92);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (29, 4, '2023-04-29', 62);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (30, 5, '2022-12-04', 29);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (31, 1, '2023-08-03', 56);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (32, 2, '2022-12-19', 83);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (33, 3, '2023-07-18', 88);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (34, 4, '2022-08-29', 53);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (35, 5, '2023-03-07', 89);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (36, 1, '2022-10-05', 77);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (37, 2, '2023-01-23', 64);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (38, 3, '2023-05-25', 91);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (39, 4, '2023-04-06', 67);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (40, 5, '2022-12-28', 57);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (41, 1, '2023-07-13', 25);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (42, 2, '2022-09-09', 46);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (43, 3, '2023-06-09', 79);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (44, 4, '2022-09-03', 52);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (45, 5, '2022-08-31', 90);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (46, 1, '2023-08-18', 55);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (47, 2, '2023-04-19', 32);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (48, 3, '2022-11-24', 58);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (49, 4, '2022-09-21', 84);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (50, 5, '2023-08-09', 65);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (51, 1, '2022-12-30', 47);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (52, 2, '2023-03-11', 37);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (53, 3, '2022-10-15', 82);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (54, 4, '2022-11-12', 76);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (55, 5, '2022-10-26', 38);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (56, 1, '2023-02-05', 33);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (57, 2, '2022-08-25', 63);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (58, 3, '2023-03-15', 43);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (59, 4, '2023-05-03', 74);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (60, 5, '2023-07-24', 75);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (61, 1, '2023-03-31', 97);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (62, 2, '2022-11-03', 93);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (63, 3, '2023-04-01', 42);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (64, 4, '2022-12-01', 48);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (65, 5, '2023-06-29', 60);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (66, 1, '2022-10-03', 70);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (67, 2, '2022-11-06', 35);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (68, 3, '2023-02-16', 51);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (69, 4, '2023-01-15', 39);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (70, 5, '2023-06-19', 34);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (71, 1, '2023-08-06', 100);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (72, 2, '2023-01-29', 22);
INSERT INTO supplier_ingredient (ingredientID, supplierID, Purchase_date, Qty) VALUES (73, 3, '2023-05-19', 72);

/*Payment Info insert statements*/

INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('1', 'John', 'Doe', 'Discover', 'hash1xxxxxxxxxxxxx', 1, '2025-09-11');
INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('2', 'Jane', 'Smith', 'Amex', 'hash2xxxxxxxxxxxxx', 2, '2023-12-16');
INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('3', 'Robert', 'Brown', 'Visa', 'hash3xxxxxxxxxxxxx', 3, '2028-03-26');
INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('4', 'Emily', 'Johnson', 'Mastercard', 'hash4xxxxxxxxxxxxx', 4, '2024-07-13');
INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('5', 'William', 'Jones', 'Discover', 'hash5xxxxxxxxxxxxx', 5, '2026-05-19');
INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('6', 'Olivia', 'Davis', 'Amex', 'hash6xxxxxxxxxxxxx', 6, '2027-11-22');
INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('7', 'James', 'Miller', 'Visa', 'hash7xxxxxxxxxxxxx', 7, '2022-02-10');
INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('8', 'Sophia', 'Wilson', 'Mastercard', 'hash8xxxxxxxxxxxxx', 8, '2029-08-01');
INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('9', 'David', 'Taylor', 'Discover', 'hash9xxxxxxxxxxxxx', 9, '2023-04-17');
INSERT INTO PaymentInfo (PaymentMethodID, FirstName, LastName, CreditCardIssuer, CreditCardToken, AddressID, CardExpiry) VALUES ('10', 'Grace', 'Harris', 'Amex', 'hash10xxxxxxxxxxxxx', 10, '2025-06-30');


/*Customers insert statements*/

INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (1, 'John', 'Doe', 1, 'john.doe@outlook.com', '123-456-7810', 1, '1');
INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (2, 'Jane', 'Smith', 2, 'jane.smith@gmail.com', '123-456-7820', 2, '2');
INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (3, 'Robert', 'Brown', 3, 'robert.brown@outlook.com', '123-456-7830', 3, '3');
INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (4, 'Emily', 'Johnson', 4, 'emily.johnson@ejohnson.com', '123-456-7840', 4, '4');
INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (5, 'William', 'Jones', 5, 'william.jones@gmail.com', '123-456-7850', 5, '5');
INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (6, 'Olivia', 'Davis', 6, 'olivia.davis@example.com', '123-456-7860', 6, '6');
INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (7, 'James', 'Miller', 2, 'james.miller@outlook.com', '123-456-7870', 7, '7');
INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (8, 'Sophia', 'Wilson', 3, 'sophia.wilson@example.com', '123-456-7880', 8, '8');
INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (9, 'David', 'Taylor', 4, 'david.taylor@outlook.com', '123-456-7890', 9, '9');
INSERT INTO Customers (CustomerID, FirstName, LastName, SubscriptionID, Email, PhoneNumber, AddressID, PaymentMethodID) VALUES (10, 'Grace', 'Harris', 6, 'grace.harris@gmail.com', '123-456-7801', 10, '10');

/*Shipment insert statements*/

INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (1, 1, '2022-10-13', 'Shipped', 'Processing', '2022-10-16', 12);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (2, 1, '2023-07-05', 'Delivered', 'Processing', '2023-07-08', 8);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (3, 1, '2022-08-23', 'Delivered', 'Processing', '2022-08-26', 13);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (4, 1, '2022-12-04', 'Delivered', 'Paid', '2022-12-07', 21);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (5, 1, '2023-02-25', 'Shipped', 'Paid', '2023-02-28', 2);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (6, 1, '2023-02-17', 'Shipped', 'Paid', '2023-02-20', 15);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (7, 1, '2022-07-01', 'Delivered', 'Processing', '2022-07-04', 14);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (8, 1, '2022-10-15', 'Delivered', 'Paid', '2022-10-18', 3);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (9, 1, '2022-10-31', 'Shipped', 'Paid', '2022-11-03', 7);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (10, 1, '2022-12-01', 'Shipped', 'Processing', '2022-12-04', 16);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (11, 2, '2022-10-04', 'Delivered', 'Paid', '2022-10-07', 6);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (12, 2, '2023-06-05', 'Delivered', 'Paid', '2023-06-08', 10);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (13, 2, '2022-09-25', 'Delivered', 'Processing', '2022-09-28', 17);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (14, 2, '2023-03-01', 'Shipped', 'Paid', '2023-03-04', 5);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (15, 2, '2023-03-10', 'Shipped', 'Paid', '2023-03-13', 20);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (16, 2, '2022-09-02', 'Delivered', 'Paid', '2022-09-05', 23);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (17, 2, '2022-07-18', 'Shipped', 'Processing', '2022-07-21', 11);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (18, 2, '2023-01-10', 'Delivered', 'Paid', '2023-01-13', 19);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (19, 2, '2022-11-15', 'Cancelled', 'Paid', '2022-11-18', 9);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (20, 2, '2023-05-05', 'Delivered', 'Processing', '2023-05-08', 4);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (21, 3, '2023-05-01', 'Shipped', 'Processing', '2023-05-04', 22);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (22, 3, '2022-12-15', 'Shipped', 'Paid', '2022-12-18', 1);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (23, 3, '2023-01-05', 'Shipped', 'Processing', '2023-01-08', 24);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (24, 3, '2022-07-15', 'Delivered', 'Paid', '2022-07-18', 2);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (25, 3, '2023-04-20', 'Delivered', 'Paid', '2023-04-23', 3);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (26, 3, '2022-09-10', 'Delivered', 'Processing', '2022-09-13', 5);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (27, 3, '2023-01-12', 'Delivered', 'Processing', '2023-01-15', 6);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (28, 3, '2023-03-25', 'Shipped', 'Paid', '2023-03-28', 7);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (29, 3, '2022-08-25', 'Delivered', 'Paid', '2022-08-28', 10);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (30, 3, '2023-06-10', 'Delivered', 'Paid', '2023-06-13', 11);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (31, 4, '2022-10-10', 'Delivered', 'Paid', '2022-10-13', 12);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (32, 4, '2023-02-20', 'Delivered', 'Paid', '2023-02-23', 13);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (33, 4, '2022-09-15', 'Delivered', 'Processing', '2022-09-18', 14);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (34, 4, '2022-11-25', 'Delivered', 'Processing', '2022-11-28', 15);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (35, 4, '2023-03-05', 'Delivered', 'Processing', '2023-03-08', 16);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (36, 4, '2023-04-10', 'Shipped', 'Paid', '2023-04-13', 17);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (37, 4, '2022-08-05', 'Delivered', 'Paid', '2022-08-08', 18);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (38, 4, '2023-01-15', 'Delivered', 'Paid', '2023-01-18', 19);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (39, 4, '2023-05-15', 'Delivered', 'Processing', '2023-05-18', 20);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (40, 4, '2022-12-20', 'Delivered', 'Paid', '2022-12-23', 21);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (41, 5, '2022-07-15', 'Delivered', 'Paid', '2022-07-18', 22);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (42, 5, '2023-04-25', 'Delivered', 'Paid', '2023-04-28', 23);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (43, 5, '2023-06-05', 'Delivered', 'Paid', '2023-06-08', 24);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (44, 5, '2022-08-10', 'Delivered', 'Paid', '2022-08-13', 1);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (45, 5, '2022-09-15', 'Delivered', 'Paid', '2022-09-18', 2);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (46, 5, '2022-12-10', 'Delivered', 'Paid', '2022-12-13', 3);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (47, 5, '2023-03-20', 'Delivered', 'Paid', '2023-03-23', 4);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (48, 5, '2023-02-05', 'Shipped', 'Paid', '2023-02-08', 5);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (49, 5, '2022-10-05', 'Cancelled', 'Paid', '2022-10-08', 6);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (50, 5, '2023-01-25', 'Shipped', 'Processing', '2023-01-28', 7);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (51, 6, '2022-07-10', 'Delivered', 'Paid', '2022-07-13', 8);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (52, 6, '2022-09-05', 'Delivered', 'Paid', '2022-09-08', 9);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (53, 6, '2023-05-01', 'Delivered', 'Processing', '2023-05-04', 10);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (54, 6, '2023-06-25', 'Delivered', 'Paid', '2023-06-28', 11);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (55, 6, '2023-03-15', 'Shipped', 'Paid', '2023-03-18', 12);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (56, 6, '2022-11-20', 'Delivered', 'Paid', '2022-11-23', 13);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (57, 6, '2023-04-10', 'Delivered', 'Paid', '2023-04-13', 14);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (58, 6, '2022-12-25', 'Delivered', 'Processing', '2022-12-28', 15);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (59, 6, '2023-02-15', 'Delivered', 'Processing', '2023-02-18', 16);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (60, 6, '2023-01-10', 'Shipped', 'Paid', '2023-01-13', 17);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (61, 7, '2022-09-15', 'Shipped', 'Paid', '2022-09-18', 18);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (62, 7, '2023-03-10', 'Delivered', 'Processing', '2023-03-13', 19);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (63, 7, '2023-04-05', 'Delivered', 'Processing', '2023-04-08', 20);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (64, 7, '2022-12-05', 'Delivered', 'Paid', '2022-12-08', 21);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (65, 7, '2023-01-20', 'Shipped', 'Paid', '2023-01-23', 22);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (66, 7, '2022-10-20', 'Cancelled', 'Processing', '2022-10-23', 23);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (67, 7, '2023-05-25', 'Shipped', 'Paid', '2023-05-28', 24);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (68, 7, '2022-11-10', 'Delivered', 'Paid', '2022-11-13', 1);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (69, 7, '2023-06-10', 'Delivered', 'Paid', '2023-06-13', 2);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (70, 7, '2022-08-25', 'Delivered', 'Processing', '2022-08-28', 3);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (71, 8, '2023-04-15', 'Delivered', 'Processing', '2023-04-18', 4);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (72, 8, '2022-09-05', 'Delivered', 'Paid', '2022-09-08', 5);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (73, 8, '2022-11-15', 'Delivered', 'Paid', '2022-11-18', 6);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (74, 8, '2023-02-20', 'Delivered', 'Processing', '2023-02-23', 7);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (75, 8, '2023-05-10', 'Delivered', 'Paid', '2023-05-13', 8);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (76, 8, '2022-10-25', 'Delivered', 'Paid', '2022-10-28', 9);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (77, 8, '2022-12-05', 'Delivered', 'Processing', '2022-12-08', 10);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (78, 8, '2023-03-20', 'Shipped', 'Paid', '2023-03-23', 11);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (79, 8, '2022-08-15', 'Delivered', 'Paid', '2022-08-18', 12);
INSERT INTO Shipment (ShipmentID, CustomerID, OrderDate, ShipmentStatus, PaymentStatus, DeliveryDate, RecipeID) VALUES (80, 8, '2023-01-25', 'Delivered', 'Processing', '2023-01-28', 13);

/*subscription dates insert statements*/

INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (1, 1, '2023-03-30', '2024-03-29');
INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (2, 2, '2022-09-10', '2024-09-10');
INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (3, 3, '2022-11-02', '2023-12-02');
INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (4, 4, '2023-07-01', '2024-06-30');
INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (5, 5, '2023-03-21', '2024-03-20');
INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (6, 6, '2023-04-14', '2024-04-13');
INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (7, 3, '2022-10-17', '2025-10-17');
INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (8, 4, '2022-10-22', '2025-10-22');
INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (9, 5, '2023-06-14', '2024-06-13');
INSERT INTO subscription_dates (customerID, subscriptionID, startDate, endDate) VALUES (10, 6, '2023-05-11', '2024-05-10');

/*Reviews insert statements*/

INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (1, 1, 1, 5, 'Amazing dish!');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (2, 2, 6, 4);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (3, 3, 10, 3);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (4, 4, 14, 2, 'Could be better.');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (5, 5, 18, 4);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (6, 6, 22, 3, 'Loved the flavors.');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (7, 7, 7, 5);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (8, 8, 23, 2, 'Not my favorite.');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (9, 9, 9, 4);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (10, 10, 24, 5, 'Outstanding!');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (11, 1, 2, 3);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (12, 2, 8, 4);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (13, 3, 11, 2, 'Not bad.');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (14, 4, 15, 5);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (15, 5, 20, 3, 'Pretty good.');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (16, 6, 21, 4);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (17, 7, 17, 5);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (18, 8, 3, 2, 'Too spicy for me.');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (19, 9, 19, 4);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (20, 10, 13, 3, 'Okay dish.');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (21, 1, 4, 4);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (22, 2, 12, 2, 'Too bland.');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (23, 3, 16, 4);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (24, 4, 5, 3);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (25, 5, 21, 4, 'Yummy!');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (26, 6, 15, 5);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (27, 7, 8, 3, 'Decent.');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (28, 8, 10, 2);
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating, Comments) VALUES (29, 9, 23, 5, 'One of the best!');
INSERT INTO Reviews (ReviewID, CustomerID, RecipeID, Rating) VALUES (30, 10, 6, 4);

