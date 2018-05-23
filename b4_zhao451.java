import java.sql.*;
import java.util.Scanner;
public class b4_zhao451 {
	Connection con;
	
	public b4_zhao451() {
		try {
			Class.forName( "oracle.jdbc.driver.OracleDriver" );
		}
		catch ( ClassNotFoundException e ) {
			e.printStackTrace();
		}
		try {
			con =
					DriverManager.getConnection( "jdbc:oracle:thin:@claros.cs.purdue.edu:1524:strep", "zhao451", "nxX72bpg" );
		}
		catch ( SQLException e ){
			e.printStackTrace();
		}
	}
	public void getShowsForMovie (String movieID) {
		String query = "select title, name, address, hall, starttime, endtime from Showtimes S join Tickets T on T.showID = S.showID join Users U on U.userID = T.userID join Theaters Th on Th.theaterID = S.theaterID join Movies M on M.MovieID = S.MovieID WHERE S.MovieID = " + movieID;
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				//Retrieve by column name
				String movieTitle = rs.getString("TITLE");
				String theaterName = rs.getString("NAME");
				String theaterAddress = rs.getString("ADDRESS");
				String Hall = rs.getString("HALL");
				String Starttime = rs.getString("STARTTIME");
				String Endtime = rs.getString("ENDTIME");
				
				//Display values
				System.out.print("Title: " + movieTitle);
				System.out.print(", Theater: " + theaterName);
				System.out.print(", Address: " + theaterAddress);
				System.out.print(", Hall: " + Hall);
				System.out.print(", Start Time: " + Starttime);
				System.out.println(", End Time: " + Endtime);
			}
			rs.close();
			stmt.close();
		}
		catch ( SQLException e ) {
			e.printStackTrace();
		}
	}

	public void getAgeCountPerMovie( String movieID ) {
		String query = "select U.age, count (distinct U.userID) from Showtimes S join Tickets T on T.showID = S.showID join Users U on U.userID = T.userID WHERE S.MovieID = " + movieID + " GROUP BY U.age";

		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery( query );
			while ( rs.next() ) {
				//Retrieve by column name
				String agetemp = rs.getString("AGE");
				String count = rs.getString("COUNT(DISTINCTU.USERID)");
				
				//Display values
				System.out.print("Age: " + agetemp);
				System.out.println(", Count: " + count);
			}
			rs.close();
			stmt.close();
		}
		catch ( SQLException e ) {}
	}
	
	public static void main( String [] args ) {
		b4_zhao451 sdb = new b4_zhao451();
		System.out.println("Enter movie ID: ");
		Scanner scanner = new Scanner(System.in);
		String MID = scanner.nextLine();
		sdb.getShowsForMovie(MID);
		System.out.println( "-----------------" );
		sdb.getAgeCountPerMovie(MID);
		scanner.close();
	}
}

//select table_name from user_tables;
