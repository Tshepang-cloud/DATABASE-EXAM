-- ============================================================
-- PROMPT 1: LargeBOOKINGs view
-- ============================================================
DROP VIEW IF EXISTS LargeBOOKINGs;

CREATE VIEW LargeBOOKINGs AS
SELECT
    VenueID,
    ClientID,
    EventStartDate,
    EventEndDate,
    NumberOfAttendees
FROM BOOKING
WHERE EventStartDate >= '2026-01-01'      -- fixed: no DATE keyword
  AND EventStartDate <  '2027-01-01'
  AND NumberOfAttendees >= 100;

SELECT * FROM LargeBOOKINGs;

-- ============================================================
-- PROMPT 2: FindBOOKINGs stored procedure
-- ============================================================
DROP PROCEDURE IF EXISTS FindBOOKINGs;

DELIMITER $$

CREATE PROCEDURE FindBOOKINGs (IN p_VenueID VARCHAR(10))
BEGIN
    SELECT
        c.ClientFullName,
        c.ClientContact,
        b.EventStartDate,
        b.EventEndDate,
        b.NumberOfAttendees
    FROM BOOKING b
    INNER JOIN CLIENT c ON c.ClientID = b.ClientID
    INNER JOIN VENUE  v ON v.VenueID  = b.VenueID
    WHERE b.VenueID = p_VenueID
    ORDER BY b.EventStartDate;
END$$

DELIMITER ;

CALL FindBOOKINGs('V0001');

-- ============================================================
-- PROMPT 3: booking-existence classification (with count)
-- ============================================================
SELECT
    v.VenueID,
    v.VenueName,
    COUNT(b.BookingID) AS NumberOfBookings,
    CASE
        WHEN COUNT(b.BookingID) > 0 THEN 'BOOKINGs exist'
        ELSE 'No BOOKINGs exist'
    END AS BookingStatus
FROM VENUE v
LEFT JOIN BOOKING b ON b.VenueID = v.VenueID
GROUP BY v.VenueID, v.VenueName
ORDER BY v.VenueID;

-- ============================================================
-- PROMPT 4: total attendees per venue, descending
-- ============================================================
SELECT
    v.VenueName,
    SUM(COALESCE(b.NumberOfAttendees, 0)) AS TotalAttendees
FROM VENUE v
LEFT JOIN BOOKING b ON b.VenueID = v.VenueID
GROUP BY v.VenueID, v.VenueName
ORDER BY TotalAttendees DESC;

-- ============================================================
-- PROMPT 5: venues with no bookings
-- ============================================================
SELECT v.VenueName
FROM VENUE v
LEFT JOIN BOOKING b ON b.VenueID = v.VenueID
WHERE b.BookingID IS NULL;