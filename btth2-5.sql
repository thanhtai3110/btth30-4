CREATE DATABASE CineMagic;
USE CineMagic;

CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration_minutes INT NOT NULL,
    age_restriction INT DEFAULT 0 CHECK (age_restriction IN (0, 13, 16, 18))
);

CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    max_seats INT NOT NULL,
    status ENUM('active', 'maintenance') DEFAULT 'active'
);

CREATE TABLE showtimes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    room_id INT NOT NULL,
    show_time DATETIME NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL CHECK (ticket_price >= 0),

    FOREIGN KEY (movie_id) REFERENCES movies(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (room_id) REFERENCES rooms(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    showtime_id INT NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (showtime_id) REFERENCES showtimes(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO movies (title, duration_minutes, age_restriction) VALUES
('Avengers: Secret Wars', 150, 13),
('The Nun 3', 120, 18),
('Kung Fu Panda 4', 100, 0),
('Fast & Furious 11', 140, 16);

INSERT INTO rooms (name, max_seats, status) VALUES
('Room 1', 100, 'active'),
('Room 2', 80, 'active'),
('Room 3', 60, 'maintenance');

INSERT INTO showtimes (movie_id, room_id, show_time, ticket_price) VALUES
(1, 1, '2026-05-01 18:00:00', 90000),
(2, 2, '2026-05-01 20:00:00', 100000),
(3, 1, '2026-05-02 10:00:00', 70000),
(4, 2, '2026-05-02 21:00:00', 110000),
(1, 2, '2026-05-03 19:00:00', 95000);

INSERT INTO bookings (showtime_id, customer_name, phone) VALUES
(1, 'Nguyen Van A', '0900000001'),
(1, 'Tran Thi B', '0900000002'),
(2, 'Le Van C', '0900000003'),
(2, 'Pham Thi D', '0900000004'),
(3, 'Hoang Van E', '0900000005'),
(3, 'Nguyen Thi F', '0900000006'),
(4, 'Tran Van G', '0900000007'),
(4, 'Le Thi H', '0900000008'),
(5, 'Pham Van I', '0900000009'),
(5, 'Hoang Thi K', '0900000010');

update rooms 
set status = 'maintenance'
where id = 1;

update showtimes 
set room_id  = 1
where room_id = 2;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM bookings
WHERE phone = '0987654321';
SET SQL_SAFE_UPDATES = 1;

DELETE FROM movies
WHERE id = 3;

