# MySQL Date, Time, and String Functions Guide

## Q1: What are date and time data types in MySQL? Explain with examples.

- **DATE**: Stores date in 'YYYY-MM-DD' format (e.g., '2025-10-04').
- **DATETIME**: Stores date and time in 'YYYY-MM-DD HH:MM:SS' format (e.g., '2025-10-04 19:19:00').
- **TIMESTAMP**: Similar to DATETIME, but converts to UTC on insertion (e.g., '2025-10-04 13:49:00').
- **TIME**: Stores time only in 'HH:MM:SS' format (e.g., '14:30:00').
- **YEAR**: Stores year in 2-digit or 4-digit format (e.g., '25' or '2025').

## Q2: How do you extract specific parts (year, month, day) from a date in MySQL? Provide an example using the EXTRACT() function.

- Use `EXTRACT(part FROM date)` to get specific parts.
- Example: `SELECT EXTRACT(YEAR FROM '2025-10-04');` returns 2025.
- Other parts: `MONTH`, `DAY`.

## Q3: What are some commonly used date and time functions in MySQL?

- `NOW()`: Current date and time.
- `CURDATE()`: Current date.
- `CURTIME()`: Current time.
- `DATE_ADD()`: Add intervals to dates.
- `DATEDIFF()`: Difference between two dates.

## Q4: How can you convert a string into a date format in MySQL? Explain using STR_TO_DATE().

- Use `STR_TO_DATE(string, format)` to parse a string into a date.
- Example: `SELECT STR_TO_DATE('04/10/2025', '%d/%m/%Y');` returns '2025-10-04'.

## Q5: What is the difference between DATE_FORMAT() and TIME_FORMAT() in MySQL?

- `DATE_FORMAT(date, format)`: Formats a date value (e.g., `DATE_FORMAT('2025-10-04', '%W, %M %e, %Y')` returns 'Saturday, October 4, 2025').
- `TIME_FORMAT(time, format)`: Formats a time value (e.g., `TIME_FORMAT('14:30:00', '%h:%i %p')` returns '02:30 PM').

## Q6: How can you perform arithmetic operations on date values (adding/subtracting days, months, or years)? Explain with DATE_ADD() and DATE_SUB().

- `DATE_ADD(date, INTERVAL expr unit)`: Adds time (e.g., `DATE_ADD('2025-10-04', INTERVAL 5 DAY)` returns '2025-10-09').
- `DATE_SUB(date, INTERVAL expr unit)`: Subtracts time (e.g., `DATE_SUB('2025-10-04', INTERVAL 1 MONTH)` returns '2025-09-04').

## Q7: What is the TIMESTAMPDIFF() function, and how is it used to calculate differences between two dates?

- `TIMESTAMPDIFF(unit, datetime1, datetime2)`: Returns the difference between two datetimes in the specified unit (e.g., `TIMESTAMPDIFF(YEAR, '2020-01-01', '2025-10-04')` returns 5).

## Q8: Explain how the CURDATE(), NOW(), and CURRENT_TIMESTAMP() functions differ.

- `CURDATE()`: Returns current date only (e.g., '2025-10-04').
- `NOW()`: Returns current date and time (e.g., '2025-10-04 19:19:00').
- `CURRENT_TIMESTAMP()`: Same as `NOW()`.

## Q9: How can you convert a Unix timestamp into a readable date format using MySQL?

- Use `FROM_UNIXTIME(unix_timestamp)` (e.g., `SELECT FROM_UNIXTIME(1633324800);` returns '2025-10-04 00:00:00').

## Q10: What is the purpose of the INTERVAL keyword in MySQL date-time manipulation?

- `INTERVAL` is used with `DATE_ADD()` or `DATE_SUB()` to specify the time interval to add or subtract (e.g., `INTERVAL 5 DAY`).

## Q11: How do you find the day of the week for a given date in MySQL? Explain using the DAYNAME() function.

- `DAYNAME(date)` returns the weekday name (e.g., `SELECT DAYNAME('2025-10-04');` returns 'Saturday').

## Q12: Write an SQL query to calculate the number of days between two dates using DATEDIFF().

- Example: `SELECT DATEDIFF('2025-10-10', '2025-10-04');` returns 6.

## Q13: What are string manipulation functions in MySQL? Why are they important?

- Functions like `CONCAT()`, `SUBSTRING()`, `REPLACE()`, `UPPER()`, `LOWER()`, `TRIM()` manipulate strings.
- Importance: Useful for data cleaning, formatting, and reporting.

## Q14: How does the CONCAT() function work in MySQL? Provide an example.

- `CONCAT(str1, str2, ...)` joins strings (e.g., `SELECT CONCAT('Hello', ' ', 'World');` returns 'Hello World').

## Q15: What is the difference between CONCAT() and CONCAT_WS()? Explain with examples.

- `CONCAT()`: Joins strings without a separator (e.g., `CONCAT('Hello', 'World')` returns 'HelloWorld').
- `CONCAT_WS(separator, str1, str2, ...)`: Joins with a separator (e.g., `CONCAT_WS(' ', 'Hello', 'World')` returns 'Hello World').

## Q16: How do you extract a substring from a string using SUBSTRING() or MID() in MySQL?

- `SUBSTRING(str, start, length)` or `MID(str, start, length)` extracts a portion (e.g., `SELECT SUBSTRING('Hello World', 1, 5);` returns 'Hello').

## Q17: What is the purpose of the REPLACE() function? Provide an example where it is useful.

- `REPLACE(str, from_str, to_str)` replaces occurrences (e.g., `SELECT REPLACE('Hello World', 'World', 'Everyone');` returns 'Hello Everyone'—useful for data correction).

## Q18: How can you convert text to uppercase or lowercase using MySQL string functions? Explain using UPPER() and LOWER().

- `UPPER(str)`: Converts to uppercase (e.g., `SELECT UPPER('hello');` returns 'HELLO').
- `LOWER(str)`: Converts to lowercase (e.g., `SELECT LOWER('WORLD');` returns 'world').

## Q19: What is the use of the TRIM() function? How does it differ from LTRIM() and RTRIM()?

- `TRIM(str)`: Removes leading and trailing spaces (e.g., `SELECT TRIM('  Hello  ');` returns 'Hello').
- `LTRIM(str)`: Removes leading spaces only.
- `RTRIM(str)`: Removes trailing spaces only.

## Q20: How do you find the length of a string in MySQL? Explain using LENGTH() and CHAR_LENGTH().

- `LENGTH(str)`: Returns byte length (e.g., `SELECT LENGTH('hello');` returns 5).
- `CHAR_LENGTH(str)`: Returns character length (e.g., `SELECT CHAR_LENGTH('héllo');` returns 5, accounting for Unicode).

## Q21: What is the purpose of the LOCATE() and INSTR() functions in MySQL?

- `LOCATE(substr, str)` or `INSTR(str, substr)`: Finds the position of a substring (e.g., `SELECT LOCATE('lo', 'hello');` returns 4).

## Q22: How can you replace multiple occurrences of a substring within a string in MySQL?

- Use `REPLACE()` iteratively or in a loop if needed (e.g., `SELECT REPLACE('hi hi hi', 'hi', 'hello');` returns 'hello hello hello').

## Q22: Explain how to reverse a string using MySQL. Provide an example with REVERSE().

- `REVERSE(str)` reverses a string (e.g., `SELECT REVERSE('hello');` returns 'olleh').

## Q23: Write an SQL query to extract the first five characters of a string using LEFT().

- Example: `SELECT LEFT('Hello World', 5);` returns 'Hello'.
