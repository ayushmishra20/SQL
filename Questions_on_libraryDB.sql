-- 1. Display each book along with the names of its authors
SELECT b.isbn, b.title, a.name AS author_name
FROM Book b
JOIN Book_Author ba ON b.isbn = ba.isbn
JOIN Author a ON ba.author_id = a.author_id;

-- 2. List all currently borrowed books with the member who borrowed them
SELECT b.title, m.name AS member_name, l.loan_date, l.due_date
FROM Loan l
JOIN Book b ON l.isbn = b.isbn
JOIN Member m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

-- 3. List all books along with authors, including books that have no authors registered
SELECT b.title, a.name AS author_name
FROM Book b
LEFT JOIN Book_Author ba ON b.isbn = ba.isbn
LEFT JOIN Author a ON ba.author_id = a.author_id;

-- 4. Display all authors and the books they have written, including authors who have written no books
SELECT a.name AS author_name, b.title
FROM Author a
LEFT JOIN Book_Author ba ON a.author_id = ba.author_id
LEFT JOIN Book b ON ba.isbn = b.isbn;

-- 5. Show each member and the books they have borrowed, including members who have never borrowed any book
SELECT m.member_id, m.name, b.title
FROM Member m
LEFT JOIN Loan l ON m.member_id = l.member_id
LEFT JOIN Book b ON l.isbn = b.isbn;

-- 6. List all loan records and their books, showing loans even if the referenced book is missing
SELECT l.loan_id, l.member_id, l.isbn, b.title, l.loan_date
FROM Loan l
LEFT JOIN Book b ON l.isbn = b.isbn;

-- 7. Show each book and the number of authors for that book
SELECT b.isbn, b.title, COUNT(ba.author_id) AS author_count
FROM Book b
LEFT JOIN Book_Author ba ON b.isbn = ba.isbn
GROUP BY b.isbn, b.title;

-- 8. Retrieve the authors who have written more than one book
SELECT a.author_id, a.name, COUNT(ba.isbn) AS book_count
FROM Author a
JOIN Book_Author ba ON a.author_id = ba.author_id
GROUP BY a.author_id, a.name
HAVING COUNT(ba.isbn) > 1;

-- 9. Find all overdue books with the member who borrowed them
SELECT b.title, m.name AS member_name, l.due_date
FROM Loan l
JOIN Book b ON l.isbn = b.isbn
JOIN Member m ON l.member_id = m.member_id
WHERE l.return_date IS NULL AND l.due_date < CURDATE();

-- 10. List members who borrowed books from the category 'Fantasy'
SELECT DISTINCT m.member_id, m.name
FROM Member m
JOIN Loan l ON m.member_id = l.member_id
JOIN Book b ON l.isbn = b.isbn
WHERE b.category = 'Fantasy';

-- 11. Display each book and the total number of times it has been borrowed
SELECT b.isbn, b.title, COUNT(l.loan_id) AS times_borrowed
FROM Book b
LEFT JOIN Loan l ON b.isbn = l.isbn
GROUP BY b.isbn, b.title;

-- 12. List all loans with their book titles and author names
SELECT l.loan_id, b.title, GROUP_CONCAT(a.name SEPARATOR ', ') AS authors
FROM Loan l
JOIN Book b ON l.isbn = b.isbn
LEFT JOIN Book_Author ba ON b.isbn = ba.isbn
LEFT JOIN Author a ON ba.author_id = a.author_id
GROUP BY l.loan_id, b.title;