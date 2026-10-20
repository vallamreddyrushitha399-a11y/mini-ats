# Mini ATS

A small Applicant Tracking System: add candidates, move them through hiring stages, search and filter them, and watch the pipeline on a live dashboard.

**Stack:** React (Vite) · FastAPI (Python) · SQLite

## Features

- Candidate **create / read / update / delete**
- **Hiring stages:** Applied → Screening → Interview → Offer → Hired / Rejected (change a stage right from the card)
- **Search** by name, email, position or skill (several words = all must match)
- **Stage filters** with live counts, plus sorting (newest, oldest, name, experience)
- **Dashboard metrics:** total, active pipeline, hired, hire rate, new this week, and a pipeline-by-stage bar
- **Form validation** in the browser *and* on the server (required fields, email/phone format, experience 0-50, duplicate emails rejected)
- **Responsive** layout (phone, tablet, desktop), keyboard friendly
- **Persistent SQLite database** (a file on disk) with **15 sample candidates** loaded on first start

## Project layout

```
mini-ats/
├── backend/            FastAPI app
│   ├── app/
│   │   ├── main.py         API routes (what the frontend calls)
│   │   ├── service.py      database + business logic
│   │   ├── validation.py   validation rules
│   │   └── schemas.py      request bodies
│   └── tests/              automated tests
├── frontend/           React app (src/ holds the code)
├── Dockerfile          builds everything into one deployable container
├── render.yaml         optional Render deploy settings
└── DEPLOY.md           GitHub + hosting + demo video steps
```

## Run it on your computer

You need these installed once: **Python 3.10+** (python.org), **Node.js 18+** (nodejs.org, choose "LTS"), and optionally **Git**.
Check them with `python --version` and `node --version` (on Mac/Linux use `python3`).

You will use **two terminal windows**: one for the backend, one for the frontend.

### Terminal 1: backend (API)

**Windows (PowerShell):**
```powershell
cd mini-ats\backend
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn app.main:app --reload
```
If PowerShell says scripts are disabled, run `Set-ExecutionPolicy -Scope Process Bypass` and activate again.

**Mac / Linux:**
```bash
cd mini-ats/backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

Leave it running. The API is at http://127.0.0.1:8000 and its interactive docs are at http://127.0.0.1:8000/docs.
The database file `backend/data/ats.db` is created automatically and filled with sample candidates.

### Terminal 2: frontend (website)

```bash
cd mini-ats/frontend
npm install
npm run dev
```

Open **http://localhost:5173** in your browser. Done!

### Optional: run as a single app (like production)

```bash
cd mini-ats/frontend
npm install
npm run build
cd ../backend
uvicorn app.main:app
```
Then open http://127.0.0.1:8000 (FastAPI now serves the built website too).

## Run the tests

```bash
# backend (inside the activated virtual environment)
cd backend
pip install -r requirements-dev.txt
pytest

# frontend
cd frontend
npm test
```

## Start over with fresh sample data

Stop the backend, delete `backend/data/ats.db`, and start it again.

## API summary

| Method | Path | What it does |
|---|---|---|
| GET | `/api/candidates?search=&stage=&sort=` | List candidates (`sort`: newest, oldest, name, experience) |
| POST | `/api/candidates` | Create a candidate |
| GET | `/api/candidates/{id}` | Get one candidate |
| PUT | `/api/candidates/{id}` | Update a candidate |
| PATCH | `/api/candidates/{id}/stage` | Change stage, body `{"stage": "Interview"}` |
| DELETE | `/api/candidates/{id}` | Delete a candidate |
| GET | `/api/dashboard` | Dashboard metrics |
| GET | `/api/stages` | List of stages |
| GET | `/api/health` | Health check |

Errors come back as JSON: `{"detail": "...", "errors": {"email": "..."}}` with status 422 (invalid), 409 (duplicate email) or 404 (not found).

## Settings (all optional)

Copy `backend/.env.example` if you want to change defaults: `ATS_DB_PATH` (database location), `ATS_SEED=0` (no sample data), `CORS_ORIGINS`.
**Never commit a real `.env` file** (it is already in `.gitignore`).

## Troubleshooting

- **`python` not found on Windows:** try `py` instead of `python`.
- **Page shows "Cannot reach the server":** the backend (Terminal 1) is not running.
- **Port already in use:** stop the other program, or start the backend with `--port 8001` and change the proxy target in `frontend/vite.config.js`.

## Deploying

See [DEPLOY.md](DEPLOY.md). Note: on Render's free plan the SQLite file is reset whenever the service restarts or sleeps, so sample data reappears. Locally the database is fully persistent.
