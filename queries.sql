
-- SQL PROJECT: User Activity & Settings Analysis
-- Database: PostgreSQL
-- Author: Ahmet Demir


-- Q1: Identifying users who haven't completed the specific survey.
-- Uses simple filtering on the UserSettings table.
SELECT "UserId", "SettingName", "SettingValue"
FROM "UserSettings"
WHERE "SettingName" = 'survey1' AND "SettingValue" = 'false';

-- Q2: Correlating login settings with internship program activities.
-- Uses INNER JOIN to find active users with specific dialog settings.
SELECT da."UserId", da."ActivityDate", us."SettingName"
FROM "DailyActivities" da
INNER JOIN "UserSettings" us ON da."UserId" = us."UserId"
WHERE da."InternshipProgramId" = 1 
  AND us."SettingName" = 'hasGoogleLoginDialogDisplayed'
  AND us."SettingValue" = 'true';

-- Q3: Calculating monthly activity intensity per user.
-- Uses Aggregation and filtering by date range (January 2025).
SELECT "UserId", COUNT(*) as "TotalActivities"
FROM "DailyActivities"
WHERE "ActivityDate" >= '2025-01-01' AND "ActivityDate" < '2025-02-01'
GROUP BY "UserId"
ORDER BY "TotalActivities" DESC;

-- Q4: Users whose settings were updated AFTER their last activity.
-- Uses a Correlated Subquery to find potential configuration desync.
SELECT us."UserId", us."SettingName", us."UpdatedAt"
FROM "UserSettings" us
WHERE us."UpdatedAt" > (
    SELECT MAX(da."ActivityDate")
    FROM "DailyActivities" da
    WHERE da."UserId" = us."UserId"
);

-- Q5: Identifying unique users with 'Login' configurations and specific activity types.
-- Use of DISTINCT is crucial here to avoid row multiplication from JOINs.
SELECT DISTINCT us."UserId"
FROM "UserSettings" us
INNER JOIN "DailyActivities" da ON us."UserId" = da."UserId"
WHERE us."SettingName" LIKE '%Login%' 
  AND da."ActivityType" = 0;

-- Q6: Comprehensive User Engagement Report (CTE + LEFT JOIN).
-- This shows all users with 'survey1' data and their total activity count.
-- LEFT JOIN ensures users with 0 activities are not lost in the report.
WITH UserSurveyStatus AS (
    SELECT "UserId", "SettingValue" AS "SurveyStatus"
    FROM "UserSettings"
    WHERE "SettingName" = 'survey1'
)
SELECT 
    uss."UserId", 
    uss."SurveyStatus", 
    COUNT(da."Id") AS "TotalActivityCount"
FROM UserSurveyStatus uss
LEFT JOIN "DailyActivities" da ON uss."UserId" = da."UserId"
GROUP BY uss."UserId", uss."SurveyStatus";
