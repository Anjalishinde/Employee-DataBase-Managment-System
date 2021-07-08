CREATE database my_db1;
#drop database my_db1;
use my_db1;

CREATE TABLE Dept (
    DepId INT PRIMARY KEY,
    DeptName VARCHAR(40) NOT NULL
);
CREATE TABLE project (
    projectID INT PRIMARY KEY,
    Startdate DATE NOT NULL,
    endDate DATE NOT NULL,
    status VARCHAR(10),
    projectLeader VARCHAR(20),
    depID INT REFERENCES dept
);
CREATE TABLE employee (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    ContactNo VARCHAR(10),
    age INT,
    sex VARCHAR(10),
    DepId INT REFERENCES Dept,
    projectID INT REFERENCES project
);
CREATE TABLE Attendance (
    attendID INT PRIMARY KEY,
    timeIn TIME,
    timeOut TIME,
    remarks VARCHAR(50),
    EmpId INT REFERENCES employee
);
CREATE TABLE Salary (
    EmpId INT REFERENCES employee,
    Basic INT NOT NULL,
    CTC INT NOT NULL,
    taxableIncome INT,
    grade VARCHAR(1)
);
CREATE TABLE Position (
    EmpID INT PRIMARY KEY,
    PositionID INT,
    PositionName VARCHAR(60)
);
CREATE TABLE Leaves (
    EmpID INT REFERENCES employee,
    leaveID INT PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    NoOfLeaves INT,
    Reason VARCHAR(90)
);
CREATE TABLE Facility (
    EmpID INT REFERENCES employee,
    Loan INT,
    Insurance INT,
    AdvancePay INT,
    Dependants INT
);

#trigger
delimiter //
CREATE TRIGGER Salary_grade BEFORE INSERT ON salary
       FOR EACH ROW
       BEGIN
           IF NEW.CTC >5 AND NEW.CTC<10 THEN SET NEW.grade = 'C';
           ELSEIF NEW.CTC >10 AND NEW.CTC<15 THEN SET NEW.grade = 'B';
           ELSEIF NEW.CTC >15 AND NEW.CTC<20 THEN SET NEW.grade = 'A';
           END IF;
       END;//
 delimiter ;

#insertion of records

insert into Dept values(1,"IT");
insert into Dept values(2,"UI");
insert into Dept values(3,"Developer");
insert into Dept values(4,"Networking"); 
insert into Dept values(5,"Web development");


insert into project values(1,'2020-09-04','2021-01-02','Done','Miliey Maheshwari',4);
insert into project values(2,'2020-07-22','2021-01-21','Done','Meera DCruz',2);
insert into project values(3,'2020-11-06','2021-07-16','Running','Miliey Maheshwari',1);
insert into project values(4,'2021-01-09','2021-07-23','Running','Abhimanyu Singh',3);
insert into project values(5,'2021-02-13','2021-08-17','Running','Aarya Rawat',5);

insert into employee values (1,"AnjaliShinde","9833449928",20,"female",1,1);
insert into employee values (2,"AbhivyaktiParihar","2658749631",21,"female",2,2);
insert into employee values (3,"Atish Mahajan","9831515318",22,"male",3,3);
insert into employee values (4,"Shubham Patil","8104197368",19,"male",4,4);
insert into employee values (5,"Nikita Shinde","8159631325",18,"female",5,5);

insert into Attendance values (1, '08:45','17:45', 'On Time',1);
insert into Attendance values (2, '08:38' ,'15:45', 'On Time',2);
insert into Attendance values (3, '08:59','17:00', 'On Time',3);
insert into Attendance values (4, '08:30','16:45', 'On Time',4);
insert into Attendance values (5, '09:45','18:45', 'Late',5);
SELECT 
    *
FROM
    Attendance;


insert into Salary(empID, basic, CTC, taxableincome) values (1, 80000,11,6);
insert into Salary(empID, basic, CTC, taxableincome) values (2, 50000,7,2);
insert into Salary(empID, basic, CTC, taxableincome) values (3, 130000,19,14);
insert into Salary(empID, basic, CTC, taxableincome) values (4, 70000,9,4);
insert into Salary(empID, basic, CTC, taxableincome) values (5, 95000,13,8);


insert into Position values(1, 1,'Marketing Manager');
insert into Position values(2, 2,'Marketing Executive');
insert into Position values(3, 3,'IT Manager');
insert into Position values(4, 4,'IT Executive');
insert into Position values(5, 5,'RnD Officer');


insert into Leaves values(1,1, '2021-01-04', '2021-01-06',1,'Sick');
insert into Leaves values(2,2, '2021-01-22', '2021-01-21',1,'Family function');
insert into Leaves values(3,3, '2021-02-06', '2021-02-06',1,'Unwell');
insert into Leaves values(4,4, '2021-02-08', '2021-02-08',1,'Headache');
insert into Leaves values(5,5, '2021-02-12', '2021-02-15',1,'Vacation');


insert into Facility values(1,1000000,25000,1,2);
insert into Facility values(2,500000,400000,1,3);
insert into Facility values(3,30000,500000,1,4);
insert into Facility values(4,600000,700000,2,2);
insert into Facility values(5,70000,800000,1,1);



CREATE VIEW empdept AS
    SELECT 
        empID, FullName, ContactNo, age, sex, DeptName
    FROM
        employee
            INNER JOIN
        Dept ON employee.DepId = Dept.DepId;
SELECT 
    *
FROM
    empdept;

CREATE VIEW empproj AS
    SELECT 
        empID,
        FullName,
        ContactNo,
        age,
        sex,
        ProjectLeader,
        endDate,
        startDate,
        status
    FROM
        employee
            INNER JOIN
        project ON employee.projectId = project.projectId;
SELECT 
    *
FROM
    empproj;

CREATE VIEW empattendance AS
    SELECT 
        employee.empID,
        FullName,
        ContactNo,
        attendID,
        timeIN,
        timeout,
        remarks
    FROM
        employee
            INNER JOIN
        attendance ON employee.empId = attendance.empId;
SELECT 
    *
FROM
    empattendance;

CREATE VIEW empsalary AS
    SELECT 
        employee.empID, FullName, ContactNo, basic, ctc, grade
    FROM
        employee
            INNER JOIN
        salary ON employee.empId = salary.empId;
SELECT 
    *
FROM
    empsalary;

CREATE VIEW emppos AS
    SELECT 
        employee.empID,
        FullName,
        ContactNo,
        positionID,
        positionName
    FROM
        employee
            INNER JOIN
        position ON employee.empId = position.empId;
SELECT 
    *
FROM
    emppos;

CREATE VIEW empleaves AS
    SELECT 
        employee.empID,
        FullName,
        ContactNo,
        leaveID,
        startdate,
        enddate,
        reason
    FROM
        employee
            INNER JOIN
        leaves ON employee.empId = leaves.empId;
SELECT 
    *
FROM
    empleaves;

CREATE VIEW empfacility AS
    SELECT 
        employee.empID,
        FullName,
        ContactNo,
        loan,
        insurance,
        advancepay,
        dependants
    FROM
        employee
            INNER JOIN
        facility ON employee.empId = facility.empId;
SELECT 
    *
FROM
    empfacility;

select count(empID) as total_employees from employee;

select sum(loan) as total_loan_from_company from facility;
select sum(insurance) as total_insurance_provided from facility;
select sum(CTC) as total_CTC from facility;

select avg(loan) as avg_loan_from_company from facility;
select avg(insurance) as avg_insurance_provided from facility;
select avg(CTC) as avg_CTC from facility;

select min(loan) as min_loan_from_company from facility;
select min(insurance) as min_insurance_provided from facility;
select min(CTC) as min_CTC from facility;

select max(loan) as max_loan_from_company from facility;
select max(insurance) as max_insurance_provided from facility;
select max(CTC) as max_CTC from facility;

 