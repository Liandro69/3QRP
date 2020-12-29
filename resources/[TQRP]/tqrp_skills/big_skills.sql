SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `big_skills` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `stamina` varchar(255) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `driving` varchar(255) DEFAULT NULL,
  `shooting` varchar(255) DEFAULT NULL,
  `fishing` varchar(255) DEFAULT NULL,
  `drugs` varchar(255) DEFAULT NULL
)

ALTER TABLE `big_skills`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `big_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
COMMIT;

INSERT INTO `items` (name, label) VALUES 
	('gym_membership', 'Gym Membership')
;