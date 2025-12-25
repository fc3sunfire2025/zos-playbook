//*
//* Allocate a NEW sequential dataset (DSORG=PS)
//*
//* This job uses program IEFBR14 (a “do nothing” program) because
//* the allocation work is performed by the DD statement below.
//*
//* IMPORTANT:
//* - Review before execution.
//* - Follow your site security and change-control processes.
//* - Replace placeholders (YOURHLQ/YOURCLASS/etc.) with values that
//*   are valid for your environment.
//*
//ALLOCSEQ  JOB (ACCT),'ALLOC SEQ DS',CLASS=YOURCLASS,
//             MSGCLASS=YOURMSG,NOTIFY=&SYSUID
//*
//* JOB card basics:
//* - (ACCT)        = accounting info (site-specific)
//* - 'ALLOC SEQ DS'= job description (anything meaningful)
//* - CLASS         = what execution class to run in (site-specific)
//* - MSGCLASS      = where JES messages go (site-specific)
//* - NOTIFY        = user id to notify when job ends (&SYSUID = you)
//*
//STEP1    EXEC PGM=IEFBR14
//*
//* STEP1 runs IEFBR14; it does not process data.
//* The DD statement below tells z/OS to allocate a brand new dataset.
//*
//NEWPS    DD  DSN=YOURHLQ.YOURID.TEST.SEQ,              
//             DISP=(NEW,CATLG,DELETE),                  
//             UNIT=SYSDA,                               
//             SPACE=(TRK,(5,2),RLSE),                   
//             DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=0)
//*
//* DD statement basics (this is the “allocation request”):
//*
//* DSN=
//*   The dataset name you want to create.
//*   - Use your site’s naming rules/conventions.
//*   - Tip: Many sites expect the first qualifier (HLQ) to match your
//*     user id or an approved project HLQ.
//*
//* DISP=(status,normal-disposition,abnormal-disposition)
//*   - NEW   : dataset does not exist yet; allocate it.
//*   - CATLG : if the step ends normally, catalog the dataset (so it
//*             shows up in the catalog and can be referenced later by
//*             name).
//*   - DELETE: if the step abends/fails, delete it (cleanup).
//*
//* UNIT=
//*   The device type/group to allocate on.
//*   - SYSDA is a common default “general DASD” unit group.
//*   - Your site may require a different UNIT or a specific storage 
//*     class.
//*
//* SPACE=
//*   Primary and secondary allocation.
//*   - TRK means tracks (you can also use CYL for cylinders).
//*   - (5,2) means: start with 5 tracks; if more is needed, add 2 
//*                  tracks.
//*   - RLSE releases unused space at close (nice for small examples).
//*
//* DCB=
//*   Dataset characteristics.
//*   - DSORG=PS  : sequential dataset
//*   - RECFM=FB  : fixed-length, blocked
//*   - LRECL=80  : each record is 80 bytes (a common “card image” 
//*                 size)
//*   - BLKSIZE=0 : let the system choose an efficient block size
//*
//* What you should see if it works:
//* - The job ends with condition code 0000 (or small non-zero 
//*   usually less than 8 depending on site)
//* - The dataset exists and is cataloged under the DSN you chose.
