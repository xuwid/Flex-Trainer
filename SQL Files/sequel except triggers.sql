use GYMDATABASE;

CREATE PROCEDURE UpdateTrainerRatings
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Trainer
    SET Rating = ROUND((
        SELECT AVG(Rating)
        FROM TrainerFeedback
        WHERE Trainer_ID = Trainer.User_ID
        GROUP BY Trainer_ID
    ), 2);
END

use GYMDATABASE

select * from Trainer

ALTER TABLE Membership
ADD CONSTRAINT FK_User_ID_MS
FOREIGN KEY (userID) REFERENCES Member(userID);

ALTER TABLE MemberReport
drop column start_date


ALTER TABLE TrainerChangeRequest
ADD CONSTRAINT PK_User_ID_TP
Primary KEY (RequestID) 
Foreign KEY (TrainerID) REFERENCES Trainer(user_ID);
Foreign KEY (MemberID) REFERENCES Member(userID)


DROP TABLE Membership


ALTER TABLE Member
ADD CONSTRAINT FK_User_ID_M
FOREIGN KEY (userID) REFERENCES Users(user_ID);

ALTER TABLE Member
ADD CONSTRAINT FK_Trainer_ID_M
FOREIGN KEY (TrainerID) REFERENCES Trainer(user_ID);

ALTER TABLE Member
ADD CONSTRAINT FK_DietPlan_ID_M
FOREIGN KEY (DietPlanID) REFERENCES DietPlan(ID);

ALTER TABLE Users
ADD CONSTRAINT UQ_Users_UserID UNIQUE (user_ID);


ALTER TABLE Trainer
ADD CONSTRAINT FK_User_ID_T
FOREIGN KEY (user_ID) REFERENCES Users(user_ID);

ALTER TABLE Member
ADD Constraint FK_M_G
FOREIGN KEY (GymID) REFERENCES Gym(ID);

ALTER TABLE Trainer
ADD Constraint FK_T_G
FOREIGN KEY (GymID) REFERENCES Gym(ID);


ALTER TABLE PhoneNumber
ADD CONSTRAINT FK_User_ID_PN
FOREIGN KEY (user_ID) REFERENCES Users(user_ID);

Alter Table TrainerPastRecord
ADD CONSTRAINT FK_TPR_TID
Foreign Key (ID) REFERENCES Trainer(User_ID)

ALTER TABLE AppointmentWithClients
ADD CONSTRAINT fk_trainer_id
FOREIGN KEY (trainer_id)
REFERENCES Trainer(user_ID);

ALTER TABLE AppointmentWithClients
ADD CONSTRAINT fk_member_id
FOREIGN KEY (member_id)
REFERENCES Member(Userid);

ALTER TABLE MemberReport
ADD CONSTRAINT mr_fk_member_id
FOREIGN KEY (Member_ID)
REFERENCES Member(UserID);


-- For Member_ID
ALTER TABLE TrainerFeedback
ADD CONSTRAINT fk_member_id_tf
FOREIGN KEY (Member_ID)
REFERENCES Member(UserID);

-- For Trainer_id
ALTER TABLE TrainerFeedback
ADD CONSTRAINT fk_trainer_id_tf
FOREIGN KEY (Trainer_id)
REFERENCES Trainer(User_ID);

-- For Member_ID
ALTER TABLE Personal_Training_Session
ADD CONSTRAINT fk_member_id_pts
FOREIGN KEY (MemberID)
REFERENCES Member(UserID);

-- For Trainer_id
ALTER TABLE Personal_Training_Session
ADD CONSTRAINT fk_trainer_id_pts
FOREIGN KEY (Trainerid)
REFERENCES Trainer(User_ID);

-- For Trainer_id
ALTER TABLE TrainerReport
ADD CONSTRAINT fk_trainer_id_tr
FOREIGN KEY (id)
REFERENCES Trainer(User_ID);

-- For Gym_iD
ALTER TABLE GymReports
ADD CONSTRAINT fk_gym_id_gr
FOREIGN KEY (GYM_ID)
REFERENCES GYM(ID);

--For UserID
ALTER TABLE WorkoutPlan
ADD CONSTRAINT fk_user_id_WP
FOREIGN KEY (created_by)
REFERENCES users(user_ID);

--For UserID
ALTER TABLE DietPlan
ADD CONSTRAINT fk_user_id_DP
FOREIGN KEY (created_by)
REFERENCES users(user_ID);



--For UserID
ALTER TABLE HireNewStaff
ADD CONSTRAINT fk_user_id_hns
FOREIGN KEY (user_id)
REFERENCES users(user_ID);

--For GymID
ALTER TABLE HireNewStaff
ADD CONSTRAINT fk_gym_id_hns
FOREIGN KEY (gym_id)
REFERENCES gym(ID);

--For DietPlan
ALTER TABLE DP_MEAL
ADD CONSTRAINT FK_DP_ID_DPM
FOREIGN KEY (DIET_ID)
REFERENCES DIETPLAN(ID)

--For Meal
ALTER TABLE DP_MEAL
ADD CONSTRAINT FK_MEAL_ID_DPM
FOREIGN KEY (MEAL_ID)
REFERENCES MEAL(ID)

--For WorkoutPlan
ALTER TABLE WOExercise
ADD CONSTRAINT FK_WO_ID_WOE
FOREIGN KEY (Workout_ID)
REFERENCES WORKOUTPLAN(WorkoutID)

--For Exercise
ALTER TABLE WOExercise
ADD CONSTRAINT FK_EXERCISE_ID_WOE
FOREIGN KEY (Exercise_ID)
REFERENCES Excercise(ExcerciseID)


--For Exercise
ALTER TABLE ExerciseMAchine
ADD CONSTRAINT FK_E_ID_EM
FOREIGN KEY (ExerciseID)
REFERENCES Excercise(ExcerciseID)

--For Machine
ALTER TABLE ExerciseMachine
ADD CONSTRAINT FK_M_ID_WOE
FOREIGN KEY (MachineID)
REFERENCES Machine(Machine_ID)

ALTER TABLE Users
ALTER COLUMN Requested VARCHAR(50);

ALTER TABLE Users
ALTER COLUMN UserID INT IDENTITY(1,1);

Alter Table Meal
Drop column Membership_Fees

Alter Table TrainerReport
add Rating  tinyint


UPDATE Meal
SET Allergens = 'Eggs'
where ID%3=0
select * from Meal

drop trigger trg_InsertTrainerReports

UPDATE Member
SET GymID = 2
where UserID >26 AND UserID<31
select * from member

select * from member
 join trainer on member.gymid = trainer.gymiD


CREATE PROCEDURE GetMembersForTrainerAndGym
    @TrainerID TINYINT,
    @GymID TINYINT
AS
BEGIN
    SELECT u.User_ID,u.Name,u.CNIC,u.Address,m.Membership_Fee,m.GymID,m.TrainerID,m.DietPlanID    
	FROM Member m
	INNER JOIN Users u ON u.User_ID = m.UserID

    INNER JOIN Trainer t ON m.TrainerID = t.user_ID
    WHERE m.GymID = @GymID AND t.User_ID = @TrainerID;
END
DROP procedure GetMembersForTrainerAndGym

exec GetMembersForTrainerAndGym 4, 1 

CREATE PROCEDURE GetMembersForGymAndDietPlan
    @GymID TINYINT,
    @DietPlanID TINYINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT u.User_ID,u.Name,u.CNIC,u.Address,m.Membership_Fee,m.GymID,m.TrainerID,m.DietPlanID
    FROM Member m
	INNER JOIN Users u ON u.User_ID = m.UserID
    INNER JOIN DietPlan dpm ON m.DietPlanID = dpm.ID
    WHERE m.GymID = @GymID
    AND dpm.ID = @DietPlanID;
END

exec GetMembersForGymAndDietPlan 1, 2


CREATE PROCEDURE GetMembersForTrainerAndDietPlan
    @TrainerID TINYINT,
    @DietPlanID TINYINT
AS
BEGIN
    SET NOCOUNT ON;
	
    SELECT u.User_ID,u.Name,u.CNIC,u.Address,m.Membership_Fee,m.GymID,m.TrainerID,m.DietPlanID
    FROM Member m
	INNER JOIN Users u ON u.User_ID = m.UserID
	where TrainerID = @TrainerID 
	AND DietPlanID = @DietPlanID;
END

exec GetMembersForTrainerAndDietPlan 6,9
CREATE PROCEDURE GetMachineUsageCount
    @GymID INT,
    @Day DATE,
    @MachineID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT COUNT(*) AS UsageCount
    FROM MemberUsage as mu
	JOIN member on mu.memberID = member.userID
    WHERE GymID = @GymID
    AND mu.UsageDate = @Day
    AND MachineID = @MachineID;
END

    SELECT * 
    FROM MemberUsage as mu
	JOIN member on mu.memberID = member.userID
    WHERE GymID = 2
    AND MachineID = 2;
    AND mu.UsageDate = '13:00:00.0000000'

	
exec GetMachineUsageCount 1, '2024-04-14', 4;
EXEC GetMachineUsageCount @GymID, @Day, @MachineID;

CREATE PROCEDURE DietLowCalorieBreakfast
    @MaxCalories INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT dp.*
    FROM DietPlan dp
	INNER JOIN DP_MEAL dpm ON dpm.Diet_Id = dp.ID
    INNER JOIN Meal m ON dpm.Meal_ID = m.ID
    WHERE m.Type = 'Breakfast' 
    AND m.Calories < @MaxCalories;
END

DROP PROCEDURE DietLowCalorieBreakfast

EXEC DietLowCalorieBreakfast 500

CREATE PROCEDURE GetDietPlansWithLowCarbohydrateIntake
    @MaxCarbohydrates DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT dp.*
    FROM DietPlan dp
    INNER JOIN (
        SELECT dp.Diet_ID, SUM(m.Carbohydrates_g) AS TotalCarbohydrates
        FROM dp_Meal dp
        INNER JOIN Meal m ON dp.Meal_ID = m.ID
        GROUP BY dp.Diet_ID
    ) AS DietPlanCarbs ON dp.ID = DietPlanCarbs.Diet_Id
    WHERE DietPlanCarbs.TotalCarbohydrates < @MaxCarbohydrates;
END

EXEC GetDietPlansWithLowCarbohydrateIntake @MaxCarbohydrates

CREATE PROCEDURE GetWorkoutPlansWithoutSpecificMachine
    @MachineID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT wp.*
    FROM WorkoutPlan wp
    JOIN WOExercise woe ON wp.WorkoutID = woe.Workout_ID
    JOIN Excercise e ON woe.Exercise_ID = e.Excerciseid
    JOIN ExerciseMachine em ON e.Excerciseid = em.ExerciseID
    WHERE em.MachineID <> @MachineID OR em.MachineID IS NULL;
END

EXEC GetWorkoutPlansWithoutSpecificMachine 2

CREATE PROCEDURE CompareTotalMembersInGymsPast6Months
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATETIME = DATEADD(MONTH, -6, GETDATE());
    DECLARE @EndDate DATETIME = GETDATE();

    SELECT g.ID, COUNT(m.UserID) AS TotalMembers
    FROM Gym g
    JOIN Member m ON m.GymID = g.ID
    JOIN Membership ms ON m.UserID = ms.UserID
    WHERE ms.JoinDate BETWEEN @StartDate AND @EndDate
    GROUP BY g.ID;
END


DROP PROCEDURE CompareTotalMembersInGymsPast6Months


EXEC GetDietPlansWithoutPeanutsAllergen 'Peanuts'


CREATE PROCEDURE CompareTotalMembersInGymsPast6Months
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATETIME = DATEADD(MONTH, -6, GETDATE());
    DECLARE @EndDate DATETIME = GETDATE();

    SELECT g.ID, COUNT(m.UserID) AS TotalMembers, @StartDate, @EndDate
    FROM Gym g
	JOIN Member m on m.GymID = g.ID
    JOIN Membership ms ON m.USerID = ms.UserID
    WHERE ms.JoinDate BETWEEN @StartDate AND @EndDate
    GROUP BY g.ID;
END

EXEC CompareTotalMembersInGymsPast6Months


CREATE PROCEDURE GetNewMembershipsLast3Months
    @OwnerID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATETIME = DATEADD(MONTH, -3, GETDATE());
    DECLARE @EndDate DATETIME = GETDATE();

    SELECT ms.*
    FROM Membership ms
	JOIN member m on ms.userID = m.UserID
    INNER JOIN Gym g ON m.GymID = g.ID
    WHERE g.OwnerID = 2
    AND ms.JoinDate BETWEEN @StartDate AND @EndDate;
END

EXEC GetNewMembershipsLast3Months 2


CREATE PROCEDURE NewMembersByMonth
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATETIME = DATEADD(YEAR, -1, GETDATE());
    DECLARE @EndDate DATETIME = GETDATE();

    SELECT g.ID AS GYMID , MONTH(ms.JoinDate) AS JoinMonth, YEAR(ms.JoinDate) AS JoinYear, COUNT(m.UserID) AS NewMembers
    FROM Gym g
    JOIN Member m ON m.GymID = g.ID
    JOIN Membership ms ON m.UserID = ms.UserID
    WHERE ms.JoinDate BETWEEN @StartDate AND @EndDate
    GROUP BY g.ID, YEAR(ms.JoinDate), MONTH(ms.JoinDate)
    ORDER BY g.ID, JoinYear, JoinMonth;
END

exec NewMembersByMonth

CREATE PROCEDURE ActiveMembersByGym
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATETIME = DATEADD(MONTH, -6, GETDATE());
    DECLARE @EndDate DATETIME = GETDATE();

    SELECT g.ID, COUNT(DISTINCT m.UserID) AS ActiveMembers
    FROM Gym g
    JOIN Member m ON m.GymID = g.ID
    JOIN Membership ms ON m.UserID = ms.UserID
    WHERE ms. BETWEEN @StartDate AND @EndDate
    GROUP BY g.ID;
END

select * from membership

CREATE PROCEDURE TopRatedTrainers
AS
BEGIN
    SET NOCOUNT ON;

    SELECT u.Name, t.User_ID, t.rating AS AvgRating, t.GymID
    FROM Trainer t
	JOIN users u on t.User_ID = u.User_ID
    ORDER BY AvgRating DESC;
END		

DROP Procedure TopRatedTrainers



CREATE PROCEDURE TrainersWithNoFeedback
AS
BEGIN
    SET NOCOUNT ON;

    SELECT t.User_ID, u.Name
    FROM Trainer t
	JOIN Users u on t.User_ID = u.User_ID
    LEFT JOIN TrainerFeedback tf ON t.User_ID = tf.Trainer_ID
    WHERE tf.Feedback_ID IS NULL;
END
CREATE PROCEDURE GetMemberReports
@OwnerID TINYINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT m.UserID,
           u.CNIC,
           u.Name,
           u.Address,
           mr.Rating,
           m.TrainerID,
           ms.JoinDate,
           ms.ExpirationDate,
           ms.MembershipStatus,
           ms.MembershipType,
           mr.Explanation_Text AS reviews
    FROM member m
    JOIN users u ON m.UserID = u.User_ID
    JOIN membership ms ON m.UserID = ms.UserID
    JOIN MemberReport mr ON m.UserID = mr.Member_ID
	where m.GymID = (
	select ID 
	from gym 
	where OwnerID = @OwnerID
	)
END

EXEC GetMemberReports 3
DROP PROCEDURE 
TrainerReportsWithName
GetMemberReportsFromName
GetMemberReports

CREATE PROCEDURE GetMemberReportsFromName
@OwnerID TINYINT,
@NAME varchar(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT m.UserID,
           u.CNIC,
           u.Name,
           u.Address,
           mr.Rating,
           m.TrainerID,
           ms.JoinDate,
           ms.ExpirationDate,
           ms.MembershipStatus,
           ms.MembershipType,
           mr.Explanation_Text AS reviews
    FROM member m
    JOIN users u ON m.UserID = u.User_ID
    JOIN membership ms ON m.UserID = ms.UserID
    JOIN MemberReport mr ON m.UserID = mr.Member_ID
	where m.GymID = (
	select ID 
	from gym 
	where OwnerID = @OwnerID
	) AND u.Name LIKE '%'+@NAME+'%';
END
CREATE PROCEDURE TrainerReports
@OwnerID TINYINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT t.User_ID,
           u.CNIC,
           u.Name,
           u.Address,
           t.Rating,
           t.hours_worked,
           t.Monthly_Salary,
           tr.PERFORMANCE,
           tr.NO_OF_CLIENTS,
           tr.EXPERIENCE
    FROM trainer t
    JOIN Users u ON u.User_ID = t.User_ID
    JOIN TrainerReport tr ON t.User_ID = tr.ID
	where t.GymID = (
	select ID 
	from gym 
	where ownerID = @OwnerID
	)
END

select * from TrainerReport

insert into TrainerReport (ID,Performance,Experience,NO_OF_CLIENTS,Rating) Values (52,'High',4,1,4)

select * from Trainer  t
    JOIN TrainerReport tr ON t.User_ID = tr.ID
join users u on u.User_ID = t.User_ID

where t.GymID = 2

Update member
set TrainerID = 52 where USERID = 10

Update TrainerChangeRequest
set Status = 'Approved'
where memberid = 10

exec TrainerReports 2
exec TrainerReports 3



DROP PROCEDURE 
TrainerReports

CREATE PROCEDURE TrainerReportsWithName
@OwnerID TINYINT,
@name varchar(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT t.User_ID,
           u.CNIC,
           u.Name,
           u.Address,
           t.Rating,
           t.hours_worked,
           t.Monthly_Salary,
           tr.PERFORMANCE,
           tr.NO_OF_CLIENTS,
           tr.EXPERIENCE
    FROM trainer t
    JOIN Users u ON u.User_ID = t.User_ID
    JOIN TrainerReport tr ON t.User_ID = tr.ID
	where t.GymID = (
	select ID 
	from gym 
	where ownerID = @OwnerID
	) AND u.Name LIKE '%'+ @name + '%'
END

TrainerReportsWithName 2 , e


update trainerreport
set NO_OF_CLIENTS = 6 
where ID = 4

DROP Procedure GetTrainerChangeRequests

CREATE PROCEDURE GetTrainerChangeRequests
@GymID TINYINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        m.UserID AS member,
        u.Name AS memberName,
        u.CNIC AS memberCNIC,
        t1.User_ID AS TrainerID,
        u2.Name AS TrainerName,
        u2.CNIC AS TrainerCNIC,
        t.User_ID AS RequestedTrainerID,
        u1.Name AS RequestedTrainerName,
        u1.CNIC AS RequestedTrainerCNIC
    FROM
        TrainerChangeRequest tcr
    JOIN
        member m ON tcr.MemberID = m.UserID
    JOIN
        users u ON u.User_ID = m.UserID
    JOIN
        Trainer t1 ON m.TrainerID = t1.User_ID
    JOIN
        users u2 ON u2.User_ID = t1.User_ID
    JOIN
        Trainer t ON tcr.TrainerID = t.User_ID
    JOIN
        users u1 ON u1.User_ID = t.User_ID
	JOIN
		GYM g on m.GymID = g.ID
	WHERE 
		tcr.status = 'pending'
		AND g.OwnerID = @GymID;
END


EXEC
GetTrainerChangeRequests 2

use GYMDATABASE

CREATE PROCEDURE GetTrainersExceptUser
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.user_ID,
        u.CNIC,
        u.name,
        t.GYMID,
        t.Rating 
    FROM
        Trainer AS t 
    JOIN
        users AS u ON t.user_id = u.user_id
    WHERE
        t.user_id NOT IN (
            SELECT
                trainerid 
            FROM
                member 
            WHERE
                userid = @UserID
        );
END

EXEC GetTrainersExceptUser @UserID = 30;


select * from TrainerChangeRequest;

CREATE PROCEDURE DeclineTrainerChangeRequest
    @MemberID INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE TrainerChangeRequest
    SET Status = 'Declined'
    WHERE MemberID = @MemberID;
END




EXEC DeclineTrainerChangeRequest @MemberID = 2;


update  TrainerChangeRequest
set Status='Declined' where MemberID=2;

exec GetTrainerChangeRequests 3;



CREATE PROCEDURE AcceptTrainerChangeRequest
    @MemberID TINYINT,
    @TrainerID TINYINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update TrainerChangeRequest status to 'Accept'
    UPDATE TrainerChangeRequest
    SET Status = 'Accept'
    WHERE MemberID = @MemberID;

    -- Decrease NO_OF_CLIENTS for the previous trainer
    UPDATE TrainerReport
    SET NO_OF_CLIENTS = NO_OF_CLIENTS - 1
    WHERE ID = (
        SELECT TrainerID 
        FROM Member
        WHERE UserID = @MemberID
    );

    -- Assign new TrainerID to the member
    UPDATE Member
    SET TrainerID = @TrainerID
    WHERE UserID = @MemberID;

    -- Increase NO_OF_CLIENTS for the new trainer
    UPDATE TrainerReport
    SET NO_OF_CLIENTS = NO_OF_CLIENTS + 1
    WHERE ID = @TrainerID;
END

EXEC AcceptTrainerChangeRequest @MemberID ,@TrainerID;
use GYMDATABASE
exec GetMembersForTrainerAndGym 4,1
select * from TrainerReport

select * from TrainerChangeRequest	;

exec GetMachineUsageCount 1, '13:00:00.0000000', 3;

select * from  Machine;


select * from Excercise;

SELECT
    MembershipType,
    SUM(CASE WHEN MembershipType = 'Monthly' THEN m.Membership_Fee ELSE 0 END) AS MonthlyRevenue,
    SUM(CASE WHEN MembershipType = 'Annual' THEN m.Membership_Fee ELSE 0 END) AS AnnualRevenue,
    SUM(CASE WHEN MembershipType = 'Premium' THEN m.Membership_Fee ELSE 0 END) AS PremiumRevenue
FROM
    Membership ms
	join Member as m on MembershipID=m.UserID
GROUP BY
    MembershipType;

	CREATE PROCEDURE GetAppointmentDetails
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        B.AppointmentID as AppointmentNo,
        B.Trainer_ID as Trainer,
        u.Name AS Trainer_Name,
        B.Member_ID as Member,
        u1.Name AS Member_Name,
        B.active_time as activeTime,
        B.fee as Fee,
		m.GymID as Gym
		
    FROM
        AppointmentWithClients B
    JOIN
        Trainer T ON B.Trainer_ID = T.user_ID
    JOIN
        Users u ON T.User_ID = u.User_ID
    JOIN
        Member M ON B.Member_ID = M.UserID
    JOIN
        Users u1 ON M.UserID = u1.User_ID
	order by m.GymID,
			 B.active_time;
END;


SELECT 
    G.ID,
    G.Location,
    COUNT(M.UserID) AS MemberCount
FROM 
    Gym G
JOIN 
    Member M ON G.ID = M.GymID
GROUP BY 
    G.ID, G.Location
ORDER BY 
    COUNT(M.UserID) DESC;

	CREATE PROCEDURE GetGymMemberCount
AS
BEGIN
    SELECT 
        G.ID,
        G.Location,
        COUNT(M.UserID) AS MemberCount
    FROM 
        Gym G
    JOIN 
        Member M ON G.ID = M.GymID
    GROUP BY 
        G.ID, G.Location
    ORDER BY 
        COUNT(M.UserID) DESC;
END;

CREATE PROCEDURE GetWorkoutPlansForWeightLoss
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
        WP.*
    FROM 
        WorkoutPlan WP
    JOIN 
        WOExercise WPE ON WP.WorkoutID = WPE.Workout_ID
    JOIN 
        Excercise E ON WPE.Exercise_ID = E.Excerciseid
    WHERE 
        WP.Goals = 'Weight Loss';
END;

GROUP BY 
    WP.WorkoutID, WP.Goals;

	CREATE PROCEDURE GetDietPlansWithMealsOrderedByCalories
AS
BEGIN
    SET NOCOUNT ON;

    SELECT dp.*, m.*
    FROM DietPlan dp
    JOIN DP_MEAL dpm ON dp.ID = dpm.Diet_Id
    JOIN Meal m ON m.ID = dpm.Meal_ID
    ORDER BY m.Calories;
END;
CREATE PROCEDURE GetDietPlansWithSpecificMealAndNoEggs
AS
BEGIN
    SET NOCOUNT ON;

    SELECT dp.*, m.*
    FROM DietPlan dp
    JOIN DP_MEAL dpm ON dp.ID = dpm.Diet_Id
    JOIN Meal m ON m.ID = dpm.Meal_ID
	WHERE m.Type = 'Dinner' AND Allergens <> 'Eggs';
END;


CREATE PROCEDURE GetGymsWithFeesGreaterThan56
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 G.*,MAX(M.Membership_Fee) as Max_Membership_Fee
    FROM Gym G 
    JOIN Member M ON G.ID = M.GymID
    GROUP BY G.ID, G.Location,g.OwnerID,g.ActiveMembers,g.Trainers,g.Profit
    HAVING MAX(M.Membership_Fee) > 56;
END;

drop procedure GetGymsWithFeesGreaterThan1000



select  * from users where Role='Role' and Requested='Owner';

select * from users;


select * from users;

CREATE PROCEDURE AddGymAndReport
    @Location NVARCHAR(50),
    @ownerID TINYINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @gymid TINYINT;
    DECLARE @gymrid TINYINT;

    -- Get the next available gym ID
    SELECT @gymid = ISNULL(MAX(ID) + 1, 1) FROM gym;

    -- Get the next available gym report ID
    SELECT @gymrid = ISNULL(MAX(REPORTID) + 1, 1) FROM gymreports;

    -- Update user role and status
    UPDATE Users 
    SET Requested = NULL,
        Role = 'Owner' 
    WHERE User_ID = @ownerID;

    -- Insert gym report

    -- Insert gym
    INSERT INTO gym
    VALUES (@gymid, @ownerID, @Location, 0, 0, 0, 'Active');

    INSERT INTO GymReports 
    VALUES (@gymrid, 'Low', 5, 0, 'Good', 0, @gymid);
END;

DROP PROCEDURE AddGymAndReport

select* from gymreports


EXEC AddGymAndReport  'ISLAMABAD', 54;

select* from gym
delete  from gym
where id=3;


select GymReports.* , OwnerID,gym.Location,ActiveMembers,Trainers,Profit from GymReports
join gym on GymReports.GYM_ID=gym.ID;


select * from gym;


CREATE PROCEDURE DeleteGym
    @gymID TINYINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ownerID TINYINT;
    -- Get the owner ID of the gym
    SELECT @ownerID = ownerID FROM gym WHERE ID = @gymID;

    -- Update owner's role and status
    UPDATE Users 
    SET Role = 'role', 
        Requested = 'Owner' 
    WHERE User_ID = @ownerID;

    -- Update members' roles and status
    UPDATE Users
    SET Role = 'Role',
        Requested = 'Member1'
    WHERE User_ID IN (SELECT UserID FROM member WHERE GymID = @gymID);

    -- Update trainers' roles and status
    UPDATE Users
    SET Role = 'Role',
        Requested = 'Trainer1'
    WHERE User_ID IN (SELECT User_ID FROM trainer WHERE GymID = @gymID);

    -- Update gym activity status
    UPDATE gym
    SET Activity = 'Inactive'
    WHERE ID = @gymID;
END;

exec deletegym 4




alter table gym 
add Activity varchar (50);

update gym
set Activity = 'Active'

CREATE PROCEDURE DeleteMember
    @userid INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Decrease the number of clients for the associated trainer in TrainerReport
    UPDATE TrainerReport
    SET NO_OF_CLIENTS = NO_OF_CLIENTS - 1
    WHERE id = (SELECT Trainerid FROM member WHERE userid = @userid);

    -- Decrease the number of active members for the associated gym in Gym table
    UPDATE Gym
    SET ActiveMembers = ActiveMembers - 1
    WHERE ID = (SELECT gymid FROM member WHERE userid = @userid);

    -- Set membership fee to 0 for the member
    UPDATE Member
    SET Membership_Fee = 0
    WHERE UserID = @userid;

    -- Update user role and requested status
    UPDATE Users
    SET Role = 'Role',
        Requested = NULL
    WHERE User_ID = @userid;
END;

exec
drop procedure
DeleteMember 48;



select * from TrainerReport


update users set role='Role' , Requested ='Member1' where User_ID=48;
select * from Users;
select * from gym;

use GYMDATABASE

update gym
set ActiveMembers =
(
SELECT COUNT (*) FROM member
join users on users.User_ID = Member.UserID
where users.Role ='member'and
member.GymID = gym.ID
);
select * from gym

drop procedure UpdateMemberGym

CREATE PROCEDURE UpdateMemberGym
@userid INT,
@GymID INT
AS
BEGIN
	UPDATE Member
    SET gymID = @GymID
    WHERE UserID = @userid;
    -- Update the ActiveMembers count in the Gym table

	
	update users set role='Member' ,
	Requested =NULL 
	where User_ID=@userid;
    
	update gym
	set ActiveMembers =
	(
	SELECT COUNT (*) FROM member
	join users on users.User_ID = Member.UserID
	where users.Role ='member'and
	member.GymID = gym.ID
	);

    -- Update the gymID for the member
    
END;
	update users set Role='Role', Requested='Member1' where User_ID=48;
	exec UpdateMemberGym 48,2

select * from gym
select * from gym where activity = 'Active'
select * from member;

update Member set gymId=1 where userID=48;


delete from Machine where Machine_id>22
select * from users;

Declare @machinename varchar(30)='ButterFly';
INSERT INTO machine (Machine_id, machine_name, lastused)
VALUES ((SELECT ISNULL(MAX(Machine_id), 0) + 1 FROM machine), 'ButterFly', GETDATE();

select * from Machine
select * from Excercise;
select * from ExerciseMachine;

insert into ExerciseMachine VALUES (2,26);

                    string query1 = "select max(machine_id) FROM machine)";
					SELECT ISNULL(MAX(machine_id), 0) FROM machine



					select * from AppointmentWithClients;


					select Member.*,Users.name , users.CNIC
					from Member
					join users on users.User_ID=member.UserID where trainerId=9;


					select * from TrainerPastRecord;


					select * 
					from DietPlan 
					where Created_by = 6

					select * from Meal


					select * from DP_MEAL
					insert into DP_MEAL values(@Dietid,@mealid)
					SELECT MAX(ID) FROM DietPlan

	select * from trainer

	select * from Member

	DROP PROCEDURE DeleteTrainer
	
CREATE PROCEDURE DeleteTrainer
    @userid INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Decrease the number of clients for the associated trainer in TrainerReport
    UPDATE TrainerReport
    SET NO_OF_CLIENTS = 0
    WHERE id = @userid;

    -- Decrease the number of active members for the associated gym in Gym table
update users set role='Member' ,
	Requested =NULL 
	where User_ID=@userid;
    
	update gym
	set Trainers =
	(
	SELECT COUNT (*) FROM Trainer
	join users on users.User_ID = Trainer.User_ID
	where users.Role ='trainer'and
	Trainer.GymID = gym.ID
	);

    -- Set membership fee to 0 for the member
    
    -- Update user role and requested status
    UPDATE Users
    SET Role = 'Role',
        Requested = NULL
    WHERE User_ID = @userid;

	Update Member
	set TrainerID = (
	select min(USER_ID) from users 
	where role = 'Trainer'
	)
	where UserID IN (
	select userID 
	from member where TrainerID = @userid);

END

select * from users


EXEC DeleteTrainer 5;

select * from users;



CREATE PROCEDURE UpdateTrainerGym
@userid INT,
@GymID INT
AS
BEGIN
	UPDATE Trainer
    SET gymID = @GymID
    WHERE User_ID = @userid;
    -- Update the ActiveMembers count in the Gym table

	
	update users set role='Trainer' ,
	Requested =NULL 
	where User_ID=@userid;
    
	update gym
	set Trainers =
	(
	SELECT COUNT (*) FROM Trainer
	join users on users.User_ID = Trainer.User_ID
	where users.Role ='trainer'and
	Trainer.GymID = gym.ID
	);

    -- Update the gymID for the member

	exec DeleteTrainer 4;
    
END;
select * from gym;
select * from users;
update  Users set Role='Role', Requested='trainer1' where User_ID=52;

exec UpdateTrainergym 4,2;  


select * from users;