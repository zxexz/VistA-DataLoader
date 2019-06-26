ISIIMPT1 ;ISI GROUP/MLS - IMPORT Unit tests;2019-06-26  11:27 AM
 ;;3.0;ISI_DATA_LOADER;;Jun 26, 2019
 ;
 ; VistA Data Loader 2.0
 ;
 ; Copyright (C) 2012 Johns Hopkins University
 ;
 ; VistA Data Loader is provided by the Johns Hopkins University School of
 ; Nursing, and funded by the Department of Health and Human Services, Office
 ; of the National Coordinator for Health Information Technology under Award
 ; Number #1U24OC000013-01.
 ;
 ;Licensed under the Apache License, Version 2.0 (the "License");
 ;you may not use this file except in compliance with the License.
 ;You may obtain a copy of the License at
 ;
 ;    http://www.apache.org/licenses/LICENSE-2.0
 ;
 ;Unless required by applicable law or agreed to in writing, software
 ;distributed under the License is distributed on an "AS IS" BASIS,
 ;WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ;See the License for the specific language governing permissions and
 ;limitations under the License.
 ;
 Q
 ;
T1      ;
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC("TEMPLATE")="DEFAULT"
 S MISC("IMP_TYPE")="B"
 S MISC("IMP_BATCH_NUM")="10"
 ;S MISC("TYPE")=""
 ;S MISC("NAME")=""
 S MISC("NAME_MASK")="*,TEST*"
 ;S MISC("SEX")=""
 ;S MISC("DOB")=""
 ;S MISC("LOW_DOB")=""
 ;S MISC("UP_DOB")=""
 ;S MISC("SSN")=""
 S MISC("SSN_MASK")="66666"
 ;S MISC("STREET_ADD1")=""
 ;S MISC("STREET_ADD2")=""
 ;S MISC("CITY")=""
 ;S MISC("STATE")=""
 ;S MISC("ZIP_4")=""
 ;S MISC("ZIP_4_MASK")=""
 ;S MISC("MARITAL_STATUS")=""
 ;S MISC("PH_NUM")=""
 ;S MISC("PH_NUM_MASK")=""
 S MISC("VETERAN")="N"
 D PNTIMPRT^ISIIMPR1(.ISIRESUL,.MISC)
 Q
T2      ;
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC("TEMPLATE")="DEFAULT"
 S MISC("IMP_TYPE")="B"
 S MISC("IMP_BATCH_NUM")="10"
 ;S MISC("TYPE")=""
 ;S MISC("NAME")=""
 S MISC("NAME_MASK")="LAST*,FIRST*"
 ;S MISC("SEX")=""
 ;S MISC("DOB")=""
 ;S MISC("LOW_DOB")=""
 ;S MISC("UP_DOB")=""
 ;S MISC("SSN")=""
 S MISC("SSN_MASK")="66600"
 ;S MISC("STREET_ADD1")=""
 ;S MISC("STREET_ADD2")=""
 ;S MISC("CITY")=""
 ;S MISC("STATE")=""
 ;S MISC("ZIP_4")=""
 S MISC("ZIP_4_MASK")="55555"
 ;S MISC("MARITAL_STATUS")=""
 ;S MISC("PH_NUM")=""
 S MISC("PH_NUM_MASK")="555"
 S MISC("VETERAN")="N"
 D PNTIMPRT^ISIIMPR1(.ISIRESUL,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
T3      ;
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 ;S MISC("TEMPLATE")="DEFAULT"
 S MISC("IMP_TYPE")="I"
 ;S MISC("IMP_BATCH_NUM")="10"
 ;S MISC("TYPE")=""
 ;S MISC("NAME")=""
 S MISC("NAME_MASK")="LAST*,FIRST*"
 ;S MISC("SEX")=""
 ;S MISC("DOB")=""
 ;S MISC("LOW_DOB")=""
 ;S MISC("UP_DOB")=""
 ;S MISC("SSN")=""
 ;S MISC("SSN_MASK")="66600"
 ;S MISC("STREET_ADD1")=""
 ;S MISC("STREET_ADD2")=""
 ;S MISC("CITY")=""
 ;S MISC("STATE")=""
 ;S MISC("ZIP_4")=""
 ;S MISC("ZIP_4_MASK")="55555"
 ;S MISC("MARITAL_STATUS")=""
 ;S MISC("PH_NUM")=""
 ;S MISC("PH_NUM_MASK")="555"
 ;S MISC("VETERAN")="N"
 D PNTIMPRT^ISIIMPR1(.ISIRESUL,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
T4      ;
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="TEMPLATE^DEFAULT"
 S MISC(2)="IMP_TYPE^I"
 ;S MISC(3)="IMP_BATCH_NUM^5"
 ;S MISC(4)="DFN_NAME^Y"
 ;S MISC(5)="TYPE^"
 S MISC(6)="NAME^ZZZANOTHER,PATIENT"
 ;S MISC(7)="NAME_MASK^"
 ;S MISC(8)="SEX^"
 ;S MISC(9)="DOB^"
 S MISC(10)="LOW_DOB^1/1/1960"
 S MISC(11)="UP_DOB^1/1/1970"
 ;S MISC(12)"SSN^"
 ;S MISC(13)="SSN_MASK^66611"
 ;S MISC(14)="STREET_ADD1^"
 ;S MISC(15)="STREET_ADD2^"
 ;S MISC(16)="CITY^"
 ;S MISC(17)="STATE^"
 ;S MISC(18)="ZIP_4^"
 ;S MISC(19)="ZIP_4_MASK^55555"
 ;S MISC(20)="MARITAL_STATUS^"
 ;S MISC(21)="PH_NUM^"
 ;S MISC(22)="PH_NUM_MASK^555"
 ;S MISC(23)="VETERAN^N"
 S MISC(24)="RACE^WHITE"
 S MISC(25)="ETHNICITY^U"
 S MISC(26)="EMPLOY_STAT^EMPLOYED PART TIME"
 S MISC(27)="INSUR_TYPE^BC&BS"
 S MISC(28)="OCCUPATION^COMPUTER PROGRAMMER"
 D PNTIMPRT^ISIIMPR1(.ISIRESUL,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
 ;
T5 ;appointment create
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="ADATE^DEC 3, 2014@16:00"
 S MISC(2)="CDATE^DEC 3, 2014@16:40"
 S MISC(2)="CLIN^TEST CLINIC A"
 S MISC(3)="PATIENT^666000734"
 D APPMAKE^ISIIMPR1(.ISIRESUL,.MISC)
 ;
 W !,$G(ISIRC)
 Q
 ;
T6 ;Problem create
 N MISC K MISC
 ;OCT 30, 1996@07:33        TWENTYEIGHT,PATIENT     PRIMARY CARE
 S ISIPARAM("DEBUG")=1
 S MISC(0)="PROBLEM^DIABETES"
 S MISC(1)="PROVIDER^PROGRAMMER,ONE"
 S MISC(2)="PAT_SSN^666000028"
 S MISC(3)="STATUS^A"
 S MISC(4)="ENTERED^OCT 30, 1996@07:33"
 S MISC(5)="ONSET^OCT 30, 1996"
 S MISC(6)="TYPE^A"
 S MISC(7)="VPOV^Y"
 D PROBMAKE^ISIIMPR1(.ISIMISC,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
 ;
T7 ;
 S ISIMISC("PROBLEM")="DIABETES"
 D
 . S VALUE=ISIMISC("PROBLEM")
 . S (OUT,EXPIEN)="" F  S EXPIEN=$O(^LEX(757.01,"B",VALUE,EXPIEN)) Q:'EXPIEN  D  Q:OUT=1
 . . S EXPNM=$G(^LEX(757.01,EXPIEN,0)) Q:EXPNM=""
 . . S MAJCON=$P($G(^LEX(757.01,EXPIEN,1)),"^") Q:MAJCON=""
 . . S CODE="" F  S CODE=$O(^LEX(757.02,"AMC",MAJCON,CODE)) Q:'CODE  D  Q:OUT=1
 . . . S ICD=$P($G(^LEX(757.02,CODE,0)),"^",2) Q:ICD=""
 . . . S Y=$P($G(^LEX(757.03,$P($G(^LEX(757.02,CODE,0)),"^",3),0)),"^")
 . . . I Y="ICD9" S OUT=1 Q
 . . . Q
 . . Q
 . I EXPNM="" S EXIT=1 Q
 . I EXPIEN="" S EXIT=1 Q
 . I MAJCON="" S EXIT=1 Q
 . I ICD="" S EXIT=1 Q
 . S ICDIEN=$O(^ICD9("AB",ICD_" ","")) I ICDIEN="" S EXIT=1 Q
 . S ISIMISC("EXPIEN")=EXPIEN,ISIMISC("MAJCON")=MAJCON,ISIMISC("ICD")=ICD
 . S ISIMISC("ICDIEN")=ICDIEN,ISIMISC("EXPNM")=EXPNM
 . Q
 I EXIT Q "-1^Invalid data for PROBLEM"
 Q
T8 ;Vitals unit test
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="DT_TAKEN^7/1/12@12:00 PM"
 S MISC(2)="PAT_SSN^666000768"
 S MISC(3)="VITAL_TYPE^BP"
 S MISC(4)="RATE^172/63"
 S MISC(5)="LOCATION^PRIMARY CARE"
 S MISC(6)="ENTERED_BY^DOCTOR,ONE"
 D VITMAKE^ISIIMPR1(.ISIRESUL,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
 ;
T9 ;Vitals unit test 2
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="DT_TAKEN^6/1/2010@12:00 PM"
 S MISC(2)="PAT_SSN^666000768"
 S MISC(3)="VITAL_TYPE^PULSE"
 S MISC(4)="RATE^60"
 S MISC(5)="LOCATION^PRIMARY CARE"
 S MISC(6)="ENTERED_BY^ZZPROGRAMMER,FIVE"
 D VITMAKE^ISIIMPR1(.ISIRESUL,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
 ;
T10 ;Allergies unit test 1
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="ALLERGEN^POLLEN"
 S MISC(2)="SYMPTOM^ITCHING,WATERING EYES"
 S MISC(3)="PAT_SSN^666000892"
 S MISC(4)="ORIG_DATE^6/1/2010@12:00 PM"
 S MISC(5)="ORIGINTR^ZZPROGRAMMER,FIVE"
 S MISC(6)="HISTORIC^1"
 ;MISC(7)="OBSRV_DT^"
 D ALGMAKE^ISIIMPR2(.ISIRESUL,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
T11 ;Allergies unit test 2
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="ALLERGEN^MOLD"
 S MISC(2)="SYMPTOM^RASH|ITCHING,WATERING EYES"
 S MISC(3)="PAT_SSN^666000695"
 S MISC(4)="ORIG_DATE^7/1/2010@12:00 PM"
 S MISC(5)="ORIGINTR^ZZPROGRAMMER,FIVE"
 S MISC(6)="HISTORIC^1"
 ;S MISC(7)="OBSRV_DT^7/1/2010@11:00 AM"
 D ALGMAKE^ISIIMPR2(.ISIRESUL,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
T12 ;Laboratory testing
 ;S DUZ=97
 ;S DUZ(0)="@"
 ;S DUZ(1)=""
 ;S DUZ(2)=1
 ;S DUZ("AG")="E"
 ;S DUZ("BUF")=1
 ;S DUZ("LANG")=""
 ;D ^XUP
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="PAT_SSN^666000790"
 S MISC(2)="LAB_TEST^CHOLESTEROL"
 S MISC(3)="RESULT_DT^T-2@12:00"
 S MISC(4)="RESULT_VAL^110"
 ;S MISC(5)="ENTERED_BY^FRANK,STUART"
 S MISC(6)="LOCATION^PRIMARY CARE"
 D LABMAKE^ISIIMPR2(.ISIRESUL,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
 ;
T13 ;User Create Testing
 S DUZ=1
 D ^XUP
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="TEMPLATE^DEFAULT"
 S MISC(2)="IMP_TYPE^I"
 S MISC(3)="NAME^ZZTESTEIGHT,ZZUSEREIGHT"
 ;S MISC(3)="NAME_MASK^*,TEST*"
 S MISC(4)="SEX^M"
 S MISC(5)="DOB^8/8/78"
 ;S MISC(6)="LOW_DOB^"
 ;S MISC(7)="UP_DOB^"
 ;S MISC(8)="SSN^"
 S MISC(9)="SSN_MASK^66666"
 ;S MISC(10)="STREET_ADD1^"
 ;S MISC(11)="STREET_ADD2")=""
 ;S MISC(12)="CITY^"
 ;S MISC(13)="STATE^"
 ;S MISC(14)="ZIP_4^"
 ;S MISC(15)="ZIP_4_MASK^"
 ;S MISC(16)="MARITAL_STATUS^"
 ;S MISC(17)="PH_NUM^"
 ;S MISC(18)="PH_NUM_MASK^"
 ;S MISC(19)="EMAIL^ZZTHREE.ZZTEST@GMAIL.COM"
 ;S MISC(20)="SERVICE^"
 S MISC(21)="MRG_SOURCE^1"
 ;S MISC(22)="TERM_DATE^"
 D USRCREAT^ISIIMPR1(.ISIRESUL,.MISC)
 W ! ;ZW ISIRESUL
 Q
 ;
T14 ;User batch creation testing
 ;
 S DUZ=1
 D ^XUP
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="TEMPLATE^DEFAULT"
 S MISC(2)="IMP_TYPE^B"
 S MISC(3)="IMP_BATCH_NUM^2"
 S MISC(4)="DFN_NAME^Y"
 S MISC(5)="NAME_MASK^*ZZZSTARK,ZZSTARK"
 ;S MISC(6)="SEX^M"
 ;S MISC(7)="DOB^8/8/78"
 S MISC(8)="LOW_DOB^1/1/1960"
 S MISC(9)="UP_DOB^1/1/1980"
 ;S MISC(10)="SSN^"
 S MISC(11)="SSN_MASK^666"
 S MISC(12)="MRG_SOURCE^1"
 D USRCREAT^ISIIMPR1(.ISIRESUL,.MISC)
 W ! ;ZW ISIRESUL
 Q
 ;
T15 ;
 ;
 S DUZ=1
 D ^XUP
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 D TEMPLATE^ISIIMPUA(.ISIRESUL)
 W ! ;ZW ISIRESUL
 Q
 ;
T16 ;
 ; UNIT TEST for HEALTH FACTOR ADD
 ;
 K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="PAT_SSN^666000011"
 S MISC(2)="HFACTOR^PHYSICAL LIMITATIONS"
 S MISC(3)="PROVIDER^PROGRAMMER,ONE"
 S MISC(4)="DATETIME^11/21/1996@0800"
 S MISC(5)="COMMENT^This is a test."
 ;S MISC(6)="SEVERITY^"
 ;
 D HFACTOR^ISIIMPR3(.ISIRESUL,.MISC)
 W !,"ISIRESUL:",! ;ZW ISIRESUL
 W !,"ISIRC:",$G(ISIRC)
 ;
 Q
 ;
T17 ; Unit test for V IMMUNIZATION
 K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="PAT_SSN^666000011"
 S MISC(2)="IZ^FLU SHOT"
 S MISC(3)="PROVIDER^PROGRAMMER,ONE"
 S MISC(4)="DATETIME^11/21/1996@0800"
 S MISC(5)="COMMENT^This is a test."
 ;
 D VIMMZ^ISIIMPR3(.ISIRESUL,.MISC)
 ;
 W !,"ISIRESUL:",! ;ZW ISIRESUL
 W !,"ISIRC:",$G(ISIRC)
 Q
 ;
T18 ; Unit test for V CPT
 K MISC,ISIMISC,ISIRESUL
 S ISIPARAM("DEBUG")=1
 S MISC(1)="PAT_SSN^666000011"
 S MISC(2)="CPT^99201"
 S MISC(3)="PROVIDER_NARRATIVE^this guy's a little sick"
 S MISC(4)="PROVIDER^PROGRAMMER,ONE"
 S MISC(5)="DATETIME^11/21/1996@0800"
 S MISC(6)="COMMENT^This is a test."
 D VCPT^ISIIMPR3(.ISIRESUL,.MISC)
 W !,"ISIRESUL:",! ;ZW ISIRESUL
 W !,"ISIRC:",$G(ISIRC)
 Q
 ;
T19 ;Unit Test for V EXAM
 ;
 K MISC,ISIMISC,ISIRESUL
 S ISIPARAM("DEBUG")=1
 S MISC(1)="PAT_SSN^666000011"
 S MISC(2)="EXAM^DIABETIC FOOT SENSATION"
 S MISC(3)="PROVIDER^PROGRAMMER,ONE"
 S MISC(4)="DATETIME^11/21/1996@0800"
 ;S MISC(5)="COMMENT^This is a test."
 D VEXAM^ISIIMPR3(.ISIRESUL,.MISC)
 W !,"ISIRESUL:",! ;ZW ISIRESUL
 W !,"ISIRC:",$G(ISIRC)
 Q
 ;
T20 ;unit test for Radiology
 K MISC,ISIMISC,ISIRESUL
 S ISIPARAM("DEBUG")=1
 S MISC(1)="PAT_SSN^666000793"
 S MISC(2)="RAPROC^KNEE 2 VIEWS"
 S MISC(3)="MAGLOC^RADIOLOGY MAIN FLOOR"
 S MISC(4)="PROV^PROGRAMMER,ONE"
 S MISC(5)="RADTE^09/09/2014@1200"
 S MISC(6)="REQLOC^PRIMARY CARE"
 S MISC(7)="REASON^Diagnostic Study."
 S MISC(8)="HISTORY^VTE Confirmed."
 S MISC(9)="TECH^PROGRAMMER,ONE"
 S MISC(10)="TECHCOMM^VTE"
 D RADOMAKE^ISIIMPR1(.ISIRESUL,.MISC)
 W !,"ISIRESUL:",! ;ZW ISIRESUL
 W !,"ISIRC:",$G(ISIRC)
 Q
 ;
T21 ;Unit Test for V PATIENT ED
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="PROVIDER^PROGRAMMER,ONE"
 S MISC(2)="PAT_SSN^666000011"
 S MISC(3)="DATETIME^11/21/1996@0800"
 S MISC(4)="COMMENT^This is a test."
 S MISC(5)="ED_TOPIC^02-DIABETES EDUCATION"
 D VPTEDU^ISIIMPR3(.ISIMISC,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
 ;
T22 ;Unit Test for V POV
 ;MAY 21, 2000@10:02        THIRTYSIX,PATIENT     PRIMARY CARE
 N MISC K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(1)="PROVIDER^PROGRAMMER,ONE"
 S MISC(2)="PAT_SSN^666000036"
 S MISC(3)="DATETIME^MAY 21, 2000@10:02"
 S MISC(4)="COMMENT^This is a test."
 S MISC(5)="ICD9^250.00"
 D VPOV^ISIIMPR3(.ISIMISC,.MISC)
 W !,ISIRC,! ;ZW ISIRESUL
 Q
 ;
T23 ;unit test for template save
 ;
 K MISC
 S ISIPARAM("DEBUG")=1
 S MISC(0)="NAME^DEFAULT"
 S MISC(1)="TYPE^NON-VETERAN (OTHER)"
 S MISC(2)="NAME_MASK^*,PATIENT"
 S MISC(3)="SSN_MASK^666"
 S MISC(4)="SEX^"
 S MISC(5)="EDOB^JAN 01, 1929"
 S MISC(6)="LDOB^MAY 24, 2012"
 S MISC(7)="MARITAL_STATUS^"
 S MISC(8)="ZIP_MASK^99999"
 S MISC(9)="PH_NUM^999"
 S MISC(10)="CITY^"
 S MISC(11)="STATE^"
 S MISC(12)="VETERAN^NO"
 S MISC(13)="DFN_NAME^N"
 S MISC(14)="EMPLOY_STAT^"
 S MISC(15)="SERVICE^MEDICAL ADMINISTRATION"
 S MISC(16)="EMAIL_MASK^HOSPITAL.NET"
 S MISC(17)="USER_MASK^*,ZZUSERTEST"
 S MISC(18)="ESIG_APND^11"
 S MISC(19)="ACCESS_APND^1"
 S MISC(20)="VERIFY_APND^1."
 D TMPUPDTE^ISIIMPR1(.ISIRESUL,.MISC)
 W !,ISIRC,!
 Q
