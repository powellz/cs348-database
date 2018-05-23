SET SERVEROUTPUT ON SIZE 32000

/* #2.1 */
create or replace procedure generates_info
IS
NumberOfUsers NUMBER;
AvgBooked NUMBER;

BEGIN

select count(distinct U.userID) into NumberOfUsers from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Teen';

select SUM(U.numberBookedSoFar)*1.0/count(distinct U.userID) into AvgBooked from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Teen';

dbms_output.put_line('AgeGroup    NumberOfUsers    AvgBooked');
dbms_output.put_line('-------------------------------------------------------------');
dbms_output.put_line('Teen        ' || NumberOfUsers || '' || CHR(9) || CHR(9) || '    '|| AvgBooked);

select count(distinct U.userID) into NumberOfUsers from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Young Adult';

select SUM(U.numberBookedSoFar)*1.0/count(distinct U.userID) into AvgBooked from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Young Adult';

dbms_output.put_line('Young Adult ' || NumberOfUsers || '' || CHR(9) || CHR(9) || '    '|| AvgBooked);

select count(distinct U.userID) into NumberOfUsers from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Adult';

select SUM(U.numberBookedSoFar)*1.0/count(distinct U.userID) into AvgBooked from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Adult';

dbms_output.put_line('Adult       ' || NumberOfUsers || '' || CHR(9) || CHR(9) || '    '|| AvgBooked);

select count(distinct U.userID) into NumberOfUsers from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Middle-Aged';

select SUM(U.numberBookedSoFar)*1.0/count(distinct U.userID) into AvgBooked from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Middle-Aged';

dbms_output.put_line('Middle-Aged ' || NumberOfUsers || '' || CHR(9) || CHR(9) || '    '|| AvgBooked);

select count(distinct U.userID) into NumberOfUsers from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Senior';

select SUM(U.numberBookedSoFar)*1.0/count(distinct U.userID) into AvgBooked from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
WHERE U.age = 'Senior';

dbms_output.put_line('Senior      ' || NumberOfUsers || '' || CHR(9) || CHR(9) || '    '|| AvgBooked);

END;
/

execute generates_info



/* #2.2 */
create or replace procedure generates_report
IS
Title VARCHAR2(32);

BEGIN

For T in (select name, theaterID from Theaters)
LOOP
	dbms_output.put_line('Theater: ' || T.name);
	For M in (select movieID, starttime, endtime, hall, showID from Showtimes where theaterID = T.theaterID)
	LOOP

	select M2.title into Title from Movies M2
	join Showtimes S2 on S2.MovieID = M2.MovieID
	WHERE S2.movieID = M.movieID
	GROUP BY M2.title;

	dbms_output.put_line(CHR(9) || 'MovieTitle        StartTime     EndTime        Hall');
	dbms_output.put_line(CHR(9) || '-------------------------------------------------------------');
	dbms_output.put_line(CHR(9) || '' || Title || '' || CHR(9) ||  '  ' || M.starttime || '      ' || M.endtime || '       ' || M.hall);

		dbms_output.put_line(CHR(9) || '       UserID     Email              Age Group ');
		dbms_output.put_line(CHR(9) || '       ------------------------------------------------------');

		For U in (select U2.userID, email, age from Users U2
			join Tickets T2 on T2.userID = U2.userID
			join Showtimes S2 on T2.showID = S2.showID
			where T2.showID = M.showID)
		LOOP
		dbms_output.put_line(CHR(9) || '       ' || U.userID || '          ' || U.email || '      ' || U.age);
		
		END LOOP;

	END LOOP;
END LOOP;


end;
/

execute generates_report

