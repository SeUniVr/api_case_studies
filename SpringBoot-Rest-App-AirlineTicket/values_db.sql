-- (id, capacity, location, name)
INSERT INTO airport VALUES
(0, 100, "Verona", "Valerio Catullo"),
(1, 1000, "London", "London Gatwick"),
(2, 100000, "New York", "JFK International"),
(3, NULL, NULL, "Los Angeles International"),
(4, NULL, "Vancouver", "Vancouver International");

-- (id, name)
INSERT INTO company VALUES
(0, 'Cheap flights'),
(1, 'Global airlines'),
(2, 'European airlines'),
(3, 'Green Air'),
(4, 'Blue Wings');

-- (id, name, arrival_id, dep_id)
INSERT INTO route VALUES
(0, 'Verona2London', 1, 0),
(1, 'Verona2Vancouver', 4, 0),
(2, 'LA2Vancouver', 4, 3),
(3, 'Vancouver2Verona', 0, 4),
(4, 'London2LA', 3, 1),
(5, NULL, NULL, NULL),
(6, 'Unknown2Unk', NULL, NULL);

-- (id, name, #seats, compani_id)
INSERT INTO plane VALUES
(0, 'Bigplane', NULL, NULL),
(1, 'Smallplane', 10, NULL),
(2, 'Smallplane', 10, 1),
(3, 'Mediumplane', 100, 3),
(4, 'Personal', 2, 4),
(5, 'Fastplane', NULL, 2);

-- (id, arrival_date, departure_date, duration, name, quota, quota_filled, quota_filled_perc, company_id, route_id)
INSERT INTO flight VALUES
(0, NULL, NULL, 9, 'Long flight to Verona', NULL, NULL, NULL, 1, 3),
(1, NULL, NULL, 5, 'Short flight to London', 50, NULL, NULL, 2, 0),
(3, NULL, NULL, NULL, 'Empty flight', NULL, NULL, NULL, NULL, NULL);

-- (id, is_sold, price, ticket_code, flight_id)
INSERT INTO ticket VALUES
(0, NULL, NULL, 'emptyticket-ticket-code', NULL),
(1, 1, 150, 'another-ticket-code', 0),
(2, 0, NULL, 'third-ticket-code', NULL),
(3, 1, 300, 'just-a-ticket-code', NULL),
(4, NULL, 500, 'ticket-code', 3);