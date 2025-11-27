# Genome Processing Mini-Pipeline  
_Automated directory setup, QC, trimming, integrity checks and backups_

This repository contains a small but complete collection of Bash scripts designed to create, maintain, and safeguard a reproducible RNA-seq preprocessing workflow.  
The scripts automate essential early-stage tasks: project organisation, quality control, trimming, integrity verification, and backups — forming a clean and efficient foundation for downstream bioinformatics analyses (e.g., alignment, quantification, differential expression).

---

## 📁 Repository Structure

scripts/ # All pipeline scripts
raw_data/ # Raw FASTQ.gz files (not included here)
processed_data/ # Cleaned FASTQ files after fastp
results/ # FastQC, fastp, and MultiQC reports
logs/ # Log files generated during execution
backup/ # Automatic project backups (tar.gz)

yaml
Copy code

---

## Overview of the Scripts

### **1. `create_script.sh` — Project Directory Setup**  
Creates a reproducible and clean directory architecture for the entire workflow.

**Key features:**  
- Builds all necessary subfolders (`raw_data`, `processed_data`, `results`, `logs`, `scripts`)  
- Ensures the project starts organised and transparent  
- Essential for scalability and collaboration  

---

### **2. `runqc_script.sh` — Batch QC + Trimming Pipeline**  
Full preprocessing pipeline for paired-end FASTQ files.

**What it does:**  
- Runs **FastQC** on all samples  
- Cleans reads with **fastp** (adapter trimming, quality filtering, length filtering)  
- Generates HTML/JSON fastp reports  
- Collates everything with **MultiQC**  
- Creates detailed log files for every run  
- Fully automated for all `_R1`/`_R2` FASTQ pairs in `raw_data/`

**Parameters:**  
- Threads  
- Quality threshold  
- Minimum read length  

The script is easily customisable for different datasets or computational needs.

---

### **3. `checksums_script.sh` — Data Integrity Verification**  
Generates **MD5** and **SHA-256** checksums for all FASTQ.gz files.

**Purpose:**  
- Ensures that raw data are not corrupted during transfer or storage  
- Allows future integrity verification  
- Stores timestamped checksum records under `logs/`  

This is a crucial step for scientific reproducibility and long-term data storage.

---

### **4. `backup_script.sh` — Full Project Backup**  
Creates a timestamped `.tar.gz` archive of the entire project directory.

**Why it matters:**  
- Protects against data loss, accidental deletion, or disk failure  
- Ensures a stable snapshot of the project at any point in time  
- Logs backup activity for reference and auditing  

---

## Requirements

To use the pipeline, ensure the following tools are installed:

- `conda tools_qc`
- `bash`
- `fastqc`
- `fastp`
- `multiqc`
- `tar`
- `md5sum` and `sha256sum`

Example on Debian/Ubuntu:

```bash
sudo apt install fastqc fastp multiqc
How to Run the Pipeline
1. Clone the repository:
bash
Copy code
git clone https://github.com/USERNAME/REPOSITORY.git
cd REPOSITORY/scripts

2. Make scripts executable:
bash
Copy code
Running the scripts:
You do **not** need to make the scripts executable.
> These scripts are designed to run directly with `bash`, which ensures consistent behavior across systems and avoids permission-related issues.
```bash
bash create_script.sh
bash runqc_script.sh
bash checksums_script.sh
bash backup_script.sh

3. Set up the directory structure:
bash
Copy code
./create_script.sh

4. Add your FASTQ.gz files to raw_data/. Files must end with _r1_fastq.gz and _r2_fastq.gz.

5. Run the QC + trimming pipeline:
bash
Copy code
./runqc_script.sh

6. Generate checksums:
bash
Copy code
./checksums_script.sh

7. Create a backup:
bash
Copy code
./backup_script.sh

Workflow Summary
css
Copy code
[ Script 1 ] → Set up project structure
        ↓
[ Script 3 ] → Verify raw data integrity
        ↓
[ Script 2 ] → QC, trimming, cleaning, MultiQC
        ↓
[ Script 4 ] → Full backup and preservation
This forms a minimal but robust foundation for RNA-seq bioinformatics analysis.

Reproducibility & Good Practices
This project follows key principles of reproducible bioinformatics:

Organisation: clearly defined folder structure

Automation: repeated tasks handled programmatically

Integrity checks: protect datasets from silent corruption

Logging: every run is documented

Version control: repository maintained with Git and GitHub

License
This project is open-source. You may reuse or adapt the scripts following good scientific citation practices.
Author
Developed by Raquel Gomes,
FCUL — Bioinformatics & Computational Biology student.
<img width="468" height="643" alt="image" src="https://github.com/user-attachments/assets/e76603cf-9526-4541-a7ac-9ac490921d3e" />
