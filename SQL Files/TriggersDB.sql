--Triggers
-- Trigger for insertion in dbo.Users table
CREATE TRIGGER trg_InsertUsers
ON dbo.Users
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Username NVARCHAR(MAX)

    SELECT @Username = Username FROM inserted
    SET @Action = 'New user registered. Username: ' + @Username

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.Users table
CREATE TRIGGER trg_DeleteUsers
ON dbo.Users
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Username NVARCHAR(MAX)

    SELECT @Username = Username FROM deleted
    SET @Action = 'User deleted. Username: ' + @Username

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.Users table
CREATE TRIGGER trg_UpdateUsers
ON dbo.Users
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Username NVARCHAR(MAX)

    SELECT @Username = Username FROM inserted
    SET @Action = 'User information updated. Username: ' + @Username

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;


-- Trigger for insertion in dbo.AppointmentWithClients table
CREATE TRIGGER trg_InsertAppointmentWithClients
ON dbo.AppointmentWithClients
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @AppointmentID tinyint
    DECLARE @TrainerID tinyint
    DECLARE @MemberID tinyint
    DECLARE @ActiveTime time(7)
    DECLARE @Fee tinyint

    SELECT @AppointmentID = AppointmentID, 
           @TrainerID = trainer_id, 
           @MemberID = member_id, 
           @ActiveTime = active_time, 
           @Fee = fee
    FROM inserted

    SET @Action = 'New appointment created. AppointmentID: ' + CAST(@AppointmentID AS NVARCHAR(MAX)) + 
                  ', TrainerID: ' + CAST(@TrainerID AS NVARCHAR(MAX)) + 
                  ', MemberID: ' + CAST(@MemberID AS NVARCHAR(MAX)) +
                  ', ActiveTime: ' + CONVERT(NVARCHAR(MAX), @ActiveTime, 114) +
                  ', Fee: ' + CAST(@Fee AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.AppointmentWithClients table
CREATE TRIGGER trg_DeleteAppointmentWithClients
ON dbo.AppointmentWithClients
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @AppointmentID tinyint
    DECLARE @TrainerID tinyint
    DECLARE @MemberID tinyint
    DECLARE @ActiveTime time(7)
    DECLARE @Fee tinyint

    SELECT @AppointmentID = AppointmentID, 
           @TrainerID = trainer_id, 
           @MemberID = member_id, 
           @ActiveTime = active_time, 
           @Fee = fee
    FROM deleted

    SET @Action = 'Appointment deleted. AppointmentID: ' + CAST(@AppointmentID AS NVARCHAR(MAX)) + 
                  ', TrainerID: ' + CAST(@TrainerID AS NVARCHAR(MAX)) + 
                  ', MemberID: ' + CAST(@MemberID AS NVARCHAR(MAX)) +
                  ', ActiveTime: ' + CONVERT(NVARCHAR(MAX), @ActiveTime, 114) +
                  ', Fee: ' + CAST(@Fee AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.AppointmentWithClients table
CREATE TRIGGER trg_UpdateAppointmentWithClients
ON dbo.AppointmentWithClients
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @AppointmentID tinyint
    DECLARE @TrainerID tinyint
    DECLARE @MemberID tinyint
    DECLARE @ActiveTime time(7)
    DECLARE @Fee tinyint

    SELECT @AppointmentID = AppointmentID, 
           @TrainerID = trainer_id, 
           @MemberID = member_id, 
           @ActiveTime = active_time, 
           @Fee = fee
    FROM inserted

    SET @Action = 'Appointment updated. AppointmentID: ' + CAST(@AppointmentID AS NVARCHAR(MAX)) + 
                  ', TrainerID: ' + CAST(@TrainerID AS NVARCHAR(MAX)) + 
                  ', MemberID: ' + CAST(@MemberID AS NVARCHAR(MAX)) +
                  ', ActiveTime: ' + CONVERT(NVARCHAR(MAX), @ActiveTime, 114) +
                  ', Fee: ' + CAST(@Fee AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;
-- Trigger for insertion in dbo.DietPlan table
-- Trigger for insertion in dbo.DietPlan table
CREATE TRIGGER trg_InsertDietPlan
ON dbo.DietPlan
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @Requirements NVARCHAR(50)
    DECLARE @CreatedBy tinyint
    DECLARE @Goal NVARCHAR(50)
    DECLARE @Description NVARCHAR(50)

    SELECT @ID = ID, 
           @Requirements = Requirements, 
           @CreatedBy = [Created_by], 
           @Goal = Goal, 
           @Description = Description
    FROM inserted

    SET @Action = 'New diet plan created. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', Requirements: ' + ISNULL(@Requirements, 'N/A') + 
                  ', CreatedBy: ' + CAST(@CreatedBy AS NVARCHAR(MAX)) +
                  ', Goal: ' + ISNULL(@Goal, 'N/A') +
                  ', Description: ' + ISNULL(@Description, 'N/A')

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.DietPlan table
CREATE TRIGGER trg_DeleteDietPlan
ON dbo.DietPlan
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @Requirements NVARCHAR(50)
    DECLARE @CreatedBy tinyint
    DECLARE @Goal NVARCHAR(50)
    DECLARE @Description NVARCHAR(50)

    SELECT @ID = ID, 
           @Requirements = Requirements, 
           @CreatedBy = [Created_by], 
           @Goal = Goal, 
           @Description = Description
    FROM deleted

    SET @Action = 'Diet plan deleted. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', Requirements: ' + ISNULL(@Requirements, 'N/A') + 
                  ', CreatedBy: ' + CAST(@CreatedBy AS NVARCHAR(MAX)) +
                  ', Goal: ' + ISNULL(@Goal, 'N/A') +
                  ', Description: ' + ISNULL(@Description, 'N/A')

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.DietPlan table
CREATE TRIGGER trg_UpdateDietPlan
ON dbo.DietPlan
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @Requirements NVARCHAR(50)
    DECLARE @CreatedBy tinyint
    DECLARE @Goal NVARCHAR(50)
    DECLARE @Description NVARCHAR(50)

    SELECT @ID = ID, 
           @Requirements = Requirements, 
           @CreatedBy = [Created_by], 
           @Goal = Goal, 
           @Description = Description
    FROM inserted

    SET @Action = 'Diet plan updated. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', Requirements: ' + ISNULL(@Requirements, 'N/A') + 
                  ', CreatedBy: ' + CAST(@CreatedBy AS NVARCHAR(MAX)) +
                  ', Goal: ' + ISNULL(@Goal, 'N/A') +
                  ', Description: ' + ISNULL(@Description, 'N/A')

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;


-- Trigger for insertion in dbo.DP_MEAL table
CREATE TRIGGER trg_InsertDP_MEAL
ON dbo.DP_MEAL
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Diet_ID tinyint
    DECLARE @Meal_ID tinyint

    SELECT @Diet_ID = Diet_ID, 
           @Meal_ID = Meal_ID
    FROM inserted

    SET @Action = 'New DP_MEAL record created. Diet_ID: ' + CAST(@Diet_ID AS NVARCHAR(MAX)) + 
                  ', Meal_ID: ' + CAST(@Meal_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.DP_MEAL table
CREATE TRIGGER trg_DeleteDP_MEAL
ON dbo.DP_MEAL
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Diet_ID tinyint
    DECLARE @Meal_ID tinyint

    SELECT @Diet_ID = Diet_ID, 
           @Meal_ID = Meal_ID
    FROM deleted

    SET @Action = 'DP_MEAL record deleted. Diet_ID: ' + CAST(@Diet_ID AS NVARCHAR(MAX)) + 
                  ', Meal_ID: ' + CAST(@Meal_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.DP_MEAL table
CREATE TRIGGER trg_UpdateDP_MEAL
ON dbo.DP_MEAL
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Diet_ID tinyint
    DECLARE @Meal_ID tinyint

    SELECT @Diet_ID = Diet_ID, 
           @Meal_ID = Meal_ID
    FROM inserted

    SET @Action = 'DP_MEAL record updated. Diet_ID: ' + CAST(@Diet_ID AS NVARCHAR(MAX)) + 
                  ', Meal_ID: ' + CAST(@Meal_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;
-- Trigger for insertion in dbo.Excercise table
CREATE TRIGGER trg_InsertExcercise
ON dbo.Excercise
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ExcerciseID tinyint
    DECLARE @ExcerciseName NVARCHAR(50)

    SELECT @ExcerciseID = Excerciseid, 
           @ExcerciseName = Excercisename
    FROM inserted

    SET @Action = 'New excercise added. ExcerciseID: ' + CAST(@ExcerciseID AS NVARCHAR(MAX)) + 
                  ', ExcerciseName: ' + @ExcerciseName

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.Excercise table
CREATE TRIGGER trg_DeleteExcercise
ON dbo.Excercise
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ExcerciseID tinyint
    DECLARE @ExcerciseName NVARCHAR(50)

    SELECT @ExcerciseID = Excerciseid, 
           @ExcerciseName = Excercisename
    FROM deleted

    SET @Action = 'Excercise deleted. ExcerciseID: ' + CAST(@ExcerciseID AS NVARCHAR(MAX)) + 
                  ', ExcerciseName: ' + @ExcerciseName

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.Excercise table
CREATE TRIGGER trg_UpdateExcercise
ON dbo.Excercise
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ExcerciseID tinyint
    DECLARE @ExcerciseName NVARCHAR(50)

    SELECT @ExcerciseID = Excerciseid, 
           @ExcerciseName = Excercisename
    FROM inserted

    SET @Action = 'Excercise updated. ExcerciseID: ' + CAST(@ExcerciseID AS NVARCHAR(MAX)) + 
                  ', ExcerciseName: ' + @ExcerciseName

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for insertion in dbo.ExerciseMachine table
CREATE TRIGGER trg_InsertExerciseMachine
ON dbo.ExerciseMachine
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ExerciseID tinyint
    DECLARE @MachineID tinyint

    SELECT @ExerciseID = ExerciseID, 
           @MachineID = MachineID
    FROM inserted

    SET @Action = 'New exercise machine assigned. ExerciseID: ' + CAST(@ExerciseID AS NVARCHAR(MAX)) + 
                  ', MachineID: ' + CAST(@MachineID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.ExerciseMachine table
CREATE TRIGGER trg_DeleteExerciseMachine
ON dbo.ExerciseMachine
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ExerciseID tinyint
    DECLARE @MachineID tinyint

    SELECT @ExerciseID = ExerciseID, 
           @MachineID = MachineID
    FROM deleted

    SET @Action = 'Exercise machine assignment deleted. ExerciseID: ' + CAST(@ExerciseID AS NVARCHAR(MAX)) + 
                  ', MachineID: ' + CAST(@MachineID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.ExerciseMachine table
CREATE TRIGGER trg_UpdateExerciseMachine
ON dbo.ExerciseMachine
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ExerciseID tinyint
    DECLARE @MachineID tinyint

    SELECT @ExerciseID = ExerciseID, 
           @MachineID = MachineID
    FROM inserted

    SET @Action = 'Exercise machine assignment updated. ExerciseID: ' + CAST(@ExerciseID AS NVARCHAR(MAX)) + 
                  ', MachineID: ' + CAST(@MachineID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;
-- Trigger for insertion in dbo.Gym table
CREATE TRIGGER trg_InsertGym
ON dbo.Gym
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @OwnerID tinyint
    DECLARE @Location NVARCHAR(50)
    DECLARE @ActiveMembers tinyint
    DECLARE @Trainers tinyint
    DECLARE @Profit smallint

    SELECT @ID = ID, 
           @OwnerID = OwnerID, 
           @Location = Location, 
           @ActiveMembers = ActiveMembers, 
           @Trainers = Trainers, 
           @Profit = Profit
    FROM inserted

    SET @Action = 'New gym added. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', OwnerID: ' + CAST(@OwnerID AS NVARCHAR(MAX)) + 
                  ', Location: ' + @Location +
                  ', ActiveMembers: ' + CAST(@ActiveMembers AS NVARCHAR(MAX)) +
                  ', Trainers: ' + CAST(@Trainers AS NVARCHAR(MAX)) +
                  ', Profit: ' + CAST(@Profit AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.Gym table
CREATE TRIGGER trg_DeleteGym
ON dbo.Gym
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @OwnerID tinyint
    DECLARE @Location NVARCHAR(50)
    DECLARE @ActiveMembers tinyint
    DECLARE @Trainers tinyint
    DECLARE @Profit smallint

    SELECT @ID = ID, 
           @OwnerID = OwnerID, 
           @Location = Location, 
           @ActiveMembers = ActiveMembers, 
           @Trainers = Trainers, 
           @Profit = Profit
    FROM deleted

    SET @Action = 'Gym deleted. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', OwnerID: ' + CAST(@OwnerID AS NVARCHAR(MAX)) + 
                  ', Location: ' + @Location +
                  ', ActiveMembers: ' + CAST(@ActiveMembers AS NVARCHAR(MAX)) +
                  ', Trainers: ' + CAST(@Trainers AS NVARCHAR(MAX)) +
                  ', Profit: ' + CAST(@Profit AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.Gym table
CREATE TRIGGER trg_UpdateGym
ON dbo.Gym
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @OwnerID tinyint
    DECLARE @Location NVARCHAR(50)
    DECLARE @ActiveMembers tinyint
    DECLARE @Trainers tinyint
    DECLARE @Profit smallint

    SELECT @ID = ID, 
           @OwnerID = OwnerID, 
           @Location = Location, 
           @ActiveMembers = ActiveMembers, 
           @Trainers = Trainers, 
           @Profit = Profit
    FROM inserted

    SET @Action = 'Gym updated. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', OwnerID: ' + CAST(@OwnerID AS NVARCHAR(MAX)) + 
                  ', Location: ' + @Location +
                  ', ActiveMembers: ' + CAST(@ActiveMembers AS NVARCHAR(MAX)) +
                  ', Trainers: ' + CAST(@Trainers AS NVARCHAR(MAX)) +
                  ', Profit: ' + CAST(@Profit AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;
-- Trigger for insertion in dbo.Gym RegistrationRequest table
CREATE TRIGGER trg_InsertGymRegistrationRequest
ON dbo.[GymRegistrationRequest]
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Registration_ID tinyint
    DECLARE @GYM_ID tinyint
    DECLARE @Ownership_Info NVARCHAR(50)
    DECLARE @Bool_Recognized NVARCHAR(50)
    DECLARE @Current_Active_Members tinyint
    DECLARE @Location NVARCHAR(50)
    DECLARE @Facility_Specification NVARCHAR(50)

    SELECT @Registration_ID = Registration_ID, 
           @GYM_ID = GYM_ID, 
           @Ownership_Info = Ownership_Info, 
           @Bool_Recognized = Bool_Recognized, 
           @Current_Active_Members = Current_Active_Members, 
           @Location = Location, 
           @Facility_Specification = Facility_Specification
    FROM inserted

    SET @Action = 'New gym registration request added. Registration_ID: ' + CAST(@Registration_ID AS NVARCHAR(MAX)) + 
                  ', GYM_ID: ' + CAST(@GYM_ID AS NVARCHAR(MAX)) + 
                  ', Ownership_Info: ' + @Ownership_Info +
                  ', Bool_Recognized: ' + @Bool_Recognized +
                  ', Current_Active_Members: ' + CAST(@Current_Active_Members AS NVARCHAR(MAX)) +
                  ', Location: ' + @Location +
                  ', Facility_Specification: ' + @Facility_Specification

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.Gym RegistrationRequest table
CREATE TRIGGER trg_DeleteGymRegistrationRequest
ON dbo.[GymRegistrationRequest]
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Registration_ID tinyint
    DECLARE @GYM_ID tinyint
    DECLARE @Ownership_Info NVARCHAR(50)
    DECLARE @Bool_Recognized NVARCHAR(50)
    DECLARE @Current_Active_Members tinyint
    DECLARE @Location NVARCHAR(50)
    DECLARE @Facility_Specification NVARCHAR(50)

    SELECT @Registration_ID = Registration_ID, 
           @GYM_ID = GYM_ID, 
           @Ownership_Info = Ownership_Info, 
           @Bool_Recognized = Bool_Recognized, 
           @Current_Active_Members = Current_Active_Members, 
           @Location = Location, 
           @Facility_Specification = Facility_Specification
    FROM deleted

    SET @Action = 'Gym registration request deleted. Registration_ID: ' + CAST(@Registration_ID AS NVARCHAR(MAX)) + 
                  ', GYM_ID: ' + CAST(@GYM_ID AS NVARCHAR(MAX)) + 
                  ', Ownership_Info: ' + @Ownership_Info +
                  ', Bool_Recognized: ' + @Bool_Recognized +
                  ', Current_Active_Members: ' + CAST(@Current_Active_Members AS NVARCHAR(MAX)) +
                  ', Location: ' + @Location +
                  ', Facility_Specification: ' + @Facility_Specification

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.Gym RegistrationRequest table
CREATE TRIGGER trg_UpdateGymRegistrationRequest
ON dbo.[GymRegistrationRequest]
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Registration_ID tinyint
    DECLARE @GYM_ID tinyint
    DECLARE @Ownership_Info NVARCHAR(50)
    DECLARE @Bool_Recognized NVARCHAR(50)
    DECLARE @Current_Active_Members tinyint
    DECLARE @Location NVARCHAR(50)
    DECLARE @Facility_Specification NVARCHAR(50)

    SELECT @Registration_ID = Registration_ID, 
           @GYM_ID = GYM_ID, 
           @Ownership_Info = Ownership_Info, 
           @Bool_Recognized = Bool_Recognized, 
           @Current_Active_Members = Current_Active_Members, 
           @Location = Location, 
           @Facility_Specification = Facility_Specification
    FROM inserted

    SET @Action = 'Gym registration request updated. Registration_ID: ' + CAST(@Registration_ID AS NVARCHAR(MAX)) + 
                  ', GYM_ID: ' + CAST(@GYM_ID AS NVARCHAR(MAX)) + 
                  ', Ownership_Info: ' + @Ownership_Info +
                  ', Bool_Recognized: ' + @Bool_Recognized +
                  ', Current_Active_Members: ' + CAST(@Current_Active_Members AS NVARCHAR(MAX)) +
                  ', Location: ' + @Location +
                  ', Facility_Specification: ' + @Facility_Specification

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for insertion in dbo.GymReports table
CREATE TRIGGER trg_InsertGymReports
ON dbo.GymReports
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @REPORTID tinyint
    DECLARE @PERFORMANCE NVARCHAR(50)
    DECLARE @CUSTOMER_RATING FLOAT
    DECLARE @ATTENDENCE_RATE FLOAT
    DECLARE @FINANCIAL_PERFORMANCE NVARCHAR(50)
    DECLARE @ATTENDENCE_GROWTH FLOAT
    DECLARE @GYM_ID tinyint

    SELECT @REPORTID = REPORTID, 
           @PERFORMANCE = PERFORMANCE, 
           @CUSTOMER_RATING = CUSTOMER_RATING, 
           @ATTENDENCE_RATE = ATTENDENCE_RATE, 
           @FINANCIAL_PERFORMANCE = FINANCIAL_PERFORMANCE, 
           @ATTENDENCE_GROWTH = ATTENDENCE_GROWTH, 
           @GYM_ID = GYM_ID
    FROM inserted

    SET @Action = 'New gym report added. REPORTID: ' + CAST(@REPORTID AS NVARCHAR(MAX)) + 
                  ', PERFORMANCE: ' + @PERFORMANCE + 
                  ', CUSTOMER_RATING: ' + CAST(@CUSTOMER_RATING AS NVARCHAR(MAX)) +
                  ', ATTENDENCE_RATE: ' + CAST(@ATTENDENCE_RATE AS NVARCHAR(MAX)) +
                  ', FINANCIAL_PERFORMANCE: ' + @FINANCIAL_PERFORMANCE +
                  ', ATTENDENCE_GROWTH: ' + CAST(@ATTENDENCE_GROWTH AS NVARCHAR(MAX)) +
                  ', GYM_ID: ' + CAST(@GYM_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.GymReports table
CREATE TRIGGER trg_DeleteGymReports
ON dbo.GymReports
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @REPORTID tinyint
    DECLARE @PERFORMANCE NVARCHAR(50)
    DECLARE @CUSTOMER_RATING FLOAT
    DECLARE @ATTENDENCE_RATE FLOAT
    DECLARE @FINANCIAL_PERFORMANCE NVARCHAR(50)
    DECLARE @ATTENDENCE_GROWTH FLOAT
    DECLARE @GYM_ID tinyint

    SELECT @REPORTID = REPORTID, 
           @PERFORMANCE = PERFORMANCE, 
           @CUSTOMER_RATING = CUSTOMER_RATING, 
           @ATTENDENCE_RATE = ATTENDENCE_RATE, 
           @FINANCIAL_PERFORMANCE = FINANCIAL_PERFORMANCE, 
           @ATTENDENCE_GROWTH = ATTENDENCE_GROWTH, 
           @GYM_ID = GYM_ID
    FROM deleted

    SET @Action = 'Gym report deleted. REPORTID: ' + CAST(@REPORTID AS NVARCHAR(MAX)) + 
                  ', PERFORMANCE: ' + @PERFORMANCE + 
                  ', CUSTOMER_RATING: ' + CAST(@CUSTOMER_RATING AS NVARCHAR(MAX)) +
                  ', ATTENDENCE_RATE: ' + CAST(@ATTENDENCE_RATE AS NVARCHAR(MAX)) +
                  ', FINANCIAL_PERFORMANCE: ' + @FINANCIAL_PERFORMANCE +
                  ', ATTENDENCE_GROWTH: ' + CAST(@ATTENDENCE_GROWTH AS NVARCHAR(MAX)) +
                  ', GYM_ID: ' + CAST(@GYM_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.GymReports table
CREATE TRIGGER trg_UpdateGymReports
ON dbo.GymReports
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @REPORTID tinyint
    DECLARE @PERFORMANCE NVARCHAR(50)
    DECLARE @CUSTOMER_RATING FLOAT
    DECLARE @ATTENDENCE_RATE FLOAT
    DECLARE @FINANCIAL_PERFORMANCE NVARCHAR(50)
    DECLARE @ATTENDENCE_GROWTH FLOAT
    DECLARE @GYM_ID tinyint

    SELECT @REPORTID = REPORTID, 
           @PERFORMANCE = PERFORMANCE, 
           @CUSTOMER_RATING = CUSTOMER_RATING, 
           @ATTENDENCE_RATE = ATTENDENCE_RATE, 
           @FINANCIAL_PERFORMANCE = FINANCIAL_PERFORMANCE, 
           @ATTENDENCE_GROWTH = ATTENDENCE_GROWTH, 
           @GYM_ID = GYM_ID
    FROM inserted

    SET @Action = 'Gym report updated. REPORTID: ' + CAST(@REPORTID AS NVARCHAR(MAX)) + 
                  ', PERFORMANCE: ' + @PERFORMANCE + 
                  ', CUSTOMER_RATING: ' + CAST(@CUSTOMER_RATING AS NVARCHAR(MAX)) +
                  ', ATTENDENCE_RATE: ' + CAST(@ATTENDENCE_RATE AS NVARCHAR(MAX)) +
                  ', FINANCIAL_PERFORMANCE: ' + @FINANCIAL_PERFORMANCE +
                  ', ATTENDENCE_GROWTH: ' + CAST(@ATTENDENCE_GROWTH AS NVARCHAR(MAX)) +
                  ', GYM_ID: ' + CAST(@GYM_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;
-- Trigger for insertion in dbo.HireNewStaff table
CREATE TRIGGER trg_InsertHireNewStaff
ON dbo.HireNewStaff
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @gym_id tinyint
    DECLARE @user_id tinyint
    DECLARE @ROLE_DEMANDED NVARCHAR(50)

    SELECT @gym_id = gym_id, 
           @user_id = user_id, 
           @ROLE_DEMANDED = ROLE_DEMANDED
    FROM inserted

    SET @Action = 'New staff hiring request added. Gym_ID: ' + CAST(@gym_id AS NVARCHAR(MAX)) + 
                  ', User_ID: ' + CAST(@user_id AS NVARCHAR(MAX)) + 
                  ', Role Demanded: ' + @ROLE_DEMANDED

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.HireNewStaff table
CREATE TRIGGER trg_DeleteHireNewStaff
ON dbo.HireNewStaff
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @gym_id tinyint
    DECLARE @user_id tinyint
    DECLARE @ROLE_DEMANDED NVARCHAR(50)

    SELECT @gym_id = gym_id, 
           @user_id = user_id, 
           @ROLE_DEMANDED = ROLE_DEMANDED
    FROM deleted

    SET @Action = 'Staff hiring request deleted. Gym_ID: ' + CAST(@gym_id AS NVARCHAR(MAX)) + 
                  ', User_ID: ' + CAST(@user_id AS NVARCHAR(MAX)) + 
                  ', Role Demanded: ' + @ROLE_DEMANDED

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.HireNewStaff table
CREATE TRIGGER trg_UpdateHireNewStaff
ON dbo.HireNewStaff
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @gym_id tinyint
    DECLARE @user_id tinyint
    DECLARE @ROLE_DEMANDED NVARCHAR(50)

    SELECT @gym_id = gym_id, 
           @user_id = user_id, 
           @ROLE_DEMANDED = ROLE_DEMANDED
    FROM inserted

    SET @Action = 'Staff hiring request updated. Gym_ID: ' + CAST(@gym_id AS NVARCHAR(MAX)) + 
                  ', User_ID: ' + CAST(@user_id AS NVARCHAR(MAX)) + 
                  ', Role Demanded: ' + @ROLE_DEMANDED

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;
-- Trigger for insertion in dbo.Machine table
CREATE TRIGGER trg_InsertMachine
ON dbo.Machine
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Machine_id tinyint
    DECLARE @Machine_name NVARCHAR(50)
    DECLARE @LastUsed TIME(7)

    SELECT @Machine_id = Machine_id, 
           @Machine_name = Machine_name, 
           @LastUsed = LastUsed
    FROM inserted

    SET @Action = 'New machine added. Machine_ID: ' + CAST(@Machine_id AS NVARCHAR(MAX)) + 
                  ', Machine_name: ' + @Machine_name + 
                  ', LastUsed: ' + CONVERT(NVARCHAR(8), @LastUsed, 108)

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.Machine table
CREATE TRIGGER trg_DeleteMachine
ON dbo.Machine
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Machine_id tinyint
    DECLARE @Machine_name NVARCHAR(50)
    DECLARE @LastUsed TIME(7)

    SELECT @Machine_id = Machine_id, 
           @Machine_name = Machine_name, 
           @LastUsed = LastUsed
    FROM deleted

    SET @Action = 'Machine deleted. Machine_ID: ' + CAST(@Machine_id AS NVARCHAR(MAX)) + 
                  ', Machine_name: ' + @Machine_name + 
                  ', LastUsed: ' + CONVERT(NVARCHAR(8), @LastUsed, 108)

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.Machine table
CREATE TRIGGER trg_UpdateMachine
ON dbo.Machine
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Machine_id tinyint
    DECLARE @Machine_name NVARCHAR(50)
    DECLARE @LastUsed TIME(7)

    SELECT @Machine_id = Machine_id, 
           @Machine_name = Machine_name, 
           @LastUsed = LastUsed
    FROM inserted

    SET @Action = 'Machine updated. Machine_ID: ' + CAST(@Machine_id AS NVARCHAR(MAX)) + 
                  ', Machine_name: ' + @Machine_name + 
                  ', LastUsed: ' + CONVERT(NVARCHAR(8), @LastUsed, 108)

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for insertion in dbo.Meal table
CREATE TRIGGER trg_InsertMeal
ON dbo.Meal
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @Protein_g tinyint
    DECLARE @Carbohydrates_g tinyint
    DECLARE @Fats_g tinyint
    DECLARE @Calories smallint

    SELECT @ID = ID, 
           @Protein_g = Protein_g, 
           @Carbohydrates_g = Carbohydrates_g, 
           @Fats_g = Fats_g, 
           @Calories = Calories
    FROM inserted

    SET @Action = 'New meal added. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', Protein_g: ' + CAST(@Protein_g AS NVARCHAR(MAX)) + 
                  ', Carbohydrates_g: ' + CAST(@Carbohydrates_g AS NVARCHAR(MAX)) + 
                  ', Fats_g: ' + CAST(@Fats_g AS NVARCHAR(MAX)) + 
                  ', Calories: ' + CAST(@Calories AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.Meal table
CREATE TRIGGER trg_DeleteMeal
ON dbo.Meal
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @Protein_g tinyint
    DECLARE @Carbohydrates_g tinyint
    DECLARE @Fats_g tinyint
    DECLARE @Calories smallint

    SELECT @ID = ID, 
           @Protein_g = Protein_g, 
           @Carbohydrates_g = Carbohydrates_g, 
           @Fats_g = Fats_g, 
           @Calories = Calories
    FROM deleted

    SET @Action = 'Meal deleted. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', Protein_g: ' + CAST(@Protein_g AS NVARCHAR(MAX)) + 
                  ', Carbohydrates_g: ' + CAST(@Carbohydrates_g AS NVARCHAR(MAX)) + 
                  ', Fats_g: ' + CAST(@Fats_g AS NVARCHAR(MAX)) + 
                  ', Calories: ' + CAST(@Calories AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.Meal table
CREATE TRIGGER trg_UpdateMeal
ON dbo.Meal
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @Protein_g tinyint
    DECLARE @Carbohydrates_g tinyint
    DECLARE @Fats_g tinyint
    DECLARE @Calories smallint

    SELECT @ID = ID, 
           @Protein_g = Protein_g, 
           @Carbohydrates_g = Carbohydrates_g, 
           @Fats_g = Fats_g, 
           @Calories = Calories
    FROM inserted

    SET @Action = 'Meal updated. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', Protein_g: ' + CAST(@Protein_g AS NVARCHAR(MAX)) + 
                  ', Carbohydrates_g: ' + CAST(@Carbohydrates_g AS NVARCHAR(MAX)) + 
                  ', Fats_g: ' + CAST(@Fats_g AS NVARCHAR(MAX)) + 
                  ', Calories: ' + CAST(@Calories AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for insertion in dbo.Member table
CREATE TRIGGER trg_InsertMember
ON dbo.Member
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @UserID tinyint
    DECLARE @Membership_Fee tinyint
    DECLARE @GymID tinyint

    SELECT @UserID = UserID, 
           @Membership_Fee = Membership_Fee, 
           @GymID = GymID
    FROM inserted

    SET @Action = 'New member added. UserID: ' + CAST(@UserID AS NVARCHAR(MAX)) + 
                  ', Membership Fee: ' + CAST(@Membership_Fee AS NVARCHAR(MAX)) + 
                  ', GymID: ' + CAST(@GymID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.Member table
CREATE TRIGGER trg_DeleteMember
ON dbo.Member
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @UserID tinyint
    DECLARE @Membership_Fee tinyint
    DECLARE @GymID tinyint

    SELECT @UserID = UserID, 
           @Membership_Fee = Membership_Fee, 
           @GymID = GymID
    FROM deleted

    SET @Action = 'Member deleted. UserID: ' + CAST(@UserID AS NVARCHAR(MAX)) + 
                  ', Membership Fee: ' + CAST(@Membership_Fee AS NVARCHAR(MAX)) + 
                  ', GymID: ' + CAST(@GymID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.Member table
CREATE TRIGGER trg_UpdateMember
ON dbo.Member
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @UserID tinyint
    DECLARE @Membership_Fee tinyint
    DECLARE @GymID tinyint

    SELECT @UserID = UserID, 
           @Membership_Fee = Membership_Fee, 
           @GymID = GymID
    FROM inserted

    SET @Action = 'Member updated. UserID: ' + CAST(@UserID AS NVARCHAR(MAX)) + 
                  ', Membership Fee: ' + CAST(@Membership_Fee AS NVARCHAR(MAX)) + 
                  ', GymID: ' + CAST(@GymID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for insertion in dbo.MemberReport table
CREATE TRIGGER trg_InsertMemberReport
ON dbo.MemberReport
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @Rating FLOAT
    DECLARE @Explanation_Text NVARCHAR(250)
    DECLARE @Start_Date DATE
    DECLARE @Member_ID tinyint

    SELECT @ID = ID, 
           @Rating = Rating, 
           @Explanation_Text = Explanation_Text, 
           @Start_Date = Start_Date, 
           @Member_ID = Member_ID
    FROM inserted

    SET @Action = 'New member report added. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', Rating: ' + CAST(@Rating AS NVARCHAR(MAX)) + 
                  ', Explanation Text: ' + @Explanation_Text + 
                  ', Start Date: ' + CONVERT(NVARCHAR(10), @Start_Date, 120) + 
                  ', Member ID: ' + CAST(@Member_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.MemberReport table
CREATE TRIGGER trg_DeleteMemberReport
ON dbo.MemberReport
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @Rating FLOAT
    DECLARE @Explanation_Text NVARCHAR(250)
    DECLARE @Start_Date DATE
    DECLARE @Member_ID tinyint

    SELECT @ID = ID, 
           @Rating = Rating, 
           @Explanation_Text = Explanation_Text, 
           @Start_Date = Start_Date, 
           @Member_ID = Member_ID
    FROM deleted

    SET @Action = 'Member report deleted. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', Rating: ' + CAST(@Rating AS NVARCHAR(MAX)) + 
                  ', Explanation Text: ' + @Explanation_Text + 
                  ', Start Date: ' + CONVERT(NVARCHAR(10), @Start_Date, 120) + 
                  ', Member ID: ' + CAST(@Member_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.MemberReport table
CREATE TRIGGER trg_UpdateMemberReport
ON dbo.MemberReport
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @ID tinyint
    DECLARE @Rating FLOAT
    DECLARE @Explanation_Text NVARCHAR(250)
    DECLARE @Start_Date DATE
    DECLARE @Member_ID tinyint

    SELECT @ID = ID, 
           @Rating = Rating, 
           @Explanation_Text = Explanation_Text, 
           @Start_Date = Start_Date, 
           @Member_ID = Member_ID
    FROM inserted

    SET @Action = 'Member report updated. ID: ' + CAST(@ID AS NVARCHAR(MAX)) + 
                  ', Rating: ' + CAST(@Rating AS NVARCHAR(MAX)) + 
                  ', Explanation Text: ' + @Explanation_Text + 
                  ', Start Date: ' + CONVERT(NVARCHAR(10), @Start_Date, 120) + 
                  ', Member ID: ' + CAST(@Member_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for insertion in dbo.Personal_Training_Session table
CREATE TRIGGER trg_InsertPersonalTrainingSession
ON dbo.Personal_Training_Session
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @SessionID tinyint
    DECLARE @Fees tinyint
    DECLARE @TrainerID tinyint
    DECLARE @MemberID tinyint

    SELECT @SessionID = SessionID, 
           @Fees = Fees, 
           @TrainerID = TrainerID, 
           @MemberID = MemberID
    FROM inserted

    SET @Action = 'New personal training session added. SessionID: ' + CAST(@SessionID AS NVARCHAR(MAX)) + 
                  ', Fees: ' + CAST(@Fees AS NVARCHAR(MAX)) + 
                  ', TrainerID: ' + CAST(@TrainerID AS NVARCHAR(MAX)) + 
                  ', MemberID: ' + CAST(@MemberID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.Personal_Training_Session table
CREATE TRIGGER trg_DeletePersonalTrainingSession
ON dbo.Personal_Training_Session
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @SessionID tinyint
    DECLARE @Fees tinyint
    DECLARE @TrainerID tinyint
    DECLARE @MemberID tinyint

    SELECT @SessionID = SessionID, 
           @Fees = Fees, 
           @TrainerID = TrainerID, 
           @MemberID = MemberID
    FROM deleted

    SET @Action = 'Personal training session deleted. SessionID: ' + CAST(@SessionID AS NVARCHAR(MAX)) + 
                  ', Fees: ' + CAST(@Fees AS NVARCHAR(MAX)) + 
                  ', TrainerID: ' + CAST(@TrainerID AS NVARCHAR(MAX)) + 
                  ', MemberID: ' + CAST(@MemberID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.Personal_Training_Session table
CREATE TRIGGER trg_UpdatePersonalTrainingSession
ON dbo.Personal_Training_Session
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @SessionID tinyint
    DECLARE @Fees tinyint
    DECLARE @TrainerID tinyint
    DECLARE @MemberID tinyint

    SELECT @SessionID = SessionID, 
           @Fees = Fees, 
           @TrainerID = TrainerID, 
           @MemberID = MemberID
    FROM inserted

    SET @Action = 'Personal training session updated. SessionID: ' + CAST(@SessionID AS NVARCHAR(MAX)) + 
                  ', Fees: ' + CAST(@Fees AS NVARCHAR(MAX)) + 
                  ', TrainerID: ' + CAST(@TrainerID AS NVARCHAR(MAX)) + 
                  ', MemberID: ' + CAST(@MemberID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;


-- Trigger for insertion in dbo.WOExercise table
CREATE TRIGGER trg_InsertWOExercise
ON dbo.WOExercise
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Workout_ID tinyint
    DECLARE @Exercise_ID tinyint

    SELECT @Workout_ID = Workout_ID, 
           @Exercise_ID = Exercise_ID
    FROM inserted

    SET @Action = 'New workout exercise added. Workout_ID: ' + CAST(@Workout_ID AS NVARCHAR(MAX)) + 
                  ', Exercise_ID: ' + CAST(@Exercise_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- TrigCREATE TRIGGER trg_DeleteWOExercise
ON dbo.WOExercise
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Workout_ID tinyint
    DECLARE @Exercise_ID tinyint

    SELECT @Workout_ID = Workout_ID, 
           @Exercise_ID = Exercise_ID
    FROM deleted

    SET @Action = 'Workout exercise deleted. Workout_ID: ' + CAST(@Workout_ID AS NVARCHAR(MAX)) + 
                  ', Exercise_ID: ' + CAST(@Exercise_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;ger for deletion in dbo.WOExercise table


-- Trigger for update in dbo.WOExercise table
CREATE TRIGGER trg_UpdateWOExercise
ON dbo.WOExercise
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @Workout_ID tinyint
    DECLARE @Exercise_ID tinyint

    SELECT @Workout_ID = Workout_ID, 
           @Exercise_ID = Exercise_ID
    FROM inserted

    SET @Action = 'Workout exercise updated. Workout_ID: ' + CAST(@Workout_ID AS NVARCHAR(MAX)) + 
                  ', Exercise_ID: ' + CAST(@Exercise_ID AS NVARCHAR(MAX))

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;


-- Trigger for insertion in dbo.WorkoutPlan table
CREATE TRIGGER trg_InsertWorkoutPlan
ON dbo.WorkoutPlan
AFTER INSERT
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @WorkoutID tinyint
    DECLARE @Goals NVARCHAR(50)
    DECLARE @Experience NVARCHAR(50)
    DECLARE @Created_By tinyint
    DECLARE @Privacy NVARCHAR(50)
    DECLARE @Fees tinyint
    DECLARE @Schedule NVARCHAR(50)

    SELECT @WorkoutID = WorkoutID, 
           @Goals = Goals, 
           @Experience = Experience, 
           @Created_By = Created_By, 
           @Privacy = Privacy, 
           @Fees = Fees, 
           @Schedule = Schedule
    FROM inserted

    SET @Action = 'New workout plan added. WorkoutID: ' + CAST(@WorkoutID AS NVARCHAR(MAX)) + 
                  ', Goals: ' + @Goals + 
                  ', Experience: ' + @Experience + 
                  ', Created_By: ' + CAST(@Created_By AS NVARCHAR(MAX)) + 
                  ', Privacy: ' + @Privacy + 
                  ', Fees: ' + CAST(@Fees AS NVARCHAR(MAX)) + 
                  ', Schedule: ' + @Schedule

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for deletion in dbo.WorkoutPlan table
CREATE TRIGGER trg_DeleteWorkoutPlan
ON dbo.WorkoutPlan
AFTER DELETE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @WorkoutID tinyint
    DECLARE @Goals NVARCHAR(50)
    DECLARE @Experience NVARCHAR(50)
    DECLARE @Created_By tinyint
    DECLARE @Privacy NVARCHAR(50)
    DECLARE @Fees tinyint
    DECLARE @Schedule NVARCHAR(50)

    SELECT @WorkoutID = WorkoutID, 
           @Goals = Goals, 
           @Experience = Experience, 
           @Created_By = Created_By, 
           @Privacy = Privacy, 
           @Fees = Fees, 
           @Schedule = Schedule
    FROM deleted

    SET @Action = 'Workout plan deleted. WorkoutID: ' + CAST(@WorkoutID AS NVARCHAR(MAX)) + 
                  ', Goals: ' + @Goals + 
                  ', Experience: ' + @Experience + 
                  ', Created_By: ' + CAST(@Created_By AS NVARCHAR(MAX)) + 
                  ', Privacy: ' + @Privacy + 
                  ', Fees: ' + CAST(@Fees AS NVARCHAR(MAX)) + 
                  ', Schedule: ' + @Schedule

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;

-- Trigger for update in dbo.WorkoutPlan table
CREATE TRIGGER trg_UpdateWorkoutPlan
ON dbo.WorkoutPlan
AFTER UPDATE
AS
BEGIN
    -- Insert action into the audit table
    DECLARE @Action NVARCHAR(MAX)
    DECLARE @WorkoutID tinyint
    DECLARE @Goals NVARCHAR(50)
    DECLARE @Experience NVARCHAR(50)
    DECLARE @Created_By tinyint
    DECLARE @Privacy NVARCHAR(50)
    DECLARE @Fees tinyint
    DECLARE @Schedule NVARCHAR(50)

    SELECT @WorkoutID = WorkoutID, 
           @Goals = Goals, 
           @Experience = Experience, 
           @Created_By = Created_By, 
           @Privacy = Privacy, 
           @Fees = Fees, 
           @Schedule = Schedule
    FROM inserted

    SET @Action = 'Workout plan updated. WorkoutID: ' + CAST(@WorkoutID AS NVARCHAR(MAX)) + 
                  ', Goals: ' + @Goals + 
                  ', Experience: ' + @Experience + 
                  ', Created_By: ' + CAST(@Created_By AS NVARCHAR(MAX)) + 
                  ', Privacy: ' + @Privacy + 
                  ', Fees: ' + CAST(@Fees AS NVARCHAR(MAX)) + 
                  ', Schedule: ' + @Schedule

    INSERT INTO Audit (Action)
    VALUES (@Action)
END;
select * from audit;
select * from users;