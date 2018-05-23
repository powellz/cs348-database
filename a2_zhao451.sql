Drop table Interview;
Drop table Candidate;
Drop table Interviewer;
Drop table Position;
Drop table WorkGroup;
Drop table Employee;

CREATE TABLE Employee (
    EmployeeID int CHECK (EmployeeID > 0),
    EmployeeName varchar2(32) NOT NULL,
    Bonus int,
    primary key(EmployeeID)
);

CREATE TABLE WorkGroup (
    GroupID int CHECK (GroupID > 0),
    GroupName varchar2(32) NOT NULL,
    primary key(GroupID)
);

CREATE TABLE Position (
    PositionID int CHECK (PositionID > 0),
	GroupID int NOT NULL,
    PositionName varchar2(32) NOT NULL,
	isOpen int,
    primary key(PositionID),
    foreign key(GroupID) REFERENCES WorkGroup(GroupID)
);

CREATE TABLE Interviewer (
    InterviewerID int CHECK (InterviewerID > 0),
	EmployeeID int NOT NULL,
    InterviewerName varchar2(32) NOT NULL,
    primary key(InterviewerID),
    foreign key(EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Candidate (
    CandidateID int CHECK (CandidateID > 0),
	EmployeeID int NOT NULL,
	PositionID int NOT NULL,
    CandidateName varchar2(32) NOT NULL,
    isHired int,
    primary key(CandidateID),
    foreign key(PositionID) REFERENCES Position(PositionID),
    foreign key(EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Interview (
    InterviewID int CHECK (InterviewID > 0),
	InterviewerID int NOT NULL,
	PositionID int NOT NULL,
	CandidateID int NOT NULL,
    Feedback varchar2(200) NOT NULL,
    isSuccessful int,
    primary key(InterviewID),
    foreign key(InterviewerID) REFERENCES Interviewer(InterviewerID),
    foreign key(PositionID) REFERENCES Position(PositionID),
    foreign key(CandidateID) REFERENCES Candidate(CandidateID)
);
