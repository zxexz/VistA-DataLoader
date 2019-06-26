ISIIMPU7 ;ISI GROUP/MLS -- IMPORT Utility LABS ; 17 Sep 2018 12:30 PM
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
MISCDEF ;;+++++ DEFINITIONS OF LAB MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD |DESC
 ;;-----------------------------------------------------------------------
 ;;PAT_SSN          |FIELD      |           |PATIENT (#2) pointer
 ;;LAB_TEST         |FIELD      |           |Laboratory test name
 ;;RESULT_DT        |FIELD      |           |Date/time of result
 ;;RESULT_VAL       |FIELD      |           |Lab test result value
 ;;LOCATION         |FIELD      |           |Lab test location
 Q
 ;
LABMISC(MISC,ISIMISC)
 ;INPUT:
 ;  MISC(0)=PARAM^VALUE - raw list values from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC(PARAM)=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$LABMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
LABMISC1(DSTNODE)
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM="RESULT_DT" D
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid "_PARAM_" date/time." Q
 . . S VALUE=RESULT
 . . I $P(VALUE,".",2)="" S VALUE=VALUE_".1200"
 . . Q
 . I EXIT Q
 . S @DSTNODE@(PARAM)=VALUE
 . Q
 Q ISIRC ;return code
 ;
LOADMISC(MISCDEF) ;
 N BUF,FIELD,I,NAME,TYPE
 K MISCDEF
 F I=3:1  S BUF=$P($T(MISCDEF+I),";;",2)  Q:BUF=""  D
 . S NAME=$$TRIM^XLFSTR($P(BUF,"|"))  Q:NAME=""
 . S TYPE=$$TRIM^XLFSTR($P(BUF,"|",2))
 . S FIELD=$$TRIM^XLFSTR($P(BUF,"|",3))
 . S MISCDEF(NAME)=TYPE_"|"_FIELD
 Q
 ;
VALLAB(ISIMISC)
 ; Entry point to validate content of LAB create/array
 ;
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("LAB_TEST")="CHOLESTEROL"
 ;
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,VALUE,RESULT,MSG,MISCDEF,EXIT,TEMP,Y,Z
 N COLLIEN,SPECIEN,LABNAME,IDT,RDT
 S EXIT=0
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 ;
 ; -- PAT_SSN --
 I '$D(ISIMISC("PAT_SSN")) Q "-1^Missing Patient SSN."
 I $D(ISIMISC("PAT_SSN")) D
 . S VALUE=$G(ISIMISC("PAT_SSN")) I VALUE="" S EXIT=1 Q
 . I '$D(^DPT("SSN",VALUE)) S EXIT=1 Q
 . S DFN=$O(^DPT("SSN",VALUE,"")) I DFN="" S EXIT=1 Q
 . S ISIMISC("DFN")=DFN
 . Q
 Q:EXIT "-1^Invalid PAT_SSN (#2,.09)."
 ;
 ; -- LAB_TEST --
 I '$D(ISIMISC("LAB_TEST")) Q "-1^Missing LAB_TEST."
 I $D(ISIMISC("LAB_TEST")) D
 . S VALUE=$G(ISIMISC("LAB_TEST")) I VALUE="" S EXIT=1,MSG="Missing value for LAB_TEST (#60)." Q
 . I VALUE["-" N LIEN S LIEN=$$LOINCCHK(VALUE) I LIEN S VALUE=$P(^LAB(60,LIEN,0),U)
 . I '$D(^LAB(60,"B",VALUE)) S EXIT=1,MSG="Couldn't find ien for LAB_TEST (#60)." Q
 . S Y=$O(^LAB(60,"B",VALUE,"")) I Y="" S EXIT=1,MSG="Couldn't find ien for LAB_TEST (#60)." Q
 . S Z=$P($G(^LAB(60,Y,0)),U,4) I Z'="CH" S EXIT=1,MSG="LAB_TEST incorrect. SUBSCRIPT (#60,4) must by 'CH'." Q
 . S Z=0,TEMP=Y,Y=$O(^LAB(60,TEMP,3,Z)) I Y="" S EXIT=1,MSG="Couldn't locate COLLECTION SAMPLE (#60.03) for LAB_TEST value." Q
 . S LABNAME=$P($G(^LAB(60,TEMP,0)),U)
 . S Z=+$G(^LAB(60,TEMP,3,Y,0)) I Z="" S EXIT=1,MSG="Couldn't locate COLLECTION SAMPLE (#60.03) for LAB_TEST value." Q
 . S COLLIEN=Z,Y=$G(^LAB(62,COLLIEN,0)) S SPECIEN=$P(Y,U,2) I SPECIEN="" S EXIT=1,MSG="Couldn't locate DEFAULT SPECIMIN (#62,2) for LAB_TEST value." Q
 . S ISIMISC(1)=TEMP_U_LABNAME_U_COLLIEN_U_U_SPECIEN
 . S ISIMISC("B",1)=1 ;
 . S ISIMISC("C",TEMP,1)=1
 . Q
 Q:EXIT "-1^"_MSG
 ;
 ; -- RESULT_VAL --
 I '$D(ISIMISC("RESULT_VAL")) Q "-1^Missing RESULT_VAL."
 I $D(ISIMISC("RESULT_VAL")) D
 . S VALUE=$G(ISIMISC("RESULT_VAL")) I VALUE="" S EXIT=1 Q
 . ;S Y=VALUE,Z=""
 . ;I VALUE["." S Y=$P(VALUE,"."),Z=$P(VALUE,".",2) I Z'="" S Z=$E(Z,1,2) I Z'?1N.N S EXIT=1 Q
 . ;F X=1:1 Q:EXIT!($E(Y,X)="")  I $E(Y,X)'?1N S EXIT=1 Q
 . ;I EXIT Q
 . ;I Z'="" S VALUE=Y_"."_Z,ISIMISC("RESULT_VAL")=VALUE Q
 . Q
 Q:EXIT "-1^Missing RESULT_VAL."
 ;
 ; -- RESULT_DT --
 I $G(ISIMISC("RESULT_DT"))="" Q "-1^Missing RESULT_DT entry."
 S FIELD=.01 ;Using another date/time to validate ;$P(MISCDEF("RESULT_DT"),"|",2)
 S FILE=120.5 ;Using another date/time field to validate; $P(FIELD,",")
 ; S FIELD=$P(FIELD,",",2)
 S FLAG="",VALUE=ISIMISC("RESULT_DT")
 S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG)
 Q:'(+RESULT) "-1^Invalid RESULT_DT"
 ;
 ; -- ENTERED_BY --
 I '$D(^XUSEC("LRLAB",DUZ))&('$D(^XUSEC("LRVERIFY",DUZ))) Q "-1^Invalid ENTERED_BY (#200,.01).  Insufficient privilages."
 S ISIMISC("INITIALS")=$P($G(^VA(200,DUZ,0)),U,2)
 ;
 ; -- LOCATION --
 I '$D(ISIMISC("LOCATION")) Q "-1^Missing LOCATION."
 I $D(ISIMISC("LOCATION")) D
 . S VALUE=$G(ISIMISC("LOCATION")) I VALUE="" S EXIT=1 Q
 . S Y=$O(^SC("B",VALUE,"")) I Y="" S EXIT=1 Q
 . S IDT=$P($G(^SC(Y,"I")),U)
 . S RDT=$P($G(^SC(Y,"I")),U,2)
 . I IDT'="" I RDT="" I IDT<DT S EXIT=1 Q
 . I RDT'="" I RDT>IDT I RDT>DT S EXIT=1 Q
 . I RDT'="" I RDT<IDT I IDT<DT S EXIT=1 Q
 . S ISIMISC("LOCATION")=Y
 . Q
 Q:EXIT "-1^Invalid LOCATION value (#44,.01)."
 ;
 I $$LABDUP(ISIMISC("DFN"),ISIMISC("RESULT_DT"),LABNAME) Q "-1^Duplicate Lab Test entry for patient."
 Q 1
 ;
LOINCCHK(LOINC)
 N IEN,LIEN,NODE,TMP,WARRAY,WIEN,WINDX,LTESTI
 S IEN=0,LOINC=$G(LOINC)
 ; check loinc is in #95.3
 S LIEN=+LOINC
 I '$D(^LAB(95.3,LIEN)) Q 0 ; no lab loinc found
 S NODE=$G(^LAB(95.3,LIEN,0))
 S TMP=$P(NODE,U)_"-"_$P(NODE,U,15) ;build full loinc w/check digit
 I TMP'=LOINC Q 0 ;doesn't match
 ; Check #64 WKLD CODE
 F WINDX="AI","AH" D
 . S WIEN=0 F  S WIEN=$O(^LAM(WINDX,LIEN,WIEN)) Q:'WIEN  D
 . . I '$D(^LAB(60,"AC",WIEN)) Q ;no entry in #60 (Lab Test)
 . . S WARRAY(WIEN)=""
 . . Q
 . Q
 ; Get Lab test from #60
 S WIEN=0 F  S WIEN=$O(WARRAY(WIEN)) Q:'WIEN!IEN  D
 . S LTESTI=0 F  S LTESTI=$O(^LAB(60,"AC",WIEN,LTESTI)) Q:'LTESTI!IEN  D
 . . I '$D(^LAB(60,"AF",LIEN,LTESTI)) Q ;check Lab Loinc x-ref against test
 . . S IEN=LTESTI
 . . Q
 . Q
 ;
 Q IEN
 ;
LABDUP(DFN,DTTM,LTEST)
 N LRDFN,LRDN,LTIEN,RVDT,EXIT
 S EXIT=0
 S LRDFN=$$LRDFN^LRPXAPIU(DFN)
 I 'LRDFN Q 0
 S LTIEN=$O(^LAB(60,"B",LTEST,0))
 S LRDN=$$LRDN^LRPXAPIU(LTIEN)
 S RVDT=$$LRIDT^LRPXAPIU(DTTM)
 I $D(^LR(LRDFN,"CH",RVDT,LRDN)) S EXIT=1
 Q EXIT
