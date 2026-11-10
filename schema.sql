
-- Практична робота №8
-- Повна структура бази даних бібліотеки

CREATE SCHEMA IF NOT EXISTS college;

-- Видалення попередніх таблиць бібліотеки
DROP TABLE IF EXISTS college.loans;
DROP TABLE IF EXISTS college.book_authors;
DROP TABLE IF EXISTS college.copies;
DROP TABLE IF EXISTS college.books;
DROP TABLE IF EXISTS college.authors;
DROP TABLE IF EXISTS college.readers;
DROP TABLE IF EXISTS college.publishers;

-- 1. Читачі
CREATE TABLE college.readers (
    reader_id INTEGER GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(254) UNIQUE,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT pk_readers PRIMARY KEY (reader_id)
);

-- 2. Видавництва
CREATE TABLE college.publishers (
    publisher_id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(150) NOT NULL,
    city VARCHAR(100),
    CONSTRAINT pk_publishers PRIMARY KEY (publisher_id)
);

-- 3. Автори
CREATE TABLE college.authors (
    author_id INTEGER GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(150) NOT NULL,
    birth_date DATE,
    CONSTRAINT pk_authors PRIMARY KEY (author_id)
);

-- 4. Книги
CREATE TABLE college.books (
    book_id INTEGER GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(17) UNIQUE,
    publication_year SMALLINT,
    publisher_id INTEGER NOT NULL,
    CONSTRAINT pk_books PRIMARY KEY (book_id),
    CONSTRAINT fk_books_publisher
        FOREIGN KEY (publisher_id)
        REFERENCES college.publishers(publisher_id),
    CONSTRAINT chk_books_year
        CHECK (publication_year IS NULL OR publication_year BETWEEN 1 AND 9999)
);

-- 5. Примірники
CREATE TABLE college.copies (
    copy_id INTEGER GENERATED ALWAYS AS IDENTITY,
    inventory_number VARCHAR(30) NOT NULL UNIQUE,
    condition_status VARCHAR(50) NOT NULL,
    availability_status VARCHAR(50) NOT NULL,
    book_id INTEGER NOT NULL,
    CONSTRAINT pk_copies PRIMARY KEY (copy_id),
    CONSTRAINT fk_copies_book
        FOREIGN KEY (book_id)
        REFERENCES college.books(book_id)
);

-- 6. Авторство
CREATE TABLE college.book_authors (
    book_author_id INTEGER GENERATED ALWAYS AS IDENTITY,
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    CONSTRAINT pk_book_authors PRIMARY KEY (book_author_id),
    CONSTRAINT fk_book_authors_book
        FOREIGN KEY (book_id)
        REFERENCES college.books(book_id),
    CONSTRAINT fk_book_authors_author
        FOREIGN KEY (author_id)
        REFERENCES college.authors(author_id),
    CONSTRAINT uq_book_authors_pair UNIQUE (book_id, author_id)
);

-- 7. Видачі
CREATE TABLE college.loans (
    loan_id INTEGER GENERATED ALWAYS AS IDENTITY,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    actual_return_date DATE,
    status VARCHAR(50) NOT NULL,
    reader_id INTEGER NOT NULL,
    copy_id INTEGER NOT NULL,
    CONSTRAINT pk_loans PRIMARY KEY (loan_id),
    CONSTRAINT fk_loans_reader
        FOREIGN KEY (reader_id)
        REFERENCES college.readers(reader_id),
    CONSTRAINT fk_loans_copy
        FOREIGN KEY (copy_id)
        REFERENCES college.copies(copy_id),
    CONSTRAINT chk_loans_due_date
        CHECK (due_date >= loan_date),
    CONSTRAINT chk_loans_actual_return
        CHECK (actual_return_date IS NULL OR actual_return_date >= loan_date)
);

-- Перевірка створених таблиць
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'college'
ORDER BY table_name;
