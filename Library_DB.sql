CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

CREATE TABLE Author (
    author_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Book (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(8,2),
    available_copies INT DEFAULT 1
);

CREATE TABLE Book_Author (
    isbn VARCHAR(20),
    author_id INT,
    PRIMARY KEY (isbn, author_id),
    FOREIGN KEY (isbn) REFERENCES Book(isbn) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Author(author_id) ON DELETE CASCADE
);

CREATE TABLE Member (
    member_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255)
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY,
    member_id INT,
    isbn VARCHAR(20),
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL
    -- Note: Omitting strict FK on isbn or using SET NULL allows testing missing book references
);

-- Insert 12+ Records per Table
INSERT INTO Author VALUES
(1, 'J.K. Rowling'), (2, 'George R.R. Martin'), (3, 'J.R.R. Tolkien'),
(4, 'Isaac Asimov'), (5, 'Agatha Christie'), (6, 'Stephen King'),
(7, 'Brandon Sanderson'), (8, 'Neil Gaiman'), (9, 'Terry Pratchett'),
(10, 'Yuval Noah Harari'), (11, 'Abraham Silberschatz'), (12, 'Orphan Author');

INSERT INTO Book VALUES
('978-01', 'Harry Potter and the Sorcerer Stone', 'Fantasy', 450.00, 5),
('978-02', 'A Game of Thrones', 'Fantasy', 650.00, 3),
('978-03', 'The Hobbit', 'Fantasy', 500.00, 4),
('978-04', 'Foundation', 'Sci-Fi', 400.00, 2),
('978-05', 'Murder on the Orient Express', 'Mystery', 350.00, 6),
('978-06', 'The Shining', 'Horror', 480.00, 3),
('978-07', 'The Way of Kings', 'Fantasy', 750.00, 2),
('978-08', 'Good Omens', 'Fantasy', 420.00, 4),
('978-09', 'Sapiens', 'History', 550.00, 5),
('978-10', 'Database System Concepts', 'Education', 900.00, 7),
('978-11', 'Harry Potter and the Chamber of Secrets', 'Fantasy', 470.00, 4),
('978-12', 'Anonymous Chronicles', 'Fiction', 300.00, 1);

INSERT INTO Book_Author VALUES
('978-01', 1), ('978-02', 2), ('978-03', 3), ('978-04', 4),
('978-05', 5), ('978-06', 6), ('978-07', 7), ('978-08', 8),
('978-08', 9), ('978-09', 10), ('978-10', 11), ('978-11', 1);

INSERT INTO Member VALUES
(101, 'Aarav Sharma', 'Mirzapur, UP'), (102, 'Priya Verma', 'Varanasi, UP'),
(103, 'Rohan Gupta', 'Prayagraj, UP'), (104, 'Ananya Singh', 'Lucknow, UP'),
(105, 'Vikram Patel', 'Kanpur, UP'), (106, 'Neha Tiwari', 'Sonbhadra, UP'),
(107, 'Kabir Das', 'Agra, UP'), (108, 'Meera Nair', 'Delhi'),
(109, 'Siddharth Roy', 'Kolkata, WB'), (110, 'Pooja Joshi', 'Pune, MH'),
(111, 'Arjun Mehta', 'Mumbai, MH'), (112, 'Inactive Member', 'Noida, UP');

INSERT INTO Loan VALUES
(1, 101, '978-01', '2026-10-01', '2026-10-15', '2026-10-12'),
(2, 101, '978-02', '2026-11-01', '2026-11-15', NULL), -- Overdue
(3, 102, '978-03', '2026-11-10', '2026-11-25', NULL), -- Active
(4, 103, '978-04', '2026-09-10', '2026-09-25', '2026-09-20'),
(5, 104, '978-05', '2026-10-05', '2026-10-20', '2026-10-19'),
(6, 105, '978-06', '2026-10-10', '2026-10-24', NULL), -- Overdue
(7, 106, '978-07', '2026-11-12', '2026-11-26', NULL), -- Active
(8, 107, '978-08', '2026-08-01', '2026-08-15', '2026-08-14'),
(9, 108, '978-09', '2026-11-05', '2026-11-20', NULL), -- Active
(10, 109, '978-10', '2026-09-01', '2026-09-15', '2026-09-10'),
(11, 110, '978-01', '2026-11-14', '2026-11-28', NULL), -- Active
(12, 111, '978-99', '2026-10-01', '2026-10-15', '2026-10-10'); -- Missing Book ISBN