<h2>TSA Claims Analysis (Midterm Project — SAS)</h2>

<p>
  This repository contains SAS code developed for a Business Analytics Modeling midterm project
  analyzing TSA claims data (2002–2017). The program imports the dataset, cleans key fields,
  flags date issues, and produces summary outputs and optional PDF reporting.
</p>

<div style="background:#f3f4f6;padding:8px 12px;border-left:5px solid #2563eb;margin:18px 0 10px 0;">
  <strong>Tools</strong>
</div>
<p><strong>SAS</strong> • Data Cleaning • PROC FREQ • PROC MEANS • ODS PDF</p>

<div style="background:#f3f4f6;padding:8px 12px;border-left:5px solid #16a34a;margin:18px 0 10px 0;">
  <strong>What the code does</strong>
</div>
<ul>
  <li>Imports TSAClaims2002_2017.csv (dataset not included in repo)</li>
  <li>Removes duplicates and standardizes key categorical fields</li>
  <li>Flags rows with missing/out-of-range dates (2002–2017)</li>
  <li>Generates summary outputs (overall + state-filtered)</li>
  <li>Optionally exports results to a PDF report via ODS</li>
</ul>

<div style="background:#f3f4f6;padding:8px 12px;border-left:5px solid #7c3aed;margin:18px 0 10px 0;">
  <strong>Files</strong>
</div>
<ul>
  <li><code>/notebooks/tsa_claims_midterm_analysis.sas</code> – SAS program</li>
</ul>

<p style="font-size:13px;color:#6b7280;">
  Note: The raw dataset is not uploaded to this repository. Update the <code>DATA_PATH</code> and <code>OUTPUT_PDF</code>
  variables in the SAS program to run locally.
</p>
