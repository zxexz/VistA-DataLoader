ISIIMP22 ;ISI GROUP/MLS -- IMPORT USER INFORMATION API
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
USER(ISIRESUL,ISIMISC)
 N ERR,VAL
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 ;Validate setup & parameters
 S ISIRC=$$VALIDATE Q:+ISIRC<0 ISIRC
 ;Create USER record
 S ISIRC=$$CREATEUSR Q:+ISIRC<0 ISIRC
 ; Quit with DFN
 Q ISIRC
 ;
VALIDATE()      ;
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . W !,"+++Template merged params+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,X," ",$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X
 . Q
 ;
 ; Validate import array contents
 S ISIRC=$$VALIDATE^ISIIMPUD(.ISIMISC)
 Q ISIRC
 ;
CREATEUSR() ;
 ; Create USER(s)
 S ISIRC=$$IMPRTUSR(.ISIMISC)
 Q ISIRC
 ;
IMPRTUSR(ISIMISC)
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("NAME")="FIRST,LAST"
 ;
 ; Output - ISIRC [return code]
 ;          ISIRESUL(0) = CNT
 ;          ISIRESUL(1) = DFN^SSN^NAME
 ;
 I ISIMISC("IMP_TYPE")="B" D BATCH
 I ISIMISC("IMP_TYPE")="I" D INDIVIDUAL
 Q ISIRC
 ;
INDIVIDUAL
 N SSN,SSNMASK,RETURN,STRTSSN,ENDSSN,NUM,INCR
 N NAME,INITIAL,SEX,DOB,STRT1,STRT2,CITY,STATE,ZIP,PHON,PHOFFICE
 N SERVICE,EMAIL,USERCLASS,TERMDT,MRGSRC,ZDFN
 N ELSIG,ACCESS,VERIFY,SIGAPND,ACCAPND,VERAPND,GENACVE
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . W !,"+++Starting Individual USER Create+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,X," ",$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 S ISIRC=0,INCR=1
 S SSN=$G(ISIMISC("SSN"))
 I SSN'="" D  Q
 . I $D(^VA(200,"SSN",SSN)) S ISIRC="-1^Duplicate SSN" Q
 . S STRTSSN="9"_SSN
 . D PREPVAL I +ISIRC<0 Q
 . D CREATE
 . Q
 I SSN="" D
 . S SSNMASK=$G(ISIMISC("SSN_MASK"))
 . I SSNMASK="" S SSNMASK="000"
 . S RETURN=$$EVALSSNMASK(SSNMASK)
 . I (+RETURN)<1 S SSNMASK="666" S RETURN=$$EVALSSNMASK(SSNMASK)
 . I (+RETURN)<1 S ISIRC="-1^Error: unable to create SSN (ISIIMP03)" Q  ; We've run out of non-standard SSN's! Time to refresh your database.
 . S STRTSSN="9"_$P(RETURN,"|",2),ENDSSN="9"_$P(RETURN,"|",3)
 . F  Q:'$D(^VA(200,"SSN",$E(STRTSSN,2,10)))  S STRTSSN=STRTSSN+1
 . I STRTSSN>ENDSSN S ISIRC="-1^Problem generating SSN" Q
 . S SSN=$E(STRTSSN,2,10)
 . D PREPVAL I +ISIRC<0 Q ;in case of error
 . D CREATE
 . I +ISIRC<0 Q
 . ; call copy utility
 . I +$G(MRGSRC) D COPYUSR^ISIIMP23(MRGSRC,ZDFN) ;
 . Q
 Q
 ;
BATCH ;
 N INCR,I,NUM,RETURN,SSNMASK,SSN,STRTSSN,ENDSSN,EXIT
 N NAME,INITIAL,SEX,DOB,STRT1,STRT2,CITY,STATE,ZIP,PHON,PHOFFICE
 N SERVICE,EMAIL,USERCLASS,TERMDT,MRGSRC,ZDFN
 N ELSIG,ACCESS,VERIFY,SIGAPND,ACCAPND,VERAPND,GENACVE
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . W !,"+++Starting Batch USER Creation+++",!
 . I $D(ISIMISC) W $G(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,ISIMISC(X)
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 S EXIT=0,ISIRC=0
 S NUM=$G(ISIMISC("IMP_BATCH_NUM"))
 S SSNMASK=$G(ISIMISC("SSN_MASK"))
 S RETURN=$$EVALSSNMASK(SSNMASK)
 I (+RETURN)<NUM S ISIRC="-1^No. of USERs requested exceeds SSN MASK" Q
 S STRTSSN="9"_$P(RETURN,"|",2),ENDSSN="9"_$P(RETURN,"|",3)
 F INCR=1:1:NUM D  Q:EXIT=1
 . F  Q:'$D(^VA(200,"SSN",$E(STRTSSN,2,10)))  S STRTSSN=STRTSSN+1
 . I STRTSSN>ENDSSN S EXIT=1,ISIRC="-1^Problem generating SSNs" Q
 . S SSN=$E(STRTSSN,2,10)
 . D PREPVAL I +ISIRC<0 S EXIT=1 Q
 . D CREATE
 . I +ISIRC<0 S EXIT=1 Q
 . I +$G(MRGSRC) D COPYUSR^ISIIMP23(MRGSRC,ZDFN)
 . Q
 Q
 ;
PREPVAL ;Prep import values
 N LDOB,UDOB
 S (NAME,SEX,DOB,STRT1,STRT2,CITY,STATE,ZIP,PHON,EMAIL,PHOFFICE,USERCLASS,SERVICE,TERMDT,MRGSRC,INITIAL)=""
 S NAME=$G(ISIMISC("NAME")) I NAME="" S NAME=$$MASK^ISIIMP03("NAME",$G(ISIMISC("NAME_MASK")),INCR)
 D STDNAME^XLFNAME(.NAME,"C") S INITIAL=$E($G(NAME("GIVEN")))_$E($G(NAME("FAMILY")))
 S SEX=$G(ISIMISC("SEX"))
 I SEX="" S SEX=$$SEX^ISIIMP03
 S DOB=$G(ISIMISC("DOB")) I DOB="" S LDOB=$G(ISIMISC("LOW_DOB")),UDOB=$G(ISIMISC("UP_DOB")) S DOB=$$DOB^ISIIMP03
 S STRT1=$G(ISIMISC("STREET_ADD1"))
 I STRT1="" S STRT1=$$STREET^ISIIMP03
 S STRT2=$G(ISIMISC("STREET_ADD2"))
 S CITY=$G(ISIMISC("CITY")) I CITY="" S CITY=$$CITY^ISIIMP03
 S STATE=$G(ISIMISC("STATE")) I STATE="" S STATE=$$STATE^ISIIMP03
 S ZIP=$G(ISIMISC("ZIP")) I ZIP="" S ZIP=$$MASK^ISIIMP03("ZIP",$G(ISIMISC("ZIP_4_MASK")))
 S PHON=$G(ISIMISC("PH_NUM")) I PHON="" S PHON=$$MASK^ISIIMP03("PHONE",$G(ISIMISC("PH_NUM_MASK")))
 S EMAIL=$G(ISIMISC("EMAIL")) I EMAIL="" S EMAIL=$$MASK^ISIIMP03("EMAIL",$G(ISIMISC("EMAIL_MASK")))
 S PHOFFICE=$G(ISIMISC("PH_OFFICE")) I PHOFFICE="" S PHOFFICE=$$MASK^ISIIMP03("PHONE",$G(ISIMISC("PH_NUM_MASK")))
 S USERCLASS=$G(ISIMISC("USER_CLASS"))
 S SERVICE=$G(ISIMISC("SERVICE"))
 S TERMDT=$G(ISIMISC("TERM_DATE"))
 S MRGSRC=$G(ISIMISC("MRG_SOURCE"))
 S ELSIG=$G(ISIMISC("ELSIG"))
 S ACCESS=$G(ISIMISC("ACCESS"))
 S VERIFY=$G(ISIMISC("VERIFY"))
 S SIGAPND=$G(ISIMISC("ELSIG_APND")) I SIGAPND="" S SIGAPND="11"
 S ACCAPND=$G(ISIMISC("ACCESS_APND")) I ACCAPND="" S ACCAPND="1"
 S VERAPND=$G(ISIMISC("VERIFY_APND")) I VERAPND="" S VERAPND="1."
 S GENACVE=+$G(ISIMISC("GEN_ACCVER"))
 ;
 ; Final check of required values
 ; ------------------------------
 I $G(NAME)="" S ISIRC="-1^Missing valid NAME value (PREPVAL~ISIIMP22)" Q
 I $L(+$G(SSN))<9 S ISIRC="-1^Missing valid SSN value (PREPVAL~ISIIMP22)" Q
 I $G(SERVICE)=0 S ISIRC="-1^Missing valid SERVICE value (PREPVAL~ISIIMP22)" Q
 Q
 ;
CREATE ;
 N FDA,MSG
 K FDA,FDAIENS
 S DIC="^VA(200,",DIC(0)="ILMXZ",DLAYGO=200 ;maybe
 D
 . S FDA(200,"+1,",.01)=NAME
 . I $G(INITIAL)'="" S FDA(200,"+1,",1)=INITIAL
 . S FDA(200,"+1,",4)=SEX
 . S FDA(200,"+1,",5)=DOB
 . S FDA(200,"+1,",9)=SSN
 . S FDA(200,"+1,",29)=SERVICE
 . I $G(STRT1)'="" S FDA(200,"+1,",.111)=STRT1
 . I $G(STRT2)'="" S FDA(200,"+1,",.112)=STRT2
 . I $G(CITY)'="" S FDA(200,"+1,",.114)=CITY
 . I $G(STATE)'="" S FDA(200,"+1,",.115)=STATE
 . I $G(ZIP)'="" S FDA(200,"+1,",.116)=ZIP
 . I $G(PHON)'="" S FDA(200,"+1,",.131)=PHON ;home phone
 . I $G(PHOFFICE)'="" S FDA(200,"+1,",.132)=PHOFFICE ;office phone
 . I $G(EMAIL)'="" S FDA(200,"+1,",.151)=EMAIL
 . I $G(TERMDT)'="" S FDA(200,"+1,",9.2)=TERMDT
 . ;
 . I USERCLASS'="" D
 . . S FDA(200.07,"+2,+1,",.01)=USERCLASS
 . . S FDA(200.07,"+2,+1,",2)=1 ;Is primary (yes)
 . ;
 . D UPDATE^DIE("E","FDA","FDAIENS","MSG")
 . I $D(MSG) S ISIRC="-1^"_$G(MSG("DIERR",1,"TEXT",1)) Q
 . S ZDFN=+$G(FDAIENS(1))
 . ;
 . I '$D(^VA(200,"SSN",$E(STRTSSN,2,10))) S ISIRC="-1^Problem generating user (CREATE~ISIIMP22)." Q
 . I $G(ISIMISC("DFN_NAME"))="Y" I $G(ISIMISC("NAME_MASK"))'="" I $G(ISIMISC("NAME"))="" D
 . . S NAME=$$MASK^ISIIMP03("NAME",$G(ISIMISC("NAME_MASK")),$O(^VA(200,"SSN",$E(STRTSSN,2,10),"")))
 . . S ISIRC=$$CHNGUSER^ISIIMPU3(ZDFN,NAME)
 . . Q
 . ;
 . N ZLNAME S ZLNAME=$P($G(^VA(200,ZDFN,0)),U),ZLNAME=$P(ZLNAME,",")_"*" ;
 . S ELSIG=$G(ELSIG) I ELSIG="" S ELSIG=$$MASK^ISIIMP03("ELSIG",ZLNAME,SIGAPND)
 . D FILESIG
 . S ACCESS=$G(ACCESS) I ACCESS="" S ACCESS=$$MASK^ISIIMP03("ACCESS",ZLNAME,ACCAPND)
 . I $G(GENACVE) D FILEACC
 . S VERIFY=$G(VERIFY) I VERIFY="" S VERIFY=$$MASK^ISIIMP03("VERIFY",ZLNAME,VERAPND)
 . I $G(GENACVE) D FILEVER
 . ;
 . I +ISIRC<0 Q
 . S ISIRESUL(INCR)=ZDFN_"^"_$E(STRTSSN,2,10)_"^"_NAME
 . S ISIRESUL(0)=INCR
 . Q
 Q
 ;
FILESIG
 N tempFILE,tempFIELD
 K MSG,FDA
 S ELSIG=$G(ELSIG)
 Q:$L(ELSIG)<6 ;mininum 6 chars
 S tempFILE="200"
 S tempFIELD="20.4"
 S FDA(tempFILE,ZDFN_",",tempFIELD)=ELSIG
 D FILE^DIE("E","FDA","MSG")
 I $G(DIERR) S ISIRC="-1^Error "_$G(DIERR)_" filing EL SIG (FILESIG~ISIIMP22) for DFN:"_$G(ZDFN)
 ;ZW DIERR I $D(MSG) W ! ZW MSG
 Q
 ;
FILEACC ;
 N tempFILE,tempFIELD
 K MSG,FDA
 S tempFILE="200"
 S tempFIELD="2"
 S FDA(tempFILE,ZDFN_",",tempFIELD)=ACCESS
 D FILE^DIE("E","FDA","MSG")
 I $G(DIERR) S ISIRC="-1^Error "_$G(DIERR)_" filing ACCESS CODE (FILEACC~ISIIMP22) for DFN:"_$G(ZDFN)
 Q
 ;
FILEVER ;
 N tempFILE,tempFIELD
 K MSG,FDA
 S tempFILE="200"
 S tempFIELD="11"
 S FDA(tempFILE,ZDFN_",",tempFIELD)=VERIFY
 D FILE^DIE("E","FDA","MSG")
 I $G(DIERR) S ISIRC="-1^Error "_$G(DIERR)_" filing VERIFY CODE (FILEVER~ISIIMP22) for DFN:"_$G(ZDFN)
 Q
 ;
EVALSSNMASK(VALUE)      ;
 N I,II,X,CNT
 S I=VALUE F X=$L(VALUE)+1:1:9 S $E(I,X)="0"
 S I="9"_I
 S II=VALUE F X=$L(VALUE)+1:1:9 S $E(II,X)="9"
 S II="9"_II
 S CNT=0 F X=I:1:II I '$D(^VA(200,"SSN",$E(X,2,10))) S CNT=CNT+1
 S I=$E(I,2,10),II=$E(II,2,10)
 Q CNT_"|"_I_"|"_II
 ;
