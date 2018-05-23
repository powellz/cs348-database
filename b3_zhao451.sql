/* #3.1 */
CREATE OR REPLACE TRIGGER No_movie_duplicates
BEFORE INSERT OR UPDATE ON Showtimes
FOR each ROW

declare
v_dup number;

begin
    select count(showID) INTO v_dup from Showtimes where theaterID = :NEW.theaterID and ((starttime <= :NEW.starttime and endtime >= :NEW.starttime) or (endtime >= :NEW.endtime and starttime <= :NEW.endtime) or (starttime <= :NEW.starttime and endtime >= :NEW.endtime));

    if v_dup > 0 then
    Raise_Application_Error (-20100, 'This movie has a duplicate runtime.');
	ROLLBACK;
end if;

END;
/


/* #3.2 */
CREATE OR REPLACE TRIGGER Too_many_people
BEFORE INSERT OR UPDATE ON Tickets
FOR each ROW

declare
v_dup number;

begin
		Select count(movieID) INTO v_dup FROM Showtimes S 
    		WHERE :NEW.showID IN (
        	SELECT showID FROM Tickets GROUP BY showID HAVING COUNT(*) >= S.max_occupancy);
    if v_dup > 0 then
    Raise_Application_Error (-20100, 'Movies are duplicates.');
	ROLLBACK;
end if;

END;
/
