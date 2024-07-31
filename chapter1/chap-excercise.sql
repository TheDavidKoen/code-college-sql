CREATE TABLE animals (
	id bigserial,
	animal varchar(10),
	breed varchar(10),
	amount numeric
);

INSERT INTO animals (animal, breed, amount)

VALUES 
	('dog', 'husky', 6),
	('cat', 'bobcat', 3),
	('fish', 'gappie', 28);