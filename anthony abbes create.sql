-- MariaDB
-- on supprime les versions précédentes des tables
DROP DATABASE IF EXISTS gestion_cinemas;
CREATE DATABASE gestion_cinemas;
USE gestion_cinemas;

-- on crée la table Movies
CREATE TABLE Movies
(
    idMovie INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    movieName VARCHAR(250) NOT NULL,
    description VARCHAR(250),
    director VARCHAR(250),
    releaseDate DATE
) engine=INNODB;

-- on crée la table cinema
CREATE TABLE Cinemas
(
    idCinema INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(250) NOT NULL
) engine=INNODB;

-- table Users

CREATE TABLE Users
(
    userId CHAR(36) NOT NULL PRIMARY KEY, -- UUID
    firstname VARCHAR(250),
    lastname VARCHAR(250),
    email VARCHAR(250) NOT NULL UNIQUE,
    password VARCHAR(60) NOT NULL
) engine=INNODB;

-- table Employees

CREATE TABLE Employees
(
    idCinema INT NOT NULL,
    employeeId CHAR(36) NOT NULL PRIMARY KEY,
    isAdmin TINYINT(1) NOT NULL,
    FOREIGN KEY (idCinema) REFERENCES Cinemas(idCinema),
    FOREIGN KEY (employeeId) REFERENCES Users(userId) ON DELETE CASCADE
) engine=INNODB;

-- table associative des admins avec tous les droits

CREATE TABLE Directors
(
    user_id CHAR(36) NOT NULL,
    cinema_id INT NOT NULL,
    PRIMARY KEY (user_id, cinema_id),
    FOREIGN KEY (user_id) REFERENCES Users(userId),
    FOREIGN KEY (cinema_id) REFERENCES Cinemas(idCinema)
) engine=INNODB;

-- On crée la table MovieRooms qui dépend d'un cinéma et est gérée par 1 employé
CREATE TABLE MovieRooms
(
    idMovieRoom INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    seatQuantity INT NOT NULL,
    roomName VARCHAR(250),
    isInCinema INT NOT NULL,
    managedBy CHAR(36),
    FOREIGN KEY (isInCinema) REFERENCES Cinemas(idCinema) ON DELETE CASCADE,
    FOREIGN KEY (managedBy) REFERENCES Users(userId)
) engine=INNODB;

-- On crée la table Seances dépendance forte avec Movierooms
CREATE TABLE Seances
(
    idSeance INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    movie INT NOT NULL,
    dateSeance DATETIME NOT NULL,
    isInRoom INT NOT NULL,
    FOREIGN KEY (movie) REFERENCES Movies(idMovie) ON DELETE CASCADE,
    FOREIGN KEY (isInRoom) REFERENCES MovieRooms(idMovieRoom) ON DELETE CASCADE
) engine=INNODB;

-- on crée la table Prices
CREATE TABLE Prices(
    idPrice INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    priceName VARCHAR(250) NOT NULL,
    price DECIMAL(4, 2) NOT NULL
) engine=INNODB;

-- moyens de paiements proposés
CREATE TABLE PaymentMethods
(
    idPayment INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    paymentMethod VARCHAR(250) NOT NULL
) engine=INNODB;

-- Table Order
CREATE TABLE Orders
(
    idOrder INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    customer CHAR(36) NOT NULL,
    dateOrder DATETIME NOT NULL,
    payment INT NOT NULL,
    status TINYINT(1) NOT NULL,
    FOREIGN KEY (customer) REFERENCES Users(userId) ON DELETE CASCADE,
    FOREIGN KEY (payment) REFERENCES PaymentMethods(idPayment)
) engine=INNODB;

-- détail d'une commande avec un lien fort entre Orders
CREATE TABLE OrderDetails
(
    idOrderDetails INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    inOrder INT NOT NULL,
    seance INT NOT NULL,
    quantity INT NOT NULL,
    price INT NOT NULL,
    FOREIGN KEY (inOrder) REFERENCES Orders(idOrder) ON DELETE CASCADE,
    FOREIGN KEY (seance) REFERENCES Seances(idSeance),
    FOREIGN KEY (price) REFERENCES Prices(idPrice)
) engine=INNODB;

-- Insertion des données fictives;

INSERT INTO Movies (movieName, description, director, releaseDate) VALUES
    ('Le Navet', "L'histoire passionnante de la pousse d'un navet solitaire", 'Leo Sali', '2023-10-25'),
    ('Chat Pristi', 'Une comédie rafraichissante avec Milou le chat', 'Sarah KITTY', '2023-10-20');

INSERT INTO cinemas (name) VALUES
    ('Pathé'),
    ('VOX'),
    ('UGC Jaune');

INSERT INTO MovieRooms (roomName, seatQuantity, isInCinema) VALUES
    ('Salle 1', 250, 1),
    ('Salle 2', 200, 1),
    ('Salle 3', 75, 1),
    ('Salle 1', 300, 2),
    ('Salle 2', 200, 2),
    ('Salle 1', 500, 3),
    ('Salle 2', 240, 3);

INSERT INTO Seances(movie, dateSeance, isInRoom) VALUES
    (1,'2023-11-05 16:30:00',1),
    (1,'2023-11-05 16:30:00',4),
    (1,'2023-11-05 16:30:00',6),
    (2,'2023-11-05 16:30:00',2),
    (2,'2023-11-05 18:30:00',5),
    (2,'2023-11-05 19:30:00',7);

INSERT INTO Paymentmethods (paymentMethod) VALUES
    ('En ligne'),
    ('Sur place');

INSERT INTO Prices (priceName, price) VALUES
    ('Plein tarif', '9.20'),
    ('Etudiant', '7.60'),
    ('Moins de 14 ans', '5.90');

INSERT INTO Users (userId, firstname, lastname, email, password) VALUES
    ('81d98bf1-6680-11ee-ab47-3244bff07888', 'Léa', 'ASAHA','lea.asaha@gmail.com', '$2y$10$mqB8yDpk23TtmtrJz94QOeDfb1NI/HCgMv1RiN1BXOlHcB1pJ1gKi'),
    ('81d99427-6680-11ee-ab47-3244bff07888', 'Mireille', 'SELIEU', 'mireille.selieu@gmail.com', '$2y$10$F9qw8Unkrb6zjg8w0TPx4empkLjNL.BAtvrtjiWJHn.ltKHtiSh5e'),
    ('81d994b8-6680-11ee-ab47-3244bff07888', 'SARAH', 'DE LA COUR', 'sarah.delacour@gmail.com', '$2y$10$0U38FScBg95NXqxB0SX/rO/fa2MSdGzPxysiBxWSIPJO1MmFcndcm'),
    ('81d994e7-6680-11ee-ab47-3244bff07888', 'José', 'GARCIA', 'jose.garcia@gmail.com', '$2y$10$bp8mwKwyft3yZguTy4DPJ.xPFoZILOSC5rX0w0rXVuYEppDUYxfvy'),
    ('81d99513-6680-11ee-ab47-3244bff07888', 'LISA', 'XEO', 'lisa.xeo@gmail.com', '$2y$10$TWOdSjZZvQVjRvOZZQ0NyOsWKJkAT9K1zOiGqtRY0jhNrGmh3TcMG');

INSERT INTO Employees(idCinema, employeeId, isAdmin) VALUES
    ('1', '81d994b8-6680-11ee-ab47-3244bff07888','0'),
    ('2','81d994e7-6680-11ee-ab47-3244bff07888','0'),
    ('1','81d99513-6680-11ee-ab47-3244bff07888','1');


INSERT INTO Directors(user_id, cinema_id) VALUES
    ('81d99513-6680-11ee-ab47-3244bff07888','1'),
    ('81d99513-6680-11ee-ab47-3244bff07888','2'),
    ('81d99513-6680-11ee-ab47-3244bff07888','3');

INSERT INTO Orders(customer, dateOrder,payment, status) VALUES
    ('81d98bf1-6680-11ee-ab47-3244bff07888','2023-11-05 12:30:00','2','1'),
    ('81d99427-6680-11ee-ab47-3244bff07888','2023-11-05 11:30:00','1','1');

INSERT INTO Orderdetails(inOrder, seance, quantity, price) VALUES
    ('1','2','2','1'),
    ('1','2','2','3'),
    ('1','2','2','2'),
    ('2','1','6','1');

-- création d'un utilisateur qui servira à faire la connexion dans le .ENV du PHP pour toute l'app;
CREATE OR REPLACE USER 'cineapp'@'%' IDENTIFIED BY PASSWORD '*54958E764CE10E50764C2EECBB71D01F08549980';
GRANT ALL PRIVILEGES ON gestion_cinemas.* TO 'cineapp'@'%' ;

-- création d'un utilisateur qui servira a faire la sauvegarde auto de la base
CREATE OR REPLACE USER 'dumpuser'@'%' IDENTIFIED BY PASSWORD '*54958E764CE10E50764C2EECBB71D01F08549980';
GRANT SELECT, LOCK TABLES, SHOW VIEW, CREATE, EVENT, TRIGGER ON gestion_cinemas.* TO 'dumpuser'@'%';
FLUSH PRIVILEGES;