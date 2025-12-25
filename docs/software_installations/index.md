# Mainframe Software Installations

- Mainframe software installations are significantly different than a typical “Windows installer”.
- In most cases, careful planning is needed and you will run into terms that are unfamiliar to newer mainframers.
- Many sites have strict requirements for dataset naming, security, and change control.

Before you start: review the general safety notes in [docs/DISCLAIMER.md](../DISCLAIMER.md).

## Installation process (high level)

Think of a mainframe software install as a lifecycle:

1. Read the manuals (release notes)
2. Verify requirements
3. Plan the install
4. Install (staging → build → deploy)
5. Verify (technical + operational)
6. Apply maintenance (ongoing)

The exact steps vary by vendor and product, but these phases show up almost everywhere.

---

## 1) Read the manuals (release notes)

Beginner note: on z/OS, “install” is usually a coordinated set of tasks across datasets, SMP/E, security (RACF/ACF2/TopSecret), started tasks, PROCLIB members, and sometimes USS (zFS) files.

What to read first:

- **Release Notes / Program Directory**: what changed, what is required, what is deprecated.
- **Installation Guide**: the steps and required dataset names.
- **Customization Guide**: which members you must tailor for your environment.
- **Migration Guide** (if upgrading): required conversions and compatibility notes.

Common phrases you’ll see:

- “**PTF**”, “**APAR**”, “**HOLDDATA**” (maintenance items)
- “**FMID**” (the product identifier used by SMP/E)
- “**Prerequisites**” / “Co-requisites” (what must be installed first)

---

## 2) Verify requirements

Goal: confirm the product can run in your environment before you allocate anything.

Typical requirement categories:

- **z/OS level** (minimum version / required service)
- **Hardware** (CPU architecture, cryptographic features, etc.)
- **Subsystems** (CICS, IMS, DB2, MQ, z/OSMF, TCP/IP)
- **Space** (DASD for libraries, logs, work datasets)
- **Security** (required user IDs, started task IDs, SAF/RACF permissions)
- **Ports / connectivity** (if it’s a networked component)
- **USS requirements** (directories, file systems, permissions)

Beginner note: “requirements” often includes *maintenance level* (specific PTFs). A product may “install” but not be supported until the prerequisite PTFs are applied.

---

## 3) Plan the install

Planning is where most success comes from.

### Decide your approach

- **New install** vs **upgrade** (in-place vs side-by-side)
- **Pilot** vs **enterprise rollout**
- **Fallback plan** (how you will back out cleanly)

### Identify datasets and libraries

You’ll typically deal with:

- **Staging datasets**: temporary datasets that hold the vendor-delivered media (for example, unloaded libraries, XMITs, or SMP/E RECEIVE input).
- **Target libraries**: the “final” libraries the product will run from (load libs, panels, messages, execs).
- **Distribution libraries**: the SMP/E “gold copy” used to build target libraries.

Beginner note: a common mental model is “**staging → distribution → target**”.

### Confirm naming standards and HLQs

- Pick an **HLQ** (high-level qualifier) that matches your site standard.
- Decide where PROCLIB members will live (system PROCLIB vs product PROCLIB).

### Security and operations planning

- Identify which **started tasks** (STCs) will run and under what IDs.
- Confirm required **permissions** (datasets, UNIX directories, SAF classes).
- Identify required **operator commands** (start/stop, display).

### Change control

- Create an install checklist and capture evidence (job output, logs).
- Plan install windows and required outages.

---

## 4) Install (staging → build → deploy)

This phase is usually the most “hands on”.

### 4a) Receive / stage the product

Common ways software arrives:

- **SMP/E package** (most classic z/OS products)
- **Terabytes of datasets** (vendor-supplied libraries you restore)
- **USS tar/zip** (modern tooling)
- **Container images** / **z/OSMF workflows** (for some products)

Beginner note: “**staging**” is just “put the delivered bits somewhere safe where you can work with them”. It’s not the final runtime location.

### 4b) If using SMP/E: RECEIVE → APPLY → ACCEPT

Very common SMP/E flow:

- **RECEIVE**: import the product/maintenance into SMP/E.
- **APPLY**: build/update the **target libraries**.
- **ACCEPT**: record the changes into the **distribution libraries**.

Beginner note: “APPLY” changes what you run; “ACCEPT” changes the long-term managed baseline.

### 4c) Customize

Typical customization work:

- Create/edit product **PARMLIB-like** members (product parameter libraries)
- Add or update **PROCLIB** procedures
- Update environment variables / USS config (if applicable)
- Configure logs, traces, and runtime datasets

### 4d) Deploy

“Deployment” on z/OS typically means:

- Pointing PROCLIB to the right procedure
- Making sure the STEPLIB / JOBLIB / LPA settings are correct
- Updating LINKLIST / LPA (only if required and approved)
- Starting the task and validating it stays up

Beginner note: “deploy” doesn’t necessarily mean copying files; it often means “making the system reference the right libraries and config”.

---

## 5) Verification

Verify at multiple levels.

### Technical verification

- Job outputs show expected return codes (RC) and no unexpected abends
- Product starts and initializes cleanly
- Version/build level matches what you intended (some products show this in messages)

### Operational verification

- Operators can start/stop it reliably
- It produces expected SMF/log records (if relevant)
- Monitoring hooks/alerts work (if you use them)

### Functional verification

- Run the vendor “smoke test”
- Validate user access and roles

Beginner note: Keep the “evidence”: job logs, SYSOUT, and config members used.

---

## 6) Applying maintenance (ongoing)

Mainframe products are usually maintained regularly.

Common maintenance terms:

- **PTF**: a fix packaged for SMP/E
- **APAR**: the problem record a fix addresses
- **HOLDDATA**: instructions/restrictions that may require manual steps
- **Service window**: planned time to apply maintenance and restart components

Good practice:

- Review holds and prerequisites before APPLY.
- Apply maintenance in a test environment first.
- Keep a record of what was applied and when.

---

## Common terminology (quick glossary)

- **CSI**: Consolidated Software Inventory (the SMP/E “database” that tracks what you have).
- **SMP/E**: System Modification Program/Extended (IBM’s standard install/maintenance tool).
- **Staging datasets**: temporary datasets holding delivered media before it’s installed.
- **Target libraries**: runtime libraries the system uses when executing the product.
- **Distribution libraries**: managed “baseline” libraries used by SMP/E.
- **HLQ**: High-level qualifier (first part of a dataset name; often identifies owner/project).
- **PROCLIB**: A library containing JCL procedures for started tasks and jobs.
- **Started task (STC)**: Long-running address space started by operator command.
- **Deployment**: making the system point to the correct libraries/config and starting the component.

If you want, tell me a specific product type (SMP/E product vs “restore libraries” vs z/OSMF workflow), and I can tailor this page with a more concrete example flow while keeping it vendor-neutral.
