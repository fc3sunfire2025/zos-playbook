# Copy a Sample Installation JCL to an Alert Central Connector z/OS Data Set
- Review the /u/maint/acc010/ACC10G0/UNZIPJCL
- We made the required changes:
- 1. SMPDIR DD
- 2. SMPJHOME DD
- 3. SMPCPATH DD
- 4. SYSIN DD
```
//CAUNZIP  JOB (00000000),'UNZIP ACC10G0',MSGCLASS=X,CLASS=A,                  
// NOTIFY=&SYSUID                                                               
//*                                                                             
//**********************************************************                    
//*                                                                             
//*    THIS ESD PACKAGE IS FOR ACC RELEASE R10                                  
//*          PRODUCT-LEVEL IDENTITY IS ACC10G0                                  
//*                                                                             
//*    BEFORE SUBMITTING THIS JOB FOR EXECUTION:                                
//*                                                                             
//*    - Edit the job card to include a valid job class,                        
//*      MSGCLASS, and accounting information.                                  
//*                                                                             
//*    - Change "yourHLQ" to a prefix for the SAMPJCL data set this             
//*      job will create.  This prefix must not match the prefix you            
//*      will use for the SMP/E installed libraries.  The length of             
//*      "yourHLQ" must not be greater than 25 characters.                      
//*                                                                             
//*    - Change "<-- YOUR USS DIRECTORY -->" to the USS directory               
//*      path where the PAX file resides.                                       
//*                                                                             
//*    - To use the default SMS class for the SAMPJCL data set, leave           
//*      volume="*' as is.                                                      
//*                                                                             
//*      To use a specific volser, change volume="*" to                         
//*      volume="packname".  We recommend that you specify a volume             
//*      for permanent retention of the SAMPJCL data set.                       
//*                                                                             
//*    - Uncomment the SMPJHOME and the SMPCPATH DD names in this JCL           
//*      only if your site does not have ICSF services installed.               
//*      The PATH names on these JAVA DD files must be set to your              
//*      sites JAVA installation names.                                         
//*                                                                             
//*          GIMUNZIP optionally requires either Integrated                     
//*          Cryptographic Services Facility (ICSF) One-Way Hash                
//*          Generate callable service or JAVA to compute a SHA-1               
//*          hash value.                                                        
//*                                                                             
//*      We suggest that you execute this JCL with these DD names               
//*      commented out and see if it executes successfully before               
//*      trying to set these DD names. HASH=NO can be specified in              
//*      the parm field which would remove the requirement of the               
//*      JAVA path statements and also ICSF. If HASH=NO is set then             
//*      there will be no additional hash value checking. We advise             
//*      that you do use the HASH=YES parameter for an additional               
//*      validation check.                                                      
//*                                                                             
//*                                                                             
//*    - The JCL will fail with a RC=12 if you uppercase any of the             
//*      GIMUNZIP commands.                                                     
//*                                                                             
//**********************************************************                    
//*                                                                             
//STEP1 EXEC PGM=GIMUNZIP,REGION=0M,PARM='HASH=YES'                             
//*                                                                             
//*SMPDIR  DD  PATH='/your/unpacked/ESD/directory/ACC10G0' <-EXAMPLE            
//*                                                                             
//SMPDIR   DD  PATH='/u/users/group/product/ACC010/ACC10G0',
//             PATHDISP=KEEP                                                    
//*                                                                             
//SMPJHOME DD PATH='/usr/lpp/java/J8.0_64/',           
//            PATHDISP=KEEP                                                    
//SMPCPATH DD PATH='/usr/lpp/smp/classes/',                          
//            PATHDISP=KEEP                                                    
//*                                                                             
//SMPOUT   DD  SYSOUT=*                                                         
//SYSPRINT DD  SYSOUT=*                                                         
//SYSUT2   DD  UNIT=SYSALLDA,SPACE=(CYL,(200,20))                               
//SYSUT3   DD  UNIT=SYSALLDA,SPACE=(CYL,(50,10))                                
//SYSUT4   DD  UNIT=SYSALLDA,SPACE=(CYL,(25,5))                                 
//SYSIN    DD  *                                                                
<GIMUNZIP>                                                                      
<ARCHDEF archid="SAMPJCL"                                                       
         newname="PRODUCT.ACC010.SAMPJCL"                        
         volume="*"                                                             
         replace="YES"                                                          
> </ARCHDEF>                                                                    
</GIMUNZIP>      
```
- 