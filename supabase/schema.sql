-- Valhalla Holdings EOS Framework
-- Supabase Database Schema
-- Run this in the Supabase SQL Editor to set up your database

-- =====================================================
-- USERS TABLE (extends Supabase auth.users)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    email TEXT NOT NULL,
    name TEXT NOT NULL,
    avatar_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view all profiles" ON public.profiles
    FOR SELECT USING (true);

CREATE POLICY "Users can update own profile" ON public.profiles
    FOR UPDATE USING (auth.uid() = id);

-- =====================================================
-- ORGANIZATIONS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS public.organizations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.organizations ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- ORGANIZATION MEMBERS (links users to orgs)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.organization_members (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    organization_id UUID REFERENCES public.organizations(id) ON DELETE CASCADE NOT NULL,
    role TEXT DEFAULT 'member' CHECK (role IN ('admin', 'member')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, organization_id)
);

-- Enable RLS
ALTER TABLE public.organization_members ENABLE ROW LEVEL SECURITY;

-- Members can see their own org memberships
CREATE POLICY "Users can view own memberships" ON public.organization_members
    FOR SELECT USING (auth.uid() = user_id);

-- Members can see other members of their org
CREATE POLICY "Users can view org members" ON public.organization_members
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

-- Organizations policy - users can see orgs they belong to
CREATE POLICY "Users can view their organizations" ON public.organizations
    FOR SELECT USING (
        id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

-- =====================================================
-- SCORECARD METRICS
-- =====================================================
CREATE TABLE IF NOT EXISTS public.scorecard_metrics (
    id TEXT PRIMARY KEY,
    organization_id UUID REFERENCES public.organizations(id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    owner_id UUID REFERENCES public.profiles(id),
    owner_name TEXT, -- Fallback for display
    goal TEXT,
    current TEXT,
    status TEXT DEFAULT 'green' CHECK (status IN ('green', 'yellow', 'red')),
    notes TEXT,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.scorecard_metrics ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view org metrics" ON public.scorecard_metrics
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert org metrics" ON public.scorecard_metrics
    FOR INSERT WITH CHECK (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update org metrics" ON public.scorecard_metrics
    FOR UPDATE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete org metrics" ON public.scorecard_metrics
    FOR DELETE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

-- =====================================================
-- METRIC HISTORY (for sparklines)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.metric_history (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    metric_id TEXT REFERENCES public.scorecard_metrics(id) ON DELETE CASCADE NOT NULL,
    week_date DATE NOT NULL,
    value TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(metric_id, week_date)
);

-- Enable RLS
ALTER TABLE public.metric_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view metric history" ON public.metric_history
    FOR SELECT USING (
        metric_id IN (
            SELECT id FROM public.scorecard_metrics
            WHERE organization_id IN (
                SELECT organization_id FROM public.organization_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can insert metric history" ON public.metric_history
    FOR INSERT WITH CHECK (
        metric_id IN (
            SELECT id FROM public.scorecard_metrics
            WHERE organization_id IN (
                SELECT organization_id FROM public.organization_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can update metric history" ON public.metric_history
    FOR UPDATE USING (
        metric_id IN (
            SELECT id FROM public.scorecard_metrics
            WHERE organization_id IN (
                SELECT organization_id FROM public.organization_members
                WHERE user_id = auth.uid()
            )
        )
    );

-- =====================================================
-- ROCKS (Quarterly Priorities)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.rocks (
    id TEXT PRIMARY KEY,
    organization_id UUID REFERENCES public.organizations(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    owner_id UUID REFERENCES public.profiles(id),
    owner_name TEXT,
    progress INTEGER DEFAULT 0 CHECK (progress >= 0 AND progress <= 100),
    status TEXT DEFAULT 'on-track' CHECK (status IN ('on-track', 'at-risk', 'off-track', 'complete')),
    due_date DATE,
    notes TEXT,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.rocks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view org rocks" ON public.rocks
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert org rocks" ON public.rocks
    FOR INSERT WITH CHECK (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update org rocks" ON public.rocks
    FOR UPDATE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete org rocks" ON public.rocks
    FOR DELETE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

-- =====================================================
-- ROCK MILESTONES
-- =====================================================
CREATE TABLE IF NOT EXISTS public.rock_milestones (
    id TEXT PRIMARY KEY,
    rock_id TEXT REFERENCES public.rocks(id) ON DELETE CASCADE NOT NULL,
    text TEXT NOT NULL,
    completed BOOLEAN DEFAULT FALSE,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.rock_milestones ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view rock milestones" ON public.rock_milestones
    FOR SELECT USING (
        rock_id IN (
            SELECT id FROM public.rocks
            WHERE organization_id IN (
                SELECT organization_id FROM public.organization_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can insert rock milestones" ON public.rock_milestones
    FOR INSERT WITH CHECK (
        rock_id IN (
            SELECT id FROM public.rocks
            WHERE organization_id IN (
                SELECT organization_id FROM public.organization_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can update rock milestones" ON public.rock_milestones
    FOR UPDATE USING (
        rock_id IN (
            SELECT id FROM public.rocks
            WHERE organization_id IN (
                SELECT organization_id FROM public.organization_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can delete rock milestones" ON public.rock_milestones
    FOR DELETE USING (
        rock_id IN (
            SELECT id FROM public.rocks
            WHERE organization_id IN (
                SELECT organization_id FROM public.organization_members
                WHERE user_id = auth.uid()
            )
        )
    );

-- =====================================================
-- ISSUES
-- =====================================================
CREATE TABLE IF NOT EXISTS public.issues (
    id TEXT PRIMARY KEY,
    organization_id UUID REFERENCES public.organizations(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    source TEXT DEFAULT 'other',
    priority INTEGER DEFAULT 999,
    status TEXT DEFAULT 'open' CHECK (status IN ('open', 'in-discussion', 'resolved')),
    notes TEXT,
    created_date DATE DEFAULT CURRENT_DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.issues ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view org issues" ON public.issues
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert org issues" ON public.issues
    FOR INSERT WITH CHECK (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update org issues" ON public.issues
    FOR UPDATE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete org issues" ON public.issues
    FOR DELETE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

-- =====================================================
-- TODOS
-- =====================================================
CREATE TABLE IF NOT EXISTS public.todos (
    id TEXT PRIMARY KEY,
    organization_id UUID REFERENCES public.organizations(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    owner_id UUID REFERENCES public.profiles(id),
    owner_name TEXT,
    due_date DATE,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'complete')),
    carried_forward_count INTEGER DEFAULT 0,
    notes TEXT,
    linked_issue_id TEXT REFERENCES public.issues(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.todos ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view org todos" ON public.todos
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert org todos" ON public.todos
    FOR INSERT WITH CHECK (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update org todos" ON public.todos
    FOR UPDATE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete org todos" ON public.todos
    FOR DELETE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

-- =====================================================
-- MEETINGS
-- =====================================================
CREATE TABLE IF NOT EXISTS public.meetings (
    id TEXT PRIMARY KEY,
    organization_id UUID REFERENCES public.organizations(id) ON DELETE CASCADE NOT NULL,
    date TIMESTAMPTZ NOT NULL,
    rating INTEGER CHECK (rating >= 1 AND rating <= 10),
    issues_solved INTEGER DEFAULT 0,
    todos_created INTEGER DEFAULT 0,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.meetings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view org meetings" ON public.meetings
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert org meetings" ON public.meetings
    FOR INSERT WITH CHECK (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update org meetings" ON public.meetings
    FOR UPDATE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete org meetings" ON public.meetings
    FOR DELETE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

-- =====================================================
-- VISION (One per organization)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.vision (
    organization_id UUID REFERENCES public.organizations(id) ON DELETE CASCADE PRIMARY KEY,
    ten_year_target TEXT,
    ten_year_description TEXT,
    three_year JSONB DEFAULT '{}',
    one_year JSONB DEFAULT '{}',
    core_focus JSONB DEFAULT '{}',
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.vision ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view org vision" ON public.vision
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert org vision" ON public.vision
    FOR INSERT WITH CHECK (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update org vision" ON public.vision
    FOR UPDATE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

-- =====================================================
-- SETTINGS (Per organization)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.settings (
    organization_id UUID REFERENCES public.organizations(id) ON DELETE CASCADE PRIMARY KEY,
    dark_mode BOOLEAN DEFAULT FALSE,
    meeting_day TEXT DEFAULT 'Monday',
    meeting_time TEXT DEFAULT '09:30',
    current_quarter TEXT DEFAULT 'Q1-2026',
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view org settings" ON public.settings
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert org settings" ON public.settings
    FOR INSERT WITH CHECK (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update org settings" ON public.settings
    FOR UPDATE USING (
        organization_id IN (
            SELECT organization_id FROM public.organization_members
            WHERE user_id = auth.uid()
        )
    );

-- =====================================================
-- FUNCTION: Handle new user signup
-- Creates profile and default organization
-- =====================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
DECLARE
    new_org_id UUID;
BEGIN
    -- Create profile for new user
    INSERT INTO public.profiles (id, email, name)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1))
    );

    -- Create default organization for user
    INSERT INTO public.organizations (name)
    VALUES (COALESCE(NEW.raw_user_meta_data->>'company', 'My Company'))
    RETURNING id INTO new_org_id;

    -- Add user as admin of their organization
    INSERT INTO public.organization_members (user_id, organization_id, role)
    VALUES (NEW.id, new_org_id, 'admin');

    -- Create default settings for organization
    INSERT INTO public.settings (organization_id)
    VALUES (new_org_id);

    -- Create default vision for organization
    INSERT INTO public.vision (organization_id)
    VALUES (new_org_id);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to run function on user signup
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- =====================================================
-- FUNCTION: Update updated_at timestamp
-- =====================================================
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply updated_at trigger to all tables
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_organizations_updated_at BEFORE UPDATE ON public.organizations
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_scorecard_metrics_updated_at BEFORE UPDATE ON public.scorecard_metrics
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_rocks_updated_at BEFORE UPDATE ON public.rocks
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_rock_milestones_updated_at BEFORE UPDATE ON public.rock_milestones
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_issues_updated_at BEFORE UPDATE ON public.issues
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_todos_updated_at BEFORE UPDATE ON public.todos
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_meetings_updated_at BEFORE UPDATE ON public.meetings
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_vision_updated_at BEFORE UPDATE ON public.vision
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_settings_updated_at BEFORE UPDATE ON public.settings
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- =====================================================
-- ENABLE REALTIME for all tables
-- =====================================================
ALTER PUBLICATION supabase_realtime ADD TABLE public.scorecard_metrics;
ALTER PUBLICATION supabase_realtime ADD TABLE public.metric_history;
ALTER PUBLICATION supabase_realtime ADD TABLE public.rocks;
ALTER PUBLICATION supabase_realtime ADD TABLE public.rock_milestones;
ALTER PUBLICATION supabase_realtime ADD TABLE public.issues;
ALTER PUBLICATION supabase_realtime ADD TABLE public.todos;
ALTER PUBLICATION supabase_realtime ADD TABLE public.meetings;
ALTER PUBLICATION supabase_realtime ADD TABLE public.vision;
ALTER PUBLICATION supabase_realtime ADD TABLE public.settings;

-- =====================================================
-- INDEXES for better query performance
-- =====================================================
CREATE INDEX IF NOT EXISTS idx_organization_members_user ON public.organization_members(user_id);
CREATE INDEX IF NOT EXISTS idx_organization_members_org ON public.organization_members(organization_id);
CREATE INDEX IF NOT EXISTS idx_scorecard_metrics_org ON public.scorecard_metrics(organization_id);
CREATE INDEX IF NOT EXISTS idx_metric_history_metric ON public.metric_history(metric_id);
CREATE INDEX IF NOT EXISTS idx_rocks_org ON public.rocks(organization_id);
CREATE INDEX IF NOT EXISTS idx_rock_milestones_rock ON public.rock_milestones(rock_id);
CREATE INDEX IF NOT EXISTS idx_issues_org ON public.issues(organization_id);
CREATE INDEX IF NOT EXISTS idx_todos_org ON public.todos(organization_id);
CREATE INDEX IF NOT EXISTS idx_meetings_org ON public.meetings(organization_id);
