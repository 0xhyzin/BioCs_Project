-- Table: College
CREATE TABLE College (
    CollegeId SERIAL PRIMARY KEY,
    CollegeName VARCHAR(100) NOT NULL
);

-- Table: Department
CREATE TABLE Department (
    DepartmentId SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    CollegeId INT REFERENCES College(CollegeId)
);

-- Table: Specialty
CREATE TABLE Specialty (
    SpecialtyId SERIAL PRIMARY KEY,
    SpecialtyName VARCHAR(100) NOT NULL,
    DepartmentId INT REFERENCES Department(DepartmentId)
);

-- Table: Semester
CREATE TABLE Semester (
    SemesterId SERIAL PRIMARY KEY,
    SemesterType VARCHAR(50)
);

-- Table: AcademicRegulation
CREATE TABLE AcademicRegulation (
    AcademicRegulationId SERIAL PRIMARY KEY,
    AcademicRegulationRegulationsYear VARCHAR(20),
    SpecialtyId INT REFERENCES Specialty(SpecialtyId)
);

-- Table: Course
CREATE TABLE Course (
    CourseId SERIAL PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    CourseCode VARCHAR(50) UNIQUE,
    CourseHour INT,
    CourseDescription TEXT,
    CourseImgURL TEXT,
    SpecialtyId INT REFERENCES Specialty(SpecialtyId),
    AcademicRegulationId INT REFERENCES AcademicRegulation(AcademicRegulationId)
);

-- Table: RoleType
CREATE TABLE RoleType (
    RoleTypeId SERIAL PRIMARY KEY,
    RoleTypeName VARCHAR(100)
);

-- Table: User
CREATE TABLE "User" (
    UserId SERIAL PRIMARY KEY,
    UserFirstName VARCHAR(100),
    UserSecondName VARCHAR(100),
    UserEmail VARCHAR(100) UNIQUE,
    UserHashPassword TEXT,
    UserAddress TEXT,
    RoleTypeId INT REFERENCES RoleType(RoleTypeId)
);

-- Table: Role
CREATE TABLE Role (
    RoleId SERIAL PRIMARY KEY,
    UserId INT REFERENCES "User"(UserId),
    RoleTypeId INT REFERENCES RoleType(RoleTypeId)
);

-- Table: Phone
CREATE TABLE Phone (
    PhoneId SERIAL PRIMARY KEY,
    UserId INT REFERENCES "User"(UserId),
    PhoneNumber VARCHAR(20)
);

-- Table: DoctorCourse
CREATE TABLE DoctorCourse (
    DoctorCourseId SERIAL PRIMARY KEY,
    DoctorCourseDateAssigned DATE NOT NULL,
    UserId INT REFERENCES "User"(UserId),
    CourseId INT REFERENCES Course(CourseId)
);

-- Table: StudentCourse
CREATE TABLE StudentCourse (
    StudentCourseId SERIAL PRIMARY KEY,
    StudentCourseDateEnrolled DATE NOT NULL,
    UserId INT REFERENCES "User"(UserId),
    CourseId INT REFERENCES Course(CourseId)
);

-- Table: StudentCourseState
CREATE TABLE StudentCourseState (
    StudentCourseStateId SERIAL PRIMARY KEY,
    StudentCourseStateType BOOLEAN,
	StudentCourseId INT REFERENCES StudentCourse(StudentCourseId)
);

-- Table: TokenType
CREATE TABLE TokenType (
    TokenTypeId SERIAL PRIMARY KEY,
    TokenTypeName VARCHAR(100)
);

-- Table: Token
CREATE TABLE Token (
    TokenId SERIAL PRIMARY KEY,
    TokenValue TEXT,
    TokenDateCreation DATE NOT NULL,
    TokenExpiredAt DATE,
    TokenState BOOLEAN,
    UserId INT REFERENCES "User"(UserId),
    TokenTypeId INT REFERENCES TokenType(TokenTypeId)
);

-- Table: Lectures
CREATE TABLE Lectures (
    LecturesId SERIAL PRIMARY KEY,
    LecturesTitle VARCHAR(100),
    LecturesDescription VARCHAR(100),
    LecturesScanCode VARCHAR(100),
    LecturesDate DATE,
    CourseId INT REFERENCES Course(CourseId)
);

-- Table: Absence
CREATE TABLE Absence (
    AbsenceId SERIAL PRIMARY KEY,
    AbsenceState BOOLEAN,
    UserId INT REFERENCES "User"(UserId),
    LecturesId INT REFERENCES Lectures(LecturesId)
);

-- Table: Video
CREATE TABLE Video (
    VideoId SERIAL PRIMARY KEY,
    VideoURL TEXT,
    LecturesId INT REFERENCES Lectures(LecturesId)
);

-- Table: Record
CREATE TABLE Record (
    RecordId SERIAL PRIMARY KEY,
    RecordFileURL TEXT,
    LecturesId INT REFERENCES Lectures(LecturesId)
);

-- Table: BlackboardPictures
CREATE TABLE BlackboardPictures (
    BlackboardPicturesId SERIAL PRIMARY KEY,
    BlackboardPicturesURL TEXT,
    LecturesId INT REFERENCES Lectures(LecturesId)
);

