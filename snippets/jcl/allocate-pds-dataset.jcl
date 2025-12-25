//*
//* Allocate a NEW PDS (Partitioned Data Set)
//*
//* A PDS is a dataset that contains members (like files in a folder).
//* Many “source libraries” and “procedure libraries” are PDS/PDSE.
//*
//* This job uses program IEFBR14 (a “do nothing” program). The 
//* allocation is performed by the DD statement.
//*
//* IMPORTANT:
//* - Review all code before execution.
//* - Test in non-production first.
//* - Follow your site security and change-control processes.
//* - Replace placeholders with values valid for your environment.
//*
//ALLOCPDS JOB (ACCT),'ALLOC PDS',CLASS=YOURCLASS,
//             MSGCLASS=YOURMSG,NOTIFY=&SYSUID
//*
//* JOB card quick notes:
//* - CLASS/MSGCLASS/ACCT are site-specific
//* - NOTIFY=&SYSUID tells JES to notify your TSO user id
//*
//STEP1    EXEC PGM=IEFBR14
//*
//* The DD statement below requests the dataset allocation.
//*
//NEWPDS   DD  DSN=YOURHLQ.YOURID.TEST.PDS,               
//             DISP=(NEW,CATLG,DELETE),                   
//             UNIT=SYSDA,                                
//             SPACE=(TRK,(10,5,10),RLSE),                
//             DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=0),
//             DSNTYPE=PDS
//*
//* Key fields explained:
//*
//* DSN=
//*   The dataset name you want to create.
//*
//* DISP=(NEW,CATLG,DELETE)
//*   - NEW   : allocate a new dataset
//*   - CATLG : if successful, catalog it
//*   - DELETE: if the step fails, delete it
//*
//* SPACE=(TRK,(primary,secondary,directory),RLSE)
//*   - TRK means tracks.
//*   - primary/secondary are space amounts.
//*   - directory is the number of directory blocks (controls how many
//*     members you can have). Beginners: if you run out of directory
//*     blocks, you can't add new members even if there’s free space.
//*   Example above:
//*     (10,5,10) = 10 tracks primary, 5 tracks secondary, 10 directory
//*     blocks.
//*
//* DCB=(DSORG=PO,...)
//*   - DSORG=PO indicates a partitioned dataset (PDS).
//*   - RECFM/LRECL/BLKSIZE describe how records are stored.
//*
//* DSNTYPE=PDS
//*   Explicitly requests a “classic” PDS.
//*   Note: Many sites prefer PDSE (DSNTYPE=LIBRARY). If your standards
//*   prefer PDSE, change this to: DSNTYPE=LIBRARY.
//*
//* What you should see if it works:
//* - Job ends with condition code 0000
//* - Dataset exists and is cataloged
//* - You can add members (e.g., in ISPF: 3.4 then create member)
