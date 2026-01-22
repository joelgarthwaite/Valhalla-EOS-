# Valhalla Holdings EOS Framework - Multi-User Setup Guide

This guide walks you through setting up the multi-user Supabase backend for the EOS Dashboard.

## Overview

The EOS Dashboard now supports multi-user collaboration with:
- User authentication (email/password)
- Real-time data synchronization
- Organization-based data isolation
- Offline support with automatic sync

## Prerequisites

- A Supabase account (free tier works fine)
- The EOS Dashboard files from this repository

---

## Step 1: Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and sign up/login
2. Click "New project"
3. Fill in the details:
   - **Name**: `valhalla-eos` (or any name you prefer)
   - **Database Password**: Choose a strong password (save this!)
   - **Region**: Select the closest to your location
4. Click "Create new project" and wait for it to provision (takes ~2 minutes)

---

## Step 2: Set Up the Database Schema

1. In your Supabase project, go to **SQL Editor** (left sidebar)
2. Click **New query**
3. Open the file `supabase/schema.sql` from this repository
4. Copy and paste the entire contents into the SQL Editor
5. Click **Run** (or press Cmd/Ctrl+Enter)
6. You should see "Success. No rows returned" for each statement

This creates all the necessary tables:
- `profiles` - User information
- `organizations` - Company/team groupings
- `organization_members` - Links users to organizations
- `scorecard_metrics` - Weekly KPIs
- `metric_history` - Historical metric values for sparklines
- `rocks` - Quarterly priorities
- `rock_milestones` - Milestones within rocks
- `issues` - IDS issues list
- `todos` - Weekly to-dos
- `meetings` - Level 10 meeting history
- `vision` - 10/3/1 year goals and core focus
- `settings` - Organization settings

---

## Step 3: Configure Authentication

1. Go to **Authentication** > **Providers** in Supabase
2. Ensure **Email** is enabled (it should be by default)
3. Optional: Configure additional providers (Google, GitHub, etc.)

### Email Templates (Optional)
Go to **Authentication** > **Email Templates** to customize:
- Confirmation email
- Password reset email
- Magic link email

### For Development/Testing
Go to **Authentication** > **Settings**:
- You may want to **disable email confirmation** during development
- Set "Confirm email" to OFF to allow immediate login after signup

---

## Step 4: Get Your API Credentials

1. Go to **Settings** > **API** in your Supabase project
2. You'll need two values:
   - **Project URL**: `https://xxxxxxxxxxxxx.supabase.co`
   - **anon/public** key: A long string starting with `eyJ...`

---

## Step 5: Configure the Application

1. Open `index.html` in a text editor
2. Find these lines near the top of the `<script>` section (around line 2325):

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

3. Replace with your actual values:

```javascript
const SUPABASE_URL = 'https://xxxxxxxxxxxxx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

4. Save the file

---

## Step 6: Import Existing Data (Optional)

If you want to migrate your existing EOS data:

1. First, create a user account by opening the app and signing up
2. Go to **SQL Editor** in Supabase
3. Open `supabase/seed-data.sql`
4. Copy and paste the contents
5. Click **Run**

This will populate your organization with the default Valhalla Holdings data.

---

## Step 7: Deploy (Optional)

### Option A: Local File
Simply double-click `index.html` - it works directly in the browser!

### Option B: GitHub Pages (Free)
1. Push your code to a GitHub repository
2. Go to Settings > Pages
3. Select "main" branch and click Save
4. Your site will be live at `https://yourusername.github.io/repo-name`

### Option C: Vercel/Netlify (Free)
1. Connect your GitHub repository
2. Deploy automatically on every push
3. Free SSL and custom domains

---

## Using the Application

### First User Setup
1. Open the application
2. Click "Sign up" to create an account
3. Enter your name, email, password, and company name
4. The system will automatically create:
   - Your user profile
   - Your organization
   - Default settings

### Adding Team Members
1. Have team members sign up with their own email
2. Currently, they'll get their own organization
3. To share an organization, you'll need to manually add them via Supabase:
   - Go to **Table Editor** > **organization_members**
   - Add a row with their `user_id` and your `organization_id`

### Real-Time Sync
- Changes made by any team member appear instantly for all others
- Works during Level 10 meetings for live collaboration
- Offline changes sync automatically when connection is restored

---

## Troubleshooting

### "Supabase not configured" message
- Check that you've replaced both `SUPABASE_URL` and `SUPABASE_ANON_KEY`
- Ensure the URL ends with `.supabase.co`

### Can't sign in after creating account
- If using email confirmation, check your email inbox/spam
- Or disable email confirmation in Supabase Auth settings

### Data not syncing
- Check browser console for errors
- Verify your RLS policies are set up correctly
- Ensure your user is a member of an organization

### "No organization found" error
- The automatic user creation trigger may have failed
- Manually add your user to an organization via SQL Editor:

```sql
-- Get your user ID
SELECT id FROM auth.users WHERE email = 'your@email.com';

-- Create an organization
INSERT INTO organizations (name) VALUES ('Valhalla Holdings')
RETURNING id;

-- Link user to organization (use IDs from above)
INSERT INTO organization_members (user_id, organization_id, role)
VALUES ('user-uuid-here', 'org-uuid-here', 'admin');
```

---

## Security Notes

- The `anon` key is safe to include in client-side code
- Row Level Security (RLS) ensures users only see their organization's data
- Never expose your `service_role` key in client code
- All API calls are automatically scoped to the authenticated user

---

## Cost Estimate

Supabase Free Tier includes:
- 500 MB database storage
- Unlimited API requests
- Up to 50,000 monthly active users
- Real-time subscriptions

For a small team (2-10 people), you'll stay well within free limits.

---

## Support

For issues with:
- **This application**: Check the GitHub repository issues
- **Supabase**: Visit [supabase.com/docs](https://supabase.com/docs)

---

## File Structure After Setup

```
/Valhalla Holdings EOS Framework/
├── index.html              # Main application (with Supabase config)
├── CLAUDE.md               # Claude Code documentation
├── SETUP.md                # This setup guide
├── data/
│   └── eos-data.json       # Original local data (backup)
└── supabase/
    ├── schema.sql          # Database schema
    └── seed-data.sql       # Optional data migration
```
