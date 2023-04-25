create database QuanlySV;
use QuanlySV;

create table Students(
StudentID int(4) primary key auto_increment,
StudentName varchar(50),
Age int(4),
Email varchar(100)
);

create table Subjects(
SubjectID int(4) primary key auto_increment,
SubjectName varchar(50)
);

create table Marks(
Mark int,
StudentID int,
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
SubjectID int,
FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

create table Classes(
ClassID int(4) primary key auto_increment,
ClassName varchar(50)
);

create table ClassStudent(
StudentID int,
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
ClassID int,
FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

INSERT INTO Students(StudentName, Age, Email)
VALUES ('Nguyen Quang An',18,'an@yahoo.com'),
('Nguyen Cong Vinh',20,'vinh@gmal.com'),
('Nguyen Van Quyen',19,'quyen`'),
('Pham Thanh Binh',25,'binh@com'),
('Nguyen Van Tai Em',30,'taiem@sport.com');

INSERT INTO Classes(ClassName)
VALUES ('C0706L'),('C0708G');

INSERT INTO ClassStudent(StudentID,ClassID)
VALUES (1,1),(2,1),(3,2),(4,2),(5,2);

INSERT INTO Subjects(SubjectName)
VALUES ('SQL'),('Java'),('C'),('Visual Basic');

INSERT INTO Marks(Mark,SubjectID,StudentID)
value(8,1,1),(4,2,1),(9,1,1),(7,1,3),(3,1,4),(5,2,5),(8,3,3),(1,3,5),(3,2,4);

-- Viet truy van:
-- 1. Hien thi danh sach tat ca cac hoc vien:
SELECT * FROM Students;
-- 2. Hien thi danh sach tat ca cac mon hoc
SELECT * FROM Subjects;
-- 3. Tinh diem trung binh tat ca mon hoc
SELECT AVG(Mark) AS DiemTB FROM Marks;
-- 4. Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
SELECT Subjects.SubjectName, MAX(Marks.Mark) AS DiemCaoNhat
FROM Marks
JOIN Subjects ON Marks.SubjectID = Subjects.SubjectID
WHERE Marks.Mark = (SELECT MAX(Mark) FROM Marks)
GROUP BY Subjects.SubjectName;
-- 5. Danh so thu tu cua diem theo chieu giam
SELECT Mark, DENSE_RANK() OVER (ORDER BY Mark DESC) AS thutu FROM Marks ORDER BY Mark DESC;

-- 6. Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
ALTER TABLE Subjects
MODIFY COLUMN SubjectName varchar(255);

-- 7. Cap nhat them dong chu « Day la mon hoc « vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
UPDATE Subjects SET SubjectName = CONCAT('Day la mon hoc ', SubjectName);
SELECT * FROM Subjects;

-- 8. Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
ALTER TABLE Student ADD CONSTRAINT Check_Student_Age CHECK (Age > 15 AND Age < 50);

-- 9. Loai bo tat ca quan he giua cac bang
ALTER TABLE classstudent
DROP FOREIGN KEY classstudent_ibfk_1,
DROP FOREIGN KEY classstudent_ibfk_2;

ALTER TABLE marks
DROP FOREIGN KEY marks_ibfk_1,
DROP FOREIGN KEY marks_ibfk_2;

-- 10.Xoa hoc vien co StudentID la 1
DELETE FROM Students WHERE StudentID = 1;

-- 11.Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
ALTER TABLE Students ADD Status BIT DEFAULT 1;

-- 12.Cap nhap gia tri Status trong bang Student thanh 0
UPDATE Students SET Status = 0;






