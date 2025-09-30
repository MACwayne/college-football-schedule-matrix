# Build Instructions

## Auto-Update Version from Git Commits

Every time you make changes and want to deploy, run:

```bash
./update-version.sh
git add index.html
git commit -m "Your commit message"
git push
```

Or use this one-liner workflow:

```bash
# After making your changes:
git add .
git commit -m "Your changes"
./update-version.sh
git add index.html
git commit --amend --no-edit
git push
```

## What the Script Does

The `update-version.sh` script automatically:
1. Gets the latest git commit hash (e.g., `e4f4b7a`)
2. Gets the commit date and time
3. Updates the version line in `index.html` header to:
   ```
   Build [commit-hash] • [Date] • [Time]
   ```

## Example Output

```
Build e4f4b7a • Sep 30, 2025 • 04:32 PM
```

This shows:
- **Build e4f4b7a**: The exact git commit
- **Sep 30, 2025**: Date of the commit
- **04:32 PM**: Time of the commit

## Benefits

- ✅ **Automatic**: No manual version updates needed
- ✅ **Traceable**: Each build maps directly to a git commit
- ✅ **Accurate**: Uses actual git commit timestamps
- ✅ **Simple**: Just run one script

