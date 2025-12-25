//* Working off of the allocate-sequential-dataset.jcl, you will want
//* to use this as a starting point. The biggest change when creating
//* a dataset for a digitial certificate is that the LRECL needs to be
//* 84 versus 80 and the RECFM is VB (Variable Block) versus FB and
//* finally the BLKSIZE should have a value divisible by 80. A common
//* number of 6160 usually works.
//* 
//ALLOCERT  JOB (ACCT),'ALLOC SEQ CERT DS',CLASS=YOURCLASS,
//             MSGCLASS=YOURMSG,NOTIFY=&SYSUID
//STEP1    EXEC PGM=IEFBR14
//*
//NEWCERT  DD  DSN=YOURHLQ.YOURID.SEQ.CERT,              
//             DISP=(NEW,CATLG,DELETE),                  
//             UNIT=SYSDA,                               
//             SPACE=(TRK,(5,2),RLSE),                   
//             DCB=(DSORG=PS,RECFM=VB,LRECL=84,BLKSIZE=6160)
//