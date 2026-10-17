-- Deleting a user failed with an FK violation when that user was recorded as
-- `added_by` on any group membership. `added_by` is audit-only (never read
-- back), so keep the membership and clear the attribution instead.
ALTER TABLE auth.subject_group_members
    ALTER COLUMN added_by DROP NOT NULL;

ALTER TABLE auth.subject_group_members
    DROP CONSTRAINT IF EXISTS subject_group_members_added_by_fkey,
    ADD CONSTRAINT subject_group_members_added_by_fkey
        FOREIGN KEY (added_by) REFERENCES auth.users(id) ON DELETE SET NULL;
