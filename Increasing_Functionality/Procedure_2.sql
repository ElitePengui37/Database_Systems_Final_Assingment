DELIMITER // -- prevents ; from ending the procedure

CREATE PROCEDURE CheckIfJudge ( -- uses in and out paramaters
    IN In_Code INTEGER,
    OUT Out_Name VARCHAR(255),
    OUT Out_Function VARCHAR(32), 
    OUT Out_Judge_Count INT
)
BEGIN
    DECLARE `Temp_Function` VARCHAR(32); -- declares variables for procedure
    DECLARE Total_Judges INT DEFAULT 0;

    -- Retrieve Name and Function
    SELECT Name, `Function` INTO Out_Name, `Temp_Function`
    FROM Technical_Officials
    WHERE Code = In_Code;

    -- Check if Function is Judge
    IF `Temp_Function` = 'Judge' THEN -- if else statement
        SELECT COUNT(*) INTO Out_Judge_Count -- Count the number of judges
        FROM Technical_Officials
        WHERE `Function` = 'Judge';

        SET Out_Function = 'Judge'; -- sets out variable

    ELSE
        -- If not judge set function to NULL
        SET Out_Function = NULL;
        
        SELECT COUNT(*) INTO Out_Judge_Count -- count the number of judges
        FROM Technical_Officials
        WHERE `Function` = 'Judge';
        
        
    END IF;

END //

DELIMITER ; -- delimiter reset back to default






-- creating initial OUT variables
SET @Out_Name = '';
SET @Out_Function = '';
SET @Out_Judge_Count = NULL;


-- calling procedure
CALL CheckIfJudge(4968543, @Out_Name, @Out_Function, @Out_Judge_Count); -- calling Judge ID

-- Check if it works
SELECT @Out_Name AS Name, @Out_Function AS `Function`, @Out_Judge_Count AS `Judge Count`;





-- calling non Judge ID
CALL CheckIfJudge(4654138, @Out_Name, @Out_Function, @Out_Judge_Count);

SELECT @Out_Name AS Name, @Out_Function AS `Function`, @Out_Judge_Count AS `Judge Count`;



