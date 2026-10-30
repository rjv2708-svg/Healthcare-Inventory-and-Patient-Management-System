USE Healthcare_DB
 	/*
	Easy: Question 1
	How many rows of data are in the FactTable that include 
	a Gross Charge greater than $100?
	*/
	Select 
	  Count(*) as 'CountofRows'
	  from FactTable
	where FactTable.GrossCharge >100

	/*
	Easy: Question 2
	How many unique patients exist is the Healthcare_DB?
	*/
	select count(distinct dimPatientPK) as 'Unique Patients' from dimPatient

	/*
	Easy: Question 3
	How many CptCodes are in each CptGrouping?
	*/
	select * from dimCptCode 
	select CptGrouping,count(distinct(CptCode)) as 'Count of CptCode' from dimCptCode
	group by CptGrouping

	/*
	Intermediate: Question 4
	How many physicians have submitted a Medicare insurance claim?
	*/

	select * from dimPhysician
	select * from dimPayer

	select count(distinct dimPhysicianPK) as 'physician_count' 
	from FactTable
	inner join dimPayer on FactTable.dimPayerPK=dimPayer.dimPayerPK
	where PayerName='Medicare'


	select count(distinct dimPhysicianPK) from FactTable where dimPayerPK in 
	(select dimPayerPK from dimPayer where PayerName='Medicare')

	/*
	Intermediate: Question 5
	Calculate the Gross Collection Rate (GCR) for each
	LocationName - See Below 
	GCR = Payments divided GrossCharge
	Which LocationName has the highest GCR?
	*/
	
	select 
	LocationName,
	sum(Payment)/sum(GrossCharge) as GCR from FactTable 
	inner join dimLocation on FactTable.dimLocationPK=dimLocation.dimLocationPK
	group by LocationName
	order by GCR

	/*
	Easy: Question 6
	You've been asked to put together a report that details 
	Patient demographics. The report should group patients
	into three buckets- Under 18, between 18-65, & over 65
	Please include the following columns:
		-First and Last name in the same column
		-Email
		-Patient Age
		-City and State in the same column
	*/
select * from dimPatient
select FirstName+''+LastName as 'PatientName', Email,PatientAge,City+''+State as 'CityName', 
case 
	when PatientAge<18 then 'Under 18'
	when PatientAge between 18 and 65 then '18-65'
	else 'Over 65'
End as 'AgeBucket'
from dimpatient
	/*
	Easy: Question 7
	How many dollars have been written off (adjustments) due
	to credentialing (AdjustmentReason)? Which location has the 
	highest number of credentialing adjustments? How many 
	physicians at this location have been impacted by 
	credentialing adjustments? What does this mean?
	*/
select * from dimTransaction
select * from FactTable

select SUM(Adjustment) from FactTable
inner join dimTransaction on FactTable.dimTransactionPK=dimTransaction.dimTransactionPK 
inner join dimLocation on FactTable.dimLocationPK=dimLocation.dimLocationPK
where AdjustmentReason='Credentialing' 

(select Top 1 LocationName,SUM(Adjustment) as 'Total off' from FactTable			
inner join dimTransaction on FactTable.dimTransactionPK=dimTransaction.dimTransactionPK 
inner join dimLocation on FactTable.dimLocationPK=dimLocation.dimLocationPK
where AdjustmentReason='Credentialing' group by LocationName )

select SUM(Adjustment) from FactTable		/*non Co-related */
where dimTransactionPK in (select dimTransactionPK from dimTransaction where AdjustmentReason='Credentialing' in
(select COUNT(dimPhysicianPK) from dimPhysician where dimPhysician.dimPhysicianPK=dimLocation.dimLocationPK))

	/*
	Easy: Question 8
	Build a Table that includes the following elements:
		- LocationName
		- CountofPhysicians
		- CountofPatients
		- GrossCharge
		- AverageChargeperPatients 
	*/

	select * from dimLocation
	select * from dimPhysician
	select * from dimPatient
	select * from FactTable

	select count(distinct dimPatientPK) from dimPatient
	select count(distinct dimPhysicianPK) from dimPhysician

	select
		LocationName,
		   count(distinct dimPatientPK) as 'count_of_patients', 
		   count(distinct dimPhysicianPK) as 'count_of_physicians',
		   sum (GrossCharge) as 'Total_grosscharge',
		   sum (GrossCharge)/count(distinct dimPatientPK) as 'avg_chargepatients'
	from FactTable
	inner join 
	dimLocation on FactTable.dimLocationPK=dimLocation.dimLocationPK
	group by LocationName
	