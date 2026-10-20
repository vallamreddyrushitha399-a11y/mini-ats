# Put it on GitHub, deploy it free, record the demo

Button names on websites change now and then; if something is labelled slightly differently, pick the closest match.

## Part 1: Put the project on GitHub

1. Unzip `mini-ats.zip` (right-click, **Extract All**). You should see a folder containing `backend`, `frontend`, `README.md` and so on.
2. Sign in at https://github.com (create a free account if needed).
3. Click the **+** at the top right, then **New repository**.
4. Repository name: `mini-ats`. Choose **Public**. Do **not** tick "Add a README" or ".gitignore". Click **Create repository**.

### Easiest way: upload in the browser (no Git needed)
5. On the new empty repo page, click the **uploading an existing file** link.
6. Open the unzipped folder, select **everything inside it** (Ctrl+A) and drag it into the GitHub page. Wait for all files to appear.
7. Type the message `Initial commit` and click **Commit changes**.

### Alternative: with Git (if you installed it)
Open a terminal inside the unzipped folder and paste these (replace `YOUR-USERNAME`):
```
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/mini-ats.git
git push -u origin main
```
Before pushing, run `git status` and make sure you do not see `node_modules`, `.venv`, `.env` or any `.db` file listed.

Your **GitHub link** is `https://github.com/YOUR-USERNAME/mini-ats`.

## Part 2: Deploy for free on Render

The included `Dockerfile` builds the website and the API into one container, so you get a single link.

1. Go to https://render.com and **Sign up with GitHub**.
2. Click **+ New** (top right), then **Web Service**.
3. Pick your `mini-ats` repository (click **Configure account** to let Render see it if it is not listed).
4. Settings:
   - **Language / Runtime:** Docker (should be detected automatically from the Dockerfile)
   - **Instance Type:** **Free**
   - Under **Advanced**, set **Health Check Path** to `/api/health`
5. Click **Deploy Web Service** / **Create Web Service**. The first build takes several minutes. Watch the logs; success ends with "Your service is live".
6. Open the `https://something.onrender.com` link shown at the top. That is your **live link**.
   Also try `/docs` on the end of the link to see the API documentation.

**Free-plan behaviour to know about:**
- The service **goes to sleep after 15 minutes without visitors**. The next visit takes about a minute to wake it up.
- The free plan's disk is temporary: the SQLite database **resets** whenever the service restarts, redeploys or sleeps, and the 15 sample candidates reappear. (Locally the database is permanent.)
- So: open your live link a minute *before* recording or sharing it, and do not rely on data you add there surviving.
- Keeping data permanently on a hosted site needs a paid persistent disk or a hosted database; mention this in your submission as a known trade-off.

## Part 3: Record a 2-3 minute demo video

**Recording tool (pick one):** Windows 11 **Win + Alt + R** (Xbox Game Bar) records the active window; or **Loom** (free), or **OBS Studio**.

**What to show, in order (about 2-3 minutes):**
1. The dashboard and pipeline bar. Say what the numbers mean.
2. Search for a name or skill (for example `voice`), then clear it.
3. Click a stage filter (for example **Interview**), then **All**.
4. **+ Add candidate**: click Add with the form empty to show validation errors, then fill it in and save.
5. Change that candidate's stage from the dropdown on its card; point at the dashboard numbers updating.
6. **Edit** the candidate, then **Delete** it (show the confirmation).
7. Shrink the browser window (or open on your phone) to show the responsive layout.
8. Close by saying which tools you used: React, FastAPI, SQLite.

**Share it:** upload to YouTube as **Unlisted**, or to Google Drive and set sharing to **Anyone with the link can view**. Open the link in a private window to make sure it plays.

## Submission checklist
- [ ] GitHub repository link (public)
- [ ] Live deployed link (opened and working)
- [ ] Demo video link (plays in a private window)
- [ ] README renders on the GitHub page
