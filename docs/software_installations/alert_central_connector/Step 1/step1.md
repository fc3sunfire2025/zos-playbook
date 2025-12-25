# Allocate and Mount a File System for Alert Central Connector
- Required to define/reserve space in USS for us to download the Alert Central Connector Pax file
- BEFORE mounting a zFS, the directory must exist already on the system you are installing on which is often called a mount point
- ASSUMPTION: We are using `/u/maint/acc010` as our preferred mount point
- ASSUMPTION: We are using `PRODUCT.ACC010.ZFS` as the data set which holds the zFS
- 1. In USS (ssh, OMVS, FTP client) go to the 'parent' directory
```
cd /u/maint
```
- Create a new directory to save the Alert Central Connector Pax File
```
mkdir acc010
```
- Change or Goto that directory
```
cd acc010
```
- Create a folder to hold the Pax itself
```
mkdir PAX
```
- 2. Optional
- 3. Now we can allocation the zFS using the following sample (if using SMS)
```
//DEFINE   EXEC PGM=IDCAMS
//SYSPRINT DD   SYSOUT=*
//SYSUDUMP DD   SYSOUT=*
//AMSDUMP  DD   SYSOUT=*
//SYSIN    DD *
   DEFINE CLUSTER (NAME(PRODUCT.ACC010.ZFS) -
   ZFS CYL(550,550) SHAREOPTIONS(3 3))
/*
//*
```
- 3a. If you are NOT using SMS add a VOL statement similar to
```
//DEFINE   EXEC PGM=IDCAMS
//SYSPRINT DD   SYSOUT=*
//SYSUDUMP DD   SYSOUT=*
//AMSDUMP  DD   SYSOUT=*
//SYSIN    DD *
   DEFINE CLUSTER (NAME(PRODUCT.ACC010.ZFS) -
   VOL(TSODE12) -
   ZFS CYL(550,550) SHAREOPTIONS(3 3))
/*
//*
```
- 4. Mount the file system using the following sample
```
//MOUNT    EXEC PGM=IKJEFT01,REGION=0M          
//SYSTSPRT DD SYSOUT=*                        
//SYSTSOUT DD SYSOUT=*                        
//SYSTSIN  DD *
   MOUNT FILESYSTEM('PRODUCT.ACC010.ZFS') +
   MOUNTPOINT('/u/maint/acc010') +
   TYPE(ZFS) MODE(RDWR) +
   PARM('AGGRGROW')
/*
```
- 5. Verify using the following commands
```
cd /u/maint/acc010
```
- Then:
```
df -k .
```