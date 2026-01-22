-- Valhalla Holdings EOS Framework
-- Seed Data Migration Script
-- Run this AFTER schema.sql and AFTER creating your first user

-- =====================================================
-- IMPORTANT: Replace these UUIDs with your actual values
-- =====================================================
-- After signing up your first user, run this query to get the org_id:
-- SELECT organization_id FROM organization_members WHERE user_id = auth.uid() LIMIT 1;

-- Set your organization ID here (get it from the query above):
-- Example: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'

DO $$
DECLARE
    org_id UUID;
    joel_id UUID;
    lee_id UUID;
BEGIN
    -- Get the first organization (created automatically when first user signed up)
    SELECT id INTO org_id FROM public.organizations LIMIT 1;

    -- Get user IDs by email (or use NULL if users don't exist yet)
    SELECT id INTO joel_id FROM public.profiles WHERE LOWER(email) LIKE '%joel%' LIMIT 1;
    SELECT id INTO lee_id FROM public.profiles WHERE LOWER(email) LIKE '%lee%' LIMIT 1;

    IF org_id IS NULL THEN
        RAISE EXCEPTION 'No organization found. Please sign up a user first.';
    END IF;

    -- Update organization name
    UPDATE public.organizations SET name = 'Valhalla Holdings' WHERE id = org_id;

    -- =====================================================
    -- SCORECARD METRICS
    -- =====================================================
    INSERT INTO public.scorecard_metrics (id, organization_id, name, owner_name, goal, current, status, notes, sort_order)
    VALUES
        ('revenue-growth', org_id, 'Net revenue vs last year', 'Joel', '2% weekly', NULL, 'green', 'Handles seasonality naturally', 1),
        ('contribution-margin', org_id, 'Contribution margin after fulfilment', 'Lee', 'TBD', NULL, 'yellow', 'Needs defining - profitability metric', 2),
        ('conversion-rate', org_id, 'Conversion rate (site-wide)', 'Joel', '3%', NULL, 'green', 'Combined brands', 3),
        ('aov', org_id, 'Average order value (AOV)', 'Joel', '£50', NULL, 'green', 'Updated from £40', 4),
        ('cac', org_id, 'Paid media efficiency (Blended CAC)', 'Joel', '£15', NULL, 'green', '2029 target, allow £20 in 2026', 5),
        ('shipping', org_id, 'Orders shipped on time (%)', 'Lee', '100%', NULL, 'green', 'Operations excellence', 6),
        ('returns', org_id, 'Refund and return rate', 'Lee', '0.5%', NULL, 'green', 'Quality metric', 7),
        ('support-tickets', org_id, 'Customer support tickets per 100 orders', 'Joel', '10', NULL, 'green', 'Customer experience', 8),
        ('inventory', org_id, 'Inventory health indicator', 'Lee', '6 months', NULL, 'green', 'Supply chain health', 9),
        ('cash-runway', org_id, 'Cash runway (months)', 'Lee', '12 months', NULL, 'green', 'Financial security', 10)
    ON CONFLICT (id) DO UPDATE SET
        name = EXCLUDED.name,
        owner_name = EXCLUDED.owner_name,
        goal = EXCLUDED.goal,
        status = EXCLUDED.status,
        notes = EXCLUDED.notes,
        sort_order = EXCLUDED.sort_order;

    -- =====================================================
    -- ROCKS
    -- =====================================================
    INSERT INTO public.rocks (id, organization_id, title, owner_name, progress, status, due_date, notes, sort_order)
    VALUES
        ('rock-1', org_id, 'Team & Capacity Foundation', 'Joel', 0, 'on-track', '2026-03-31', '', 1),
        ('rock-2', org_id, 'Product Development & Launch', 'Lee', 0, 'on-track', '2026-03-31', '', 2),
        ('rock-3', org_id, 'Market Expansion - Display Champ', 'Lee', 0, 'on-track', '2026-03-31', '', 3),
        ('rock-4', org_id, 'Strategic Planning Complete', 'Joel', 0, 'on-track', '2026-03-31', '', 4),
        ('rock-5', org_id, 'Systems & Operations', 'Joel', 0, 'on-track', '2026-03-31', 'ERP implementation Q2+', 5),
        ('rock-6', org_id, 'Bright Ivy Website Optimisation', 'Lee', 0, 'on-track', '2026-03-31', '', 6)
    ON CONFLICT (id) DO UPDATE SET
        title = EXCLUDED.title,
        owner_name = EXCLUDED.owner_name,
        progress = EXCLUDED.progress,
        status = EXCLUDED.status,
        due_date = EXCLUDED.due_date,
        notes = EXCLUDED.notes,
        sort_order = EXCLUDED.sort_order;

    -- =====================================================
    -- ROCK MILESTONES
    -- =====================================================
    INSERT INTO public.rock_milestones (id, rock_id, text, completed, sort_order)
    VALUES
        -- Rock 1: Team & Capacity Foundation
        ('m1-1', 'rock-1', 'Hire Content & Brand Manager for Bright Ivy', false, 1),
        ('m1-2', 'rock-1', 'Content & Brand Manager onboarded by 31 March', false, 2),
        ('m1-3', 'rock-1', 'Production staff hired', false, 3),
        ('m1-4', 'rock-1', 'Production staff trained and ready to start Q2', false, 4),
        -- Rock 2: Product Development & Launch
        ('m2-1', 'rock-2', 'Larger case sizes launched for both brands', false, 1),
        ('m2-2', 'rock-2', 'Packaging finalised for Bright Ivy', false, 2),
        ('m2-3', 'rock-2', 'Packaging finalised for Display Champ', false, 3),
        ('m2-4', 'rock-2', '2026 product roadmap signed off', false, 4),
        ('m2-5', 'rock-2', 'Further golf product development completed', false, 5),
        -- Rock 3: Market Expansion - Display Champ
        ('m3-1', 'rock-3', 'Tennis market opened and live', false, 1),
        ('m3-2', 'rock-3', 'Baseball market opened and live', false, 2),
        ('m3-3', 'rock-3', 'Ice hockey market opened and live', false, 3),
        ('m3-4', 'rock-3', 'Cricket market opened and live', false, 4),
        ('m3-5', 'rock-3', 'First sales in each new sport vertical', false, 5),
        -- Rock 4: Strategic Planning Complete
        ('m4-1', 'rock-4', 'SEO plan signed off', false, 1),
        ('m4-2', 'rock-4', 'SEO content production started', false, 2),
        ('m4-3', 'rock-4', 'Content plan signed off', false, 3),
        ('m4-4', 'rock-4', 'Content production started', false, 4),
        -- Rock 5: Systems & Operations
        ('m5-1', 'rock-5', 'Capacity planning built', false, 1),
        ('m5-2', 'rock-5', 'Capacity reporting automated', false, 2),
        ('m5-3', 'rock-5', 'Financial reporting automation implemented', false, 3),
        ('m5-4', 'rock-5', 'ERP scoping completed', false, 4),
        -- Rock 6: Bright Ivy Website Optimisation
        ('m6-1', 'rock-6', 'Conversion rate improvements implemented', false, 1),
        ('m6-2', 'rock-6', 'Load speed optimised', false, 2),
        ('m6-3', 'rock-6', 'Checkout flow optimised', false, 3),
        ('m6-4', 'rock-6', 'Messaging optimised', false, 4)
    ON CONFLICT (id) DO UPDATE SET
        text = EXCLUDED.text,
        completed = EXCLUDED.completed,
        sort_order = EXCLUDED.sort_order;

    -- =====================================================
    -- ISSUES
    -- =====================================================
    INSERT INTO public.issues (id, organization_id, title, source, priority, status, notes, created_date)
    VALUES
        ('issue-1', org_id, 'Define Lee''s contribution margin goal for scorecard', 'scorecard', 1, 'open', '', '2026-01-22'),
        ('issue-2', org_id, 'Factory space planning for 4 UV machines by 2029', 'other', 2, 'open', 'Need to accommodate 4 UV machines + 15-16 assembly workstations', '2026-01-22'),
        ('issue-3', org_id, 'Second UV machine purchase timeline', 'other', 3, 'open', 'Need for redundancy and 2027 growth', '2026-01-22'),
        ('issue-4', org_id, 'Core values documentation', 'other', 4, 'open', 'If not already established', '2026-01-22'),
        ('issue-5', org_id, 'Accountability chart creation', 'other', 5, 'open', 'Who does what by role', '2026-01-22'),
        ('issue-6', org_id, 'International shipping cost optimisation', 'other', 6, 'open', '', '2026-01-22'),
        ('issue-7', org_id, 'B2B channel development strategy', 'other', 7, 'open', '', '2026-01-22')
    ON CONFLICT (id) DO UPDATE SET
        title = EXCLUDED.title,
        source = EXCLUDED.source,
        priority = EXCLUDED.priority,
        status = EXCLUDED.status,
        notes = EXCLUDED.notes;

    -- =====================================================
    -- TODOS
    -- =====================================================
    INSERT INTO public.todos (id, organization_id, title, owner_name, due_date, status, carried_forward_count, notes)
    VALUES
        ('todo-1', org_id, 'Begin weekly Level 10 meetings (Mondays 9:30am)', 'Joel', '2026-01-27', 'pending', 0, ''),
        ('todo-2', org_id, 'Track Q1 Rocks progress weekly (green/yellow/red status)', 'Joel', '2026-01-27', 'pending', 0, ''),
        ('todo-3', org_id, 'Build Issues List as topics arise', 'Joel', '2026-01-27', 'pending', 0, '')
    ON CONFLICT (id) DO UPDATE SET
        title = EXCLUDED.title,
        owner_name = EXCLUDED.owner_name,
        due_date = EXCLUDED.due_date,
        status = EXCLUDED.status,
        carried_forward_count = EXCLUDED.carried_forward_count,
        notes = EXCLUDED.notes;

    -- =====================================================
    -- VISION
    -- =====================================================
    INSERT INTO public.vision (organization_id, ten_year_target, ten_year_description, three_year, one_year, core_focus)
    VALUES (
        org_id,
        '2036',
        '1 million customers served annually across global markets, £50M revenue, with autonomous teams operating both businesses whilst founders provide strategic oversight only, recognised as the world''s premium memory preservation brand',
        '{
            "target": "2029",
            "revenue": "£10M",
            "customers": "200,000 annually",
            "split": {
                "brightIvy": "70% (£7M)",
                "displayChamp": "30% (£3M)"
            },
            "geography": {
                "uk": "60% (£6M)",
                "northAmerica": "17.5% (£1.75M)",
                "australia": "17.5% (£1.75M)",
                "europe": "5% (£500K)"
            },
            "team": {
                "total": "30-33 people",
                "operations": "22-25 people",
                "contentBrand": "3-4 people",
                "marketing": "2 people",
                "customerService": "1 person",
                "financeAdmin": "2 people"
            },
            "metrics": {
                "cac": "<£15",
                "repeatRate": "10% every 60 days",
                "grossMargin": "70%",
                "netMargin": "25% (£2.5M profit)",
                "cashReserves": "£3M"
            }
        }'::jsonb,
        '{
            "target": "2026",
            "revenue": "£2.1M",
            "split": {
                "brightIvy": "£1.5M (71%)",
                "displayChamp": "£600K (29%)"
            },
            "profit": {
                "grossMargin": "70% (£1.47M)",
                "netMargin": "25% (£525K)"
            },
            "quarterly": {
                "q1": "£420K (20%)",
                "q2": "£420K (20%)",
                "q3": "£420K (20%)",
                "q4": "£840K (40%)"
            },
            "goals": [
                {
                    "id": "goal-1",
                    "title": "Customer Acquisition & Retention",
                    "targets": ["Serve 42,000 customers", "Achieve 10% repeat rate every 60 days", "CAC under £20"]
                },
                {
                    "id": "goal-2",
                    "title": "Team & Capability Building",
                    "targets": ["Hire and onboard Content & Brand Manager for Bright Ivy", "Produce 50+ customer story videos across both brands", "Operations team scaled to handle 42K annual capacity"]
                },
                {
                    "id": "goal-3",
                    "title": "Market Expansion Foundation",
                    "targets": ["Launch North America - achieve £100K revenue (5%)", "Australia operational - achieve £100K revenue (5%)", "UK: £1.9M (90% of revenue)"]
                },
                {
                    "id": "goal-4",
                    "title": "Content & Marketing Engine",
                    "targets": ["Complete influencer campaigns (fossils, coins, parenting) and measure ROAS", "Google Ads: £50K spend generating 3x+ ROAS", "SEO content published for top 15 identified opportunities"]
                },
                {
                    "id": "goal-5",
                    "title": "Systems & Automation Foundations",
                    "targets": ["ERP scoped and implementation begun", "Customer story capture process systemised", "Automated reporting for key metrics (revenue, CAC, repeat rate, inventory)"]
                },
                {
                    "id": "goal-6",
                    "title": "Product & Manufacturing",
                    "targets": ["Second UV machine purchased and operational", "Laser capacity assessed for 2027 scaling needs", "Quality control processes documented"]
                },
                {
                    "id": "goal-7",
                    "title": "Geographic Revenue Distribution Achievement",
                    "targets": ["UK: 90% (£1.9M)", "North America: 5% (£100K)", "Australia: 5% (£100K)"]
                }
            ]
        }'::jsonb,
        '{
            "purpose": "Enable people to tell and display the stories that matter most to them",
            "passion": "Seeing the impact our displays have on customers'' lives through their stories and feedback",
            "niche": "Premium custom display cases that transform cherished items into conversation-starting centrepieces"
        }'::jsonb
    )
    ON CONFLICT (organization_id) DO UPDATE SET
        ten_year_target = EXCLUDED.ten_year_target,
        ten_year_description = EXCLUDED.ten_year_description,
        three_year = EXCLUDED.three_year,
        one_year = EXCLUDED.one_year,
        core_focus = EXCLUDED.core_focus;

    -- =====================================================
    -- SETTINGS
    -- =====================================================
    UPDATE public.settings
    SET
        dark_mode = false,
        meeting_day = 'Monday',
        meeting_time = '09:30',
        current_quarter = 'Q1-2026'
    WHERE organization_id = org_id;

    RAISE NOTICE 'Seed data imported successfully for organization: %', org_id;

END $$;
