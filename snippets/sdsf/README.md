# SDSF notes & snippets

This folder can hold SDSF command notes, panel navigation tips, and operational runbooks.

## Index

- Every new z/OS release adds functionality usually to SDSF, so it behooves you to check the release notes at a bare minimum
- We are running z/OS 3.1 at the time of this writing

## Commands
- Assumption being made is that issuing `=s` will take you to the SDSF Menu
### S.ST (Status of jobs)
- Filtering is done using `pre filter*`, so to show all jobs starting with `PROD` you would enter `pre prod*`
- Also useful, filter by `Owner`, so to show all jobs that were started by `PROD` you would enter `owner prod*` 
- Good for showing batch jobs
- If the job is not shown, check using the `DA` (Active users) option
```
SDSF STATUS DISPLAY ALL CLASSES                        LINE 1-19 (191)         
COMMAND INPUT ===>                                            SCROLL ===> CSR  
NP   JOBNAME  JobID    Owner    Prty Queue      C   Pos SAff  ASys Status      
     PROD001  TSU00193 PROD001    15 EXECUTION          A153  A153             
     SYSLOG   STC00002 +MASTER+   15 EXECUTION          A153  A153             
     NET      STC00006 START1     15 EXECUTION          A153  A153             
```
### S.DA (Active users)
- You can use similar filtering here as well
- Difference between `DA` and `ST` is `DA` are running currently. You may see jobs running in `DA` that do not show in `ST`. 
```
SDSF DA A153     A153     PAG  0  CPU/L     3/***      LINE 1-19 (95)          
COMMAND INPUT ===>                                            SCROLL ===> CSR  
NP   JOBNAME  StepName ProcStep JobID    Owner    C Pos DP Real Paging    SIO  
     *MASTER*                   STC00002 +MASTER+   NS  FF 2136   0.00   0.01  
     PCAUTH   PCAUTH                                NS  FF  129   0.00   0.00  
     RASP     RASP                                  NS  FF  300   0.00   0.00  
```
### S.SYS (System information)
- Shows the system information for all LPARs in the current sysplex
- The example LPAR is in a monoplex, meaning, no other LPARs are connected
- Shows CPU% and memory usage
```
SDSF SYSTEMS  A153     A153      MONOPLEX              LINE 1-1 (1)            
COMMAND INPUT ===>                                            SCROLL ===> CSR  
NP   SYSNAME  SysLevel   CPU%      SIO Aux% CSA% SQA% ECSA% ESQA%   UIC Spool% 
     A153     z/OS 03.01    2        0    0   10   23    24    40 65535      0 
```
### S.LOG (System log)
- The system log is useful for showing how a job is doing, also very useful for seeing if there are any issues with other components that your job 'touches'
```
 COMMAND INPUT ===>                                            SCROLL ===> CSR  
D                                         171 00000285           Scope * Name * 
D                                         171 00000285           V=3115 W=1573 P
E                                         171 00000285           Policy 00050360
M 0100000 A153     25358 22:20:37.03 STC00006 00000285  IST530I AM GBIND PENDING
```
### S.FS (File systems)
- The File systems screen is useful for viewing information relevant to zFS file systems on the mainframe that have been mounted.
- Shows the `Path` or commonly `mountpoint` of a zFS as well as the dataset that is actually 'storing' the data itself, under the `Name` column. 
- The `Mode` column tells us whether or not we can write to the file system. When the `Mode` is `READ` the filesystem is Read Only. When the `Mode` is `RDWR` it is Read/Write, meaning that we can 'save' to the file system.
```
SDSF FILE SYSTEMS  A153     A153                       LINE 1-19 (28)          
COMMAND INPUT ===>                                            SCROLL ===> CSR  
NP   DEVICE   Path                                 Type     Mode Owner    Name 
     28       /sys/zoau                            ZFS      READ A153     OMVSS
     27       /sys/NODEJS/v22r0                    ZFS      READ A153     OMVSS
     26       /u/users/cai/sysview/runtime/cnm4h00 ZFS      READ A153     CA.SY
```
### S.NA (Network activity)
- The Network activity screen is useful for seeing the status of a job and port
- Tells if the port has been reserved (when shown on the screen it is reserved)
```
SDSF NETWORK ACTIVITY  A153     A153                   LINE 1-19 (183)         
COMMAND INPUT ===>                                            SCROLL ===> CSR  
NP   JOBNAME  Status   IPAddr                    Port InBufSz OutBufSz EXCP-Cnt
     BPXOINIT LISTEN   0.0.0.0                  10007       0        0        0
     CCITCP   LISTEN   0.0.0.0                   1202       0        0        0
     CCITCPGW LISTEN   0.0.0.0                   7000       0        0        0
```
### S.SYM (System symbols)
- Shows the System symbols defined to the system and their current values
- Static symbols are usually defined by the site
- Dynamic symbols may change from things like date, time, lpar, etc
```
SDSF SYSTEM SYMBOLS  A153     A153                     LINE 1-19 (61)          
COMMAND INPUT ===>                                            SCROLL ===> CSR  
NP   SYMBOL             Value                                        Type     S
     &DAY.              25                                           DYNAMIC  A
     &DNS1_.            192.19.189.10                                STATIC   A
     &DNS2_.            192.19.189.30                                STATIC   A
     &DOMAIN_.          MSD.LABS.BROADCOM.NET                        STATIC   A
```
### S.SMSG (SMS storage groups)
- When SMS is enabled, you will have data under SMSG
- This information is useful when creating datasets and especially during installations
```
SDSF SMS STORAGE GROUPS  A153     A153                 LINE 1-3 (3)            
COMMAND INPUT ===>                                            SCROLL ===> CSR  
NP   NAME     Type             Status           TotalMB Used% FreeMB LargestFre
     CARS     POOL             ENABLED            56839 27.42  41250         21
     SGIBM    POOL             ENABLED            48718 23.09  37468         20
     USER     POOL             ENABLED            48720 24.63  36720          6
```
### S.SMSV (SMS storage volumes)
- When SMS is enabled, you will have data under SMSV
- This information is almost like the 'details' of the SMSG screen
- Breaks down each Group and shows instead by Volume and the details
```
NP   VOLSER Status           TotalMB Used% FreeMB LargestFreeMB Device-Status
     SUBS01 ENABLED            24359 13.79  20998         20997 ONLINE       
     SUBS02 ENABLED            24359 32.38  16470         15221 ONLINE       
     UV9000 ENABLED             8120 32.79   5457          2495 ONLINE       
     UV9001 ENABLED             8120 47.69   4247          1554 ONLINE       
```
### S.CK (Health checker)
- Health checker provided by IBM and utilized by many sofware providers
- Shows Check status, last run, details, etc
```
SDSF HEALTH CHECKS  A153                               LINE 1-19 (251)         
COMMAND INPUT ===>                                            SCROLL ===> CSR  
NP   NAME                             CheckOwner       State              Statu
     ALLOC_ALLC_OFFLN_POLICY          IBMALLOC         ACTIVE(ENABLED)    SUCCE
     ALLOC_SMSHONOR_STATE             IBMALLOC         ACTIVE(ENABLED)    SUCCE
     ALLOC_SPEC_WAIT_POLICY           IBMALLOC         ACTIVE(ENABLED)    SUCCE
     ALLOC_TAPELIB_PREF               IBMALLOC         ACTIVE(DISABLED)   ENV N
```