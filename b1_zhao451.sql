/* #1.1 */
SELECT title FROM Movies 
WHERE movieID IN (
    Select movieID FROM Showtimes S 
    WHERE showID IN (
        SELECT showID FROM Tickets GROUP BY showID HAVING COUNT(*) >= S.max_occupancy )
);

/* #1.2 */
SELECT T.name TheatreName, count(showid)
	FROM Showtimes S
		JOIN Movies M ON M.movieID = S.movieID
		JOIN Theaters T ON T.theaterID = S.theaterID
		GROUP BY T.name 
	having count(showid)>=3;

/* #1.3 */
select MIN(T.name), MIN(T.theaterID)FROM Theaters T JOIN Showtimes S on T.theaterID = S.theaterID
GROUP BY S.theaterID having count(DISTINCT showid) >= (select count(*) from Movies);

/* #1.4 */
select MAX(email), MAX(age), MAX(M.title) from Users U
join Tickets T on T.userID = U.userID
join Showtimes S on T.showID = S.showID
join Movies M on M.movieID = S.movieID
group by U.email having count(T.showID)=1;

/* #1.5 */
select MAX(M.title), MAX(U.age) from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
GROUP BY S.showID having count(DISTINCT age)=1;

/* #1.6 */
select Th.name, count(userID) from Theaters Th
join Showtimes S on S.theaterID=Th.theaterID
join Tickets T on T.showID=S.showID
GROUP by name having count(T.userID)= (select max(maxcnt) from (
select Th.name, count(T.userID) AS maxcnt from Theaters Th
join Showtimes S on S.theaterID=Th.theaterID
join Tickets T on T.showID=S.showID
GROUP by name having count(T.userID)>0));

/* #1.7 */
select MAX(U.email), MAX(U.userID), STATS_MODE(Th.theaterID)
from Users U
FULL OUTER join Tickets T on U.userID = T.userID
FULL OUTER join Showtimes S on T.showID = S.showID
FULL OUTER join Theaters Th on Th.theaterID = S.theaterID
GROUP BY U.userID;

/* #1.8 */
select MAX(M.title), ((count(U.userID)*1.0)/count(distinct S.showID)) As Avg_Users from Movies M
join Showtimes S on S.MovieID = M.MovieID
join Tickets T on T.showID = S.showID
join Users U on U.userID = T.userID
join Theaters Th on Th.theaterID = S.theaterID
GROUP BY M.MovieID;

/* #1.9 */
select MAX(title), (MAX(max_occupancy) - count(S.showID)) AS emptyseats from Tickets T
join Showtimes S on T.showID = S.showID
join Movies M on M.movieID=S.movieID
group by S.showID;

/* #1.10 */
select U.email, MAX(M.genre) from Users U
join Tickets T on T.userID = U.userID
join Showtimes S on T.showID = S.showID
join Movies M on M.movieID = S.movieID
group by U.email having count(distinct genre)=1;
