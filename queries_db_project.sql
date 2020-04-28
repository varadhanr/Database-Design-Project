-- DB Project - Transport Management System - SQL Queries
-- Submitted By: Varadhan, Hansika and Humayoon

-- Table creation
CREATE TABLE Customer(
  SSN      CHAR(9)        PRIMARY KEY,
  Name     VARCHAR(100)   NOT NULL,
  Phone    VARCHAR(20)    NOT NULL    UNIQUE,
  County   VARCHAR(50)    NOT NULL,
  Street   VARCHAR(50)    NOT NULL
);


CREATE TABLE Company(
  Company_Name    VARCHAR(100)    PRIMARY KEY,
  County          VARCHAR(50)     NOT NULL,
  Street          VARCHAR(50)     NOT NULL
);


CREATE TABLE PostalCode(
  County      VARCHAR(50),
  Street      VARCHAR(50),
  Zip         INTEGER         NOT NULL,
  City_Id     INTEGER         NOT NULL,
  CONSTRAINT County_Street_PK PRIMARY KEY ( County, Street )
);


CREATE TABLE Transport_Office(
  Office_Id           INTEGER         PRIMARY KEY,
  Transport_Officer   VARCHAR(100)    NOT NULL,
  Name                VARCHAR(50)     NOT NULL,
  Phone               VARCHAR(20)     NOT NULL,
  County              VARCHAR(50)     NOT NULL,
  Street              VARCHAR(50)     NOT NULL
);


CREATE TABLE City(
  City_Id   INTEGER     PRIMARY KEY,
  Name      VARCHAR(50) NOT NULL
);


CREATE TABLE City_Structures(
  City_Id   INTEGER     PRIMARY KEY,
  Name      VARCHAR(50) NOT NULL
);


CREATE TABLE Buildings_Structures(
  Name     VARCHAR(50)    PRIMARY KEY,
  Type     VARCHAR(50)    NOT NULL
);


CREATE TABLE Tolls(
  Name   VARCHAR(50)  PRIMARY KEY
);


CREATE TABLE City_Route(
  Route_Id    INTEGER   NOT NULL,
  City_Id     INTEGER   NOT NULL,
  CONSTRAINT Route_City_PK PRIMARY KEY ( Route_Id, City_Id )
);


CREATE TABLE Vehicle_Schedule(
  Schedule_Id           INTEGER       PRIMARY KEY,
  Frequency             VARCHAR(20)   NOT NULL,
  End_Time              TIMESTAMP(0)       NOT NULL,
  Start_Time            TIMESTAMP(0)       NOT NULL,
  Vehicle_Controller    VARCHAR(50)   NOT NULL
);


CREATE TABLE Registration_Details(
  Registration_Number   INTEGER       PRIMARY KEY,
  State                 VARCHAR(20)   NOT NULL,
  Company_Name          VARCHAR(100)  NOT NULL,
  Office_Id             INTEGER       NOT NULL,
  Route_Id              INTEGER       NOT NULL,
  Schedule_Id           INTEGER       NOT NULL
);


CREATE TABLE Ticket(
  Ticket_Id             INTEGER       PRIMARY KEY,
  Quantity              INTEGER       NOT NULL,
  Source                VARCHAR(30)   NOT NULL,
  Destination           VARCHAR(30)   NOT NULL,
  SSN                   CHAR(9)       NOT NULL,
  Vehicle_Id            INTEGER       NOT NULL,
  Registration_Number   INTEGER       NOT NULL
);


CREATE TABLE Transportation_Vehicle(
  Vehicle_Id            INTEGER       NOT NULL,
  Registration_Number   INTEGER       NOT NULL,
  Company_Name          VARCHAR(100)  NOT NULL,
  Medium_Type           VARCHAR(20)   NOT NULL,
  CONSTRAINT Vehicle_Reg_PK PRIMARY KEY ( Vehicle_Id, Registration_Number )
);


CREATE TABLE Route(
  Route_Id        INTEGER       PRIMARY KEY,
  Source          VARCHAR(30)   NOT NULL,
  Destination     VARCHAR(30)   NOT NULL
);


CREATE TABLE Route_Buildings(
  Route_Id      INTEGER       NOT NULL,
  Name          VARCHAR(50)   NOT NULL,
  CONSTRAINT Route_Name_PK PRIMARY KEY ( Route_Id, Name )
);


CREATE TABLE Bridges(
  Name    VARCHAR(50)   PRIMARY KEY
);


CREATE TABLE Highways(
  Name    VARCHAR(50)   PRIMARY KEY
);


CREATE TABLE Travel_Amount(
  Source        VARCHAR(30)   NOT NULL,
  Destination   VARCHAR(30)   NOT NULL,
  Price         INTEGER       NOT NULL,
  CONSTRAINT Source_Destination_PK PRIMARY KEY ( Source, Destination )
);


CREATE TABLE Water(
  Vehicle_Id            INTEGER   NOT NULL,
  Registration_Number   INTEGER   NOT NULL,
  CONSTRAINT Water_Vehicle_Reg_PK PRIMARY KEY ( Vehicle_Id, Registration_Number )
);


CREATE TABLE Road(
  Vehicle_Id            INTEGER   NOT NULL,
  Registration_Number   INTEGER   NOT NULL,
  CONSTRAINT Road_Vehicle_Reg_PK PRIMARY KEY ( Vehicle_Id, Registration_Number )
);


CREATE TABLE Air(
  Vehicle_Id            INTEGER   NOT NULL,
  Registration_Number   INTEGER   NOT NULL,
  CONSTRAINT Air_Vehicle_Reg_PK PRIMARY KEY ( Vehicle_Id, Registration_Number )
);


CREATE TABLE Route_Stops(
  Route_Id      INTEGER       NOT NULL,
  Stop_Name     VARCHAR(25)   NOT NULL,
  CONSTRAINT Route_Stop_PK PRIMARY KEY ( Route_Id, Stop_Name )

);


CREATE TABLE Transport_Stops(
  Stop_Name      VARCHAR(25)    PRIMARY KEY
);



-- Constraints
ALTER TABLE Customer
  ADD CONSTRAINT Customer_County_Street_FK FOREIGN KEY ( County, Street )
    REFERENCES PostalCode ( County, Street )
      ON DELETE CASCADE;


ALTER TABLE Company
  ADD CONSTRAINT Company_County_Street_FK FOREIGN KEY ( County, Street )
    REFERENCES PostalCode ( County, Street )
      ON DELETE CASCADE;


ALTER TABLE Transport_Office
  ADD CONSTRAINT Transport_Office_County_FK FOREIGN KEY ( County, Street )
    REFERENCES PostalCode ( County, Street )
      ON DELETE CASCADE;


ALTER TABLE PostalCode
  ADD CONSTRAINT PostalCode_City_Id_FK FOREIGN KEY ( City_Id )
    REFERENCES City ( City_Id )
      ON DELETE CASCADE;


ALTER TABLE City_Structures
  ADD CONSTRAINT City_Structures_City_Id_FK FOREIGN KEY ( City_Id )
    REFERENCES City ( City_Id )
      ON DELETE CASCADE;


ALTER TABLE City_Structures
  ADD CONSTRAINT City_Structures_Name_FK FOREIGN KEY ( Name )
    REFERENCES Buildings_Structures ( Name )
      ON DELETE CASCADE;


ALTER TABLE Registration_Details
  ADD CONSTRAINT Reg_Det_Comp_Name_FK FOREIGN KEY ( Company_Name )
    REFERENCES Company ( Company_Name )
      ON DELETE CASCADE;

ALTER TABLE Registration_Details
  ADD CONSTRAINT Reg_Det_Ofc_Id_FK FOREIGN KEY ( Office_Id )
    REFERENCES Transport_Office ( Office_Id )
      ON DELETE CASCADE;


ALTER TABLE Registration_Details
  ADD CONSTRAINT Reg_Det_Route_Id_FK FOREIGN KEY ( Route_Id )
    REFERENCES Route ( Route_Id )
      ON DELETE CASCADE;


ALTER TABLE Registration_Details
  ADD CONSTRAINT Reg_Det_Schedule_Id_FK FOREIGN KEY ( Schedule_Id )
    REFERENCES Vehicle_Schedule ( Schedule_Id )
      ON DELETE CASCADE;


ALTER TABLE City_Route
  ADD CONSTRAINT City_Route_Route_Id_FK FOREIGN KEY ( Route_Id )
    REFERENCES Route ( Route_Id )
      ON DELETE CASCADE;


ALTER TABLE City_Route
  ADD CONSTRAINT City_Route_City_Id_FK FOREIGN KEY ( City_Id )
    REFERENCES City ( City_Id )
      ON DELETE CASCADE;


ALTER TABLE Ticket
  ADD CONSTRAINT Ticket_Source_Dest_FK FOREIGN KEY ( Source, Destination )
    REFERENCES Travel_Amount ( Source, Destination )
      ON DELETE CASCADE;


ALTER TABLE Ticket
  ADD CONSTRAINT Ticket_SSN_FK FOREIGN KEY ( SSN )
    REFERENCES Customer ( SSN )
      ON DELETE CASCADE;


ALTER TABLE Ticket
  ADD CONSTRAINT Ticket_Vehicle_Reg_Id_FK FOREIGN KEY ( Vehicle_Id, Registration_Number )
    REFERENCES Transportation_Vehicle ( Vehicle_Id, Registration_Number )
      ON DELETE CASCADE;


ALTER TABLE Transportation_Vehicle
  ADD CONSTRAINT Tran_Vehicle_Reg_No_FK FOREIGN KEY ( Registration_Number )
    REFERENCES Registration_Details ( Registration_Number )
      ON DELETE CASCADE;


ALTER TABLE Water
  ADD CONSTRAINT Water_Vehicle_Reg_Id_FK FOREIGN KEY ( Vehicle_Id, Registration_Number )
    REFERENCES Transportation_Vehicle ( Vehicle_Id, Registration_Number )
      ON DELETE CASCADE;


ALTER TABLE Road
  ADD CONSTRAINT Road_Vehicle_Reg_Id_FK FOREIGN KEY ( Vehicle_Id, Registration_Number )
    REFERENCES Transportation_Vehicle ( Vehicle_Id, Registration_Number )
      ON DELETE CASCADE;


ALTER TABLE Air
  ADD CONSTRAINT Air_Vehicle_Reg_Id_FK FOREIGN KEY ( Vehicle_Id, Registration_Number )
    REFERENCES Transportation_Vehicle ( Vehicle_Id, Registration_Number )
      ON DELETE CASCADE;


ALTER TABLE Route_Buildings
  ADD CONSTRAINT Route_Buildings_Route_Id_FK FOREIGN KEY ( Route_Id )
    REFERENCES Route ( Route_Id )
      ON DELETE CASCADE;


ALTER TABLE Route_Buildings
  ADD CONSTRAINT Route_Buildings_Name_FK FOREIGN KEY ( Name )
    REFERENCES Buildings_Structures ( Name )
      ON DELETE CASCADE;


ALTER TABLE Bridges
  ADD CONSTRAINT Bridges_Name_FK FOREIGN KEY ( Name )
    REFERENCES Buildings_Structures ( Name )
      ON DELETE CASCADE;


ALTER TABLE Highways
  ADD CONSTRAINT Highways_Name_FK FOREIGN KEY ( Name )
    REFERENCES Buildings_Structures ( Name )
      ON DELETE CASCADE;


ALTER TABLE Tolls
  ADD CONSTRAINT Tolls_Name_FK FOREIGN KEY ( Name )
    REFERENCES Buildings_Structures ( Name )
      ON DELETE CASCADE;


ALTER TABLE Route_Stops
  ADD CONSTRAINT Route_Stops_Route_Id_FK FOREIGN KEY ( Route_Id )
    REFERENCES Route ( Route_Id )
      ON DELETE CASCADE;


ALTER TABLE Route_Stops
  ADD CONSTRAINT Route_Stops_Stop_Name_FK FOREIGN KEY ( Stop_Name )
    REFERENCES Transport_Stops ( Stop_Name )
      ON DELETE CASCADE;



-- Stored Procedures
/*This procedure would take company name in its argument and find all the toll names that the company has to
pay for. All the vehicles are registered to some company and vehicles in their daily schedule would pass
through several tolls for which they would have to pay, hence, the company would take care of all the payments
for their vehicles */
CREATE OR REPLACE PROCEDURE Company_Tolls_Pay (
  Comp_Name IN VARCHAR2
) AS
    names       Tolls.Name%type;
BEGIN
  SELECT T.Name INTO names
  FROM Registration_Details D, Route_Buildings B, Buildings_Structures S, Tolls T
  WHERE D.Company_Name = Comp_Name AND D.Route_Id = B.Route_Id
  AND B.Name = S.Name AND S.Name = T.Name;
END Company_Tolls_Pay;

/*This procedure would take vehicle ID in its argument and find all the stop names the vehicle would stop at.
This is important for customers who want to stop at certain location when they are traveling on that
particular vehicle*/

CREATE OR REPLACE PROCEDURE Vehicle_Stops (
  VID IN INTEGER
) AS
    stops       Route_Stops.Stop_Name%type;
BEGIN
  SELECT S.Stop_Name INTO stops
  FROM Transportation_Vehicle V, Registration_Details D, Route R, Route_Stops S
  WHERE V.Vehicle_Id = VID AND V.Registration_Number = D.Registration_Number
  AND D.Route_Id = R.Route_Id AND R.Route_Id = S.Route_Id;
END Vehicle_Stops;



-- Triggers
/*This trigger will pop up whenever there is an insertion of new route ID or an update of a route ID
in Route table*/
CREATE or REPLACE TRIGGER Route_Changes
BEFORE INSERT or UPDATE OF Route_Id ON Route
FOR EACH ROW

DECLARE

BEGIN
    dbms_output.put_line('Route Id has been added/updated');
END;

-- Creating table Customer_log to save all the changes made by customers
DROP TABLE Customer_log;
CREATE TABLE Customer_log (
  Name     VARCHAR(50),
  Phone    INTEGER,
  County   VARCHAR(20),
  Street   VARCHAR(20),
  Log_Date DATE
);

/*This trigger will keep track of all the changes made in the customer table. Whenever, a customer changes
their information, this trigger will pop up*/
CREATE OR REPLACE TRIGGER Customer_changes
  BEFORE UPDATE OF Name, Phone, County, Street ON Customer
  FOR EACH ROW
BEGIN
  INSERT INTO Customer_log (Name, Phone, County, Street, Log_Date)
  VALUES (:new.Name, :new.Phone, :new.County, :new.Street, SYSDATE);
END;
