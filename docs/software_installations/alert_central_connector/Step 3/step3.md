# Create a Product Directory for Alert Central Connector from the Pax File
- Change/Goto the directory we saved the Pax file to
```
cd /u/maint/acc010/PAX
```
- Then we will 'unpax' the Alert Central Connector Pax file
```
pax -rvf ACC.V1R0.CLASSIC.pax.Z
```
- IF you get an error similar to the following, you may have transferred the Pax file to the Mainframe using ASCII instead of Binary
```
pax: checksum error on tape (got dd87, expected 0)
```
- Otherwise you should see something similar to:
```
PROD001:/u/maint/acc010: >pax -rvf ACC.V1R0.CLASSIC.pax.Z
ACC10G0
ACC10G0/S0001.MF20.MSPS.ACC.R010BP0.ACC10G0.SAMPJCL.pax.Z
ACC10G0/SMPPTFIN
ACC10G0/SMPPTFIN/S0002.MF20.MSPS.ACC.R010BP0.ACC10G0.SMPMCS.pax.Z
ACC10G0/SMPRELF
ACC10G0/SMPRELF/MF20.MSPS.ACC.R010BP0.CAI.CACC100.F1.pax.Z
ACC10G0/SMPRELF/MF20.MSPS.ACC.R010BP0.CAI.CACC100.F2.pax.Z
ACC10G0/GIMPAF.XSL
ACC10G0/GIMPAF.XML
ACC10G0/AREADME
ACC10G0/UNZIPJCL
ACC10G0/CA.DATASET.XML
ACC10G0/CA.DEPLOYMENT.XML
ACC10G0/CA.SMPEINSTALL.XML
ACC10G0/CA.PACKAGE.XML
ACC10G0/CA.SMPESETUP.XML
```
- The tech doc ESDUNPAX sample JCL is the batch way to run the pax command
- GOTO Step 4