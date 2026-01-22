# Valhalla Holdings EOS Framework

## Project Overview

A single-page EOS (Entrepreneurial Operating System) dashboard for Valhalla Holdings, built as a standalone HTML file with embedded CSS and JavaScript. The dashboard helps track quarterly rocks, scorecard metrics, issues, to-dos, vision/goals, and Level 10 meetings.

**Now supports multi-user collaboration via Supabase!**

## Live Deployment

- **Live URL:** https://joelgarthwaite.github.io/Valhalla-EOS-/
- **GitHub Repo:** https://github.com/joelgarthwaite/Valhalla-EOS-
- **Supabase Project ID:** aovoergyztmyegzedurx
- **Supabase Dashboard:** https://supabase.com/dashboard/project/aovoergyztmyegzedurx
- **Organization ID:** 3ec49d66-29ff-41e1-9f8d-129a037d67bd

### Current Users
- Joel (joel@displaychamp.com)
- Lee

## Technology Stack

- **Single HTML file** (`index.html`) - No build process required
- **Vanilla JavaScript** - No frameworks
- **CSS Variables** - Dark/light mode support
- **Supabase** - Backend as a Service (optional, for multi-user)
- **LocalStorage** - Data persistence backup (offline support)
- **JSON Data** - `data/eos-data.json` for initial/fallback data

## How to Run

### Local-Only Mode (Default)
**Simply double-click `index.html`** - it works directly in browser without a server.
Data persists via localStorage.

### Multi-User Mode (Supabase)
See `SETUP.md` for detailed instructions. Quick overview:
1. Create a free Supabase project
2. Run `supabase/schema.sql` in SQL Editor
3. Update `SUPABASE_URL` and `SUPABASE_ANON_KEY` in `index.html`
4. Open in browser and sign up

## File Structure

```
/Valhalla Holdings EOS Framework/
├── index.html              # Main application (all HTML, CSS, JS)
├── CLAUDE.md               # This documentation file
├── SETUP.md                # Multi-user setup guide
├── data/
│   └── eos-data.json       # Initial/fallback data
└── supabase/
    ├── schema.sql          # Database schema for Supabase
    └── seed-data.sql       # Data migration script
```

## Features Implemented

### Core Pages
- **Dashboard** - Overview with stats, focus items, scorecard snapshot, rocks progress
- **Scorecard** - 10 weekly metrics with status, inline value editing, sparklines
- **Rocks** - Q1 quarterly priorities with milestones, progress tracking
- **Issues** - Drag-and-drop prioritized list, IDS workflow
- **To-Dos** - Weekly commitments with owner, due date, carried-forward tracking
- **Vision** - 10-year, 3-year, 1-year goals and Core Focus

### Level 10 Meeting Mode
- Full meeting flow with timer (Segue -> Scorecard -> Rocks -> Headlines -> To-Dos -> IDS -> Conclude)
- Meeting rating (1-10) saved to history

### Multi-User Features (Added Jan 2026)

1. **User Authentication**
   - Email/password sign up and sign in
   - User profiles with name and avatar
   - Logout functionality

2. **Organization-Based Data**
   - Each user belongs to an organization
   - All data is scoped to the organization
   - Row-level security ensures data isolation

3. **Real-Time Sync**
   - Changes sync instantly across all connected users
   - Perfect for collaborative Level 10 meetings
   - See who made changes via toast notifications

4. **Offline Support**
   - App works offline via localStorage
   - Changes sync automatically when reconnected
   - Visual indicator shows sync status

5. **User Interface**
   - Login/signup screens
   - User info in sidebar footer
   - Sync status indicator
   - Offline warning banner

### Editing Capabilities (Added Jan 2026)

1. **Enhanced Rock Editing Modal**
   - Edit title, notes/description, owner, due date, status
   - Add/edit/delete milestones inline
   - Delete rock with confirmation
   - Click pencil button on rock cards

2. **Scorecard Metric Editing**
   - Edit metric name, goal, owner, notes
   - Click pencil button on metric rows

3. **Vision Editing Mode**
   - Toggle Edit/Save button in Vision page header
   - Edit Core Focus, 10-Year Target, 3-Year Picture, 1-Year Plan

4. **Weekly Data Entry Modal**
   - "+ Add Week" button on Scorecard page
   - Bulk entry for all metric values
   - Saves to history for sparkline display

### Meeting History Page (Added Jan 2026)
- Navigation: Meeting section -> Meeting History
- Stats: Total meetings, average rating, issues solved, to-dos created
- Visual rating trend chart
- Full meeting history list with details

### Dashboard Enhancements (Added Jan 2026)
- Shows all 10 scorecard metrics (scrollable)
- Average meeting rating stat card
- Rock notes displayed on cards when present

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| D | Dashboard |
| S | Scorecard |
| R | Rocks |
| I | Issues |
| T | To-Dos |
| V | Vision |
| H | Meeting History |
| M | Start Meeting |
| N | New item (context-aware) |
| Esc | Close modals/exit meeting |

## Data Structure

### Local Mode (eos-data.json / localStorage)

```json
{
  "meta": { "version", "lastUpdated", "currentQuarter" },
  "scorecard": { "metrics": [...] },
  "rocks": [...],
  "issues": [...],
  "todos": [...],
  "meetings": [...],
  "vision": { "tenYear", "threeYear", "oneYear", "coreFocus" },
  "settings": { "darkMode", "meetingDay", "meetingTime" }
}
```

### Multi-User Mode (Supabase)

```
Tables:
- profiles (user info)
- organizations (company/team)
- organization_members (user -> org mapping)
- scorecard_metrics (KPIs)
- metric_history (sparkline data)
- rocks (quarterly priorities)
- rock_milestones (milestones)
- issues (IDS list)
- todos (weekly commitments)
- meetings (L10 history)
- vision (goals and focus)
- settings (preferences)
```

## Configuration

### Supabase Credentials
Located at the top of the `<script>` section in `index.html`:

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

If not configured, the app runs in local-only mode.

## Known Limitations

- Team member sharing requires manual database entry (for now)
- No password reset UI (use Supabase dashboard)
- No user profile editing UI

## Future Enhancement Ideas

- Team member invitation flow
- User profile editing
- Password reset UI
- Export/import functionality
- Meeting notes/minutes storage
- Accountability chart page
- Core values page
- Process documentation page
- Mobile-responsive design improvements
