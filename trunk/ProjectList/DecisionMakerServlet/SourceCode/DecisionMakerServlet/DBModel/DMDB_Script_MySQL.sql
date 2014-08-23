DROP TABLE IF EXISTS WATCHER;
DROP TABLE IF EXISTS ROLE;
DROP TABLE IF EXISTS REQUESTTYPE;
DROP TABLE IF EXISTS REQUEST;
DROP TABLE IF EXISTS DEPARTMENT;
DROP TABLE IF EXISTS USER;
DROP TABLE IF EXISTS PARAMETER;
DROP TABLE IF EXISTS LABEL;
DROP TABLE IF EXISTS USER_ROLE;
DROP TABLE IF EXISTS USER;
DROP TABLE IF EXISTS TEMPLATE;

CREATE TABLE USER (
       ID INT NOT NULL AUTO_INCREMENT
     , CD VARCHAR(10)  NOT NULL
     , USERNAME VARCHAR(50) NOT NULL UNIQUE
     , EMAIL VARCHAR(50)
     , FIRSTNAME VARCHAR(20)
     , LASTNAME VARCHAR(50)
     , ENABLED BOOLEAN
     , DEPARTMENT_ID INT
     , DEPARTMENT_CD VARCHAR(50)
     , DEPARTMENT_NAME VARCHAR(100)
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
);

CREATE TABLE USER_ROLE (
       ID INT NOT NULL AUTO_INCREMENT
     , USERNAME VARCHAR(50)  NOT NULL
     , ROLE VARCHAR(50)
     , ENABLED BOOLEAN
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
);


CREATE TABLE ROLE (
       ID INT NOT NULL  AUTO_INCREMENT
     , USER_ID INT
     , ROLE VARCHAR(32)
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
     , INDEX (USER_ID)
     , CONSTRAINT FK_USER_ROLE FOREIGN KEY (USER_ID)
                  REFERENCES USER (ID)
);

CREATE TABLE DEPARTMENT (
       ID INT NOT NULL AUTO_INCREMENT
     , PARENTID INT NOT NULL
     , CD VARCHAR(10) NOT NULL UNIQUE
     , PARENTCD VARCHAR(10)
     , NAME VARCHAR(50) NOT NULL
     , DESCRIPTION VARCHAR(200)
     , ENABLED BOOLEAN
     , MANAGER_ID INT
     , MANAGER_CD VARCHAR(50)
     , MANAGER_NAME VARCHAR(100)
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
);

CREATE TABLE REQUESTTYPE (
       ID INT NOT NULL AUTO_INCREMENT
     , CD VARCHAR(10) NOT NULL
     , NAME VARCHAR(50) NOT NULL
     , DESCRIPTION VARCHAR(200)
     , ENABLED BOOLEAN
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
);

CREATE TABLE PARAMETER (
       ID INT NOT NULL AUTO_INCREMENT
     , CD VARCHAR(10)
     , NAME VARCHAR(50)
     , VALUE VARCHAR(100)
     , DESCRIPTION VARCHAR(200)
     , ENABLED BOOLEAN
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
);

CREATE TABLE TEMPLATE (
       ID INT NOT NULL AUTO_INCREMENT
     , CD VARCHAR(10) NOT NULL
     , NAME VARCHAR(50) NOT NULL
     , DESCRIPTION VARCHAR(200)
     , CONTENT TEXT
     , ENABLED BOOLEAN
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
);

CREATE TABLE LABEL (
       ID INT NOT NULL AUTO_INCREMENT
     , CD VARCHAR(10) NOT NULL
     , TYPE VARCHAR(50) NOT NULL
     , NAME VARCHAR(50) NOT NULL
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
);

CREATE TABLE REQUEST (
       ID INT NOT NULL AUTO_INCREMENT
     , REQUESTTYPE_ID INT
     , REQUESTTYPE_CD VARCHAR(10)
     , REQUESTTYPE_NAME VARCHAR(50)
     , TITLE VARCHAR(200) NOT NULL
     , CONTENT TEXT
     , STARTDATE DATETIME
     , ENDDATE DATETIME
     , ASSIGNED_ID INT
     , ASSIGNED_CD CHAR(50)
     , ASSIGNED_NAME CHAR(100)
     , WATCHERS_ID INT
     , MANAGER_ID INT
     , MANAGER_CD VARCHAR(50)
     , MANAGER_NAME VARCHAR(100)
     , LABEL1 VARCHAR(20)
     , LABEL2 VARCHAR(20)
     , LABEL3 VARCHAR(20)
     , DURATION INT
     , DURATIONUNIT INT          -- 0: hour; 1: day; 2: week; 3: moth; 4: year
     , DEPARTMENTS_ID INT
     , STATUS VARCHAR(30)        -- Created | Rejected | Approved | Updated
	 , COMMENT TEXT
     , CREATOR_READ INT
     , MANAGER_READ INT
     , ASSIGNER_READ INT
     , PLANEFFORT INT
     , PLANUNIT VARCHAR(50)
     , ATTACHMENT1 BLOB
     , ATTACHMENT2 BLOB
     , ATTACHMENT3 BLOB
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
     , INDEX (ASSIGNED_ID)
     , CONSTRAINT FK_REQUEST_USER FOREIGN KEY (ASSIGNED_ID)
                  REFERENCES USER (ID)
     , INDEX (MANAGER_ID)
     , CONSTRAINT FK_REQUEST_USER_MANAGER FOREIGN KEY (MANAGER_ID)
                  REFERENCES USER (ID)
     , INDEX (CREATEDBY_ID)
     , CONSTRAINT FK_REQUEST_USER_CREATEDBY FOREIGN KEY (CREATEDBY_ID)
                  REFERENCES USER (ID)
     , CONSTRAINT FK_REQUEST_DEPARTMENT FOREIGN KEY (DEPARTMENTS_ID)
                  REFERENCES DEPARTMENT (ID)
);


CREATE TABLE WATCHER (
       ID INT NOT NULL  AUTO_INCREMENT
     , REQ_ID INT NOT NULL
     , USER_ID INT
     , USER_CD VARCHAR(50)
     , USER_NAME VARCHAR(100)
     , CREATED DATETIME NOT NULL
     , CREATEDBY_ID INT
     , CREATEDBY_CD VARCHAR(50)
     , CREATEDBY_NAME VARCHAR(100)
     , LASTMODIFIED DATETIME
     , LASTMODIFIEDBY_ID INT
     , LASTMODIFIEDBY_NAME VARCHAR(100)
     , LASTMODIFIEDBY_CD VARCHAR(50)
     , PRIMARY KEY (ID)
     , INDEX (REQ_ID)
     , CONSTRAINT FK_WATCHER_REQUEST FOREIGN KEY (REQ_ID)
                  REFERENCES REQUEST (ID)
     , INDEX (USER_ID)
     , CONSTRAINT FK_WATCHER_USER FOREIGN KEY (USER_ID)
                  REFERENCES USER (ID)
);

