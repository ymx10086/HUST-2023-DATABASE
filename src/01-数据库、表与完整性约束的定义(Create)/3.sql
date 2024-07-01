# 请在以下空白处填写完成任务的语句，空白行可通过回车换行添加。
# 你也可以在命令行窗口完成任务，不过，在命令行键入的语句不会被保存。

CREATE DATABASE MyDb;
USE MyDb;
CREATE TABLE dept (
deptNo INT PRIMARY KEY,
deptName varchar(32));
CREATE TABLE staff(
staffNo INT PRIMARY KEY,
staffName varchar(32),
gender char(1),
dob date,
salary numeric(8,2),
deptNo INT,
CONSTRAINT FK_staff_deptNo FOREIGN KEY(deptNo) REFERENCES dept(deptNo));


# 结束 