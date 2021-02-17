CREATE TABLE IF NOT EXISTS `known_recipes` (
  `identifier` varchar(50) DEFAULT NULL,
  `data` longtext
);

CREATE TABLE IF NOT EXISTS `craftingtables` (
  `location` longtext
);

INSERT INTO `items` (`name`, `label`,`limit`) VALUES
  ( 'craftingtable', 'Crafting Table', -1),
  ( 'recipe_bagofdope', 'Recipe: Bag of Dope', -1),
  ( 'bagofdope' , 'Bullet Casing' , -1 ),
  ( 'dopebag'  , 'Blood Sample'  , -1 ),
  ( 'weed'  , 'DNA Analyzer'  , -1 ),
  ( 'drugscales' , 'Ammo Analyzer' , -1 );
