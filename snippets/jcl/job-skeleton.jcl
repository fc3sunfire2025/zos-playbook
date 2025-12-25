//YOURJOB  JOB (ACCT),'DESCRIPTION',CLASS=YOURCLASS,
//             MSGCLASS=YOURMSG,NOTIFY=&SYSUID
//* The 2 lines above this line are your 'job card' and used when you
//* submit jobs to the mainframe. They may differ from LPAR to LPAR.
//*
//* Comments as you may have guessed are 2 slashes and an asterisk
//*
//* Purpose: Minimal JCL skeleton for reference.
//* Notes: Replace placeholders per your site standards.
//* Someone on your team should be able to provide this to you
//* IEFBR14 in this context does literally nothing, so it is common
//* to see/use as a beginner 'hello world' kind of test
//* ----------------------
//* Spacing kinda matters
//* The STEP1 below can be up to 8 characters, then a space, then
//*  either EXEC or DD usually and a space. Then usually what you 
//*  want to execute, like PGM=IEFBR14, or DD * 
//STEP1    EXEC PGM=IEFBR14
//*TEP2    DD *
//*
//* When you see 2 slashes and nothing after them, the system will
//* treat this as the end of the job even if there is code after
//
//* This is a comment, but if it were code it wouldn't be 'seen'
