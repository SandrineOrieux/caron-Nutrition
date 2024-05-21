CREATE DATABASE coupart-nutrition;

CREATE TABLE allergen (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, name VARCHAR(255) NOT NULL);
CREATE TABLE diet (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, name VARCHAR(255) NOT NULL, description LONGTEXT NOT NULL);
CREATE TABLE quantity (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, number INT DEFAULT NULL, unity VARCHAR(255) DEFAULT NULL);
CREATE TABLE type_of_recipe (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, name VARCHAR(255) NOT NULL);
CREATE TABLE user (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, email VARCHAR(180) NOT NULL UNIQUE, roles JSON NOT NULL COMMENT \'(DC2Type:json)\', password VARCHAR(255) NOT NULL, first_name VARCHAR(255) NOT NULL, last_name VARCHAR(255) NOT NULL, birthday DATE NOT NULL COMMENT \'(DC2Type:date_immutable)\');
CREATE TABLE user_allergen (user_id INT NOT NULL FOREIGN KEY REFERENCES user (id) ON DELETE CASCADE, allergen_id INT NOT NULL FOREIGN KEY REFERENCES allergen (id) ON DELETE CASCADE);
CREATE TABLE user_diet (user_id INT NOT NULL FOREIGN KEY REFERENCES user (id) ON DELETE CASCADE, diet_id INT NOT NULL FOREIGN KEY REFERENCES diet (id) ON DELETE CASCADE);
CREATE TABLE ingredient (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, quantity_id INT DEFAULT NULL FOREIGN KEY REFERENCES quantity (id), allergen_id INT DEFAULT NULL FOREIGN KEY REFERENCES allergen (id), name VARCHAR(255) NOT NULL);
CREATE TABLE ingredient_recipe (ingredient_id INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES ingredient (id) ON DELETE CASCADE, recipe_id INT NOT NULL FOREIGN KEY REFERENCES recipe (id) ON DELETE CASCADE);
CREATE TABLE recipe (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, type_of_recipe_id INT NOT NULL FOREIGN KEY REFERENCES type_of_recipe (id), title VARCHAR(255) NOT NULL, decription LONGTEXT NOT NULL, preparation_time INT NOT NULL, resting_time INT DEFAULT NULL, cooking_time INT DEFAULT NULL, steps LONGTEXT NOT NULL, is_public TINYINT(1) NOT NULL);
CREATE TABLE recipe_diet (recipe_id INT NOT NULL FOREIGN KEY REFERENCES recipe (id) ON DELETE CASCADE, diet_id INT NOT NULL FOREIGN KEY REFERENCES diet (id) ON DELETE CASCADE);
CREATE TABLE review (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, user_id INT NOT NULL  FOREIGN KEY REFERENCES user (id), recipe_id INT NOT NULL FOREIGN KEY REFERENCES recipe (id), rate SMALLINT NOT NULL, comment LONGTEXT DEFAULT NULL, is_validated TINYINT(1) NOT NULL);