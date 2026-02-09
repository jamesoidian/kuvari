---
name: git
description: Git conventions and commit message standards.
---

# Git Conventions

## Commit Messages
- Use clear, descriptive commit messages in Finnish or English (be consistent).
- Prefix messages with their intent when relevant:
  - `feat:` for new features
  - `fix:` for bug fixes
  - `chore:` for maintenance or configuration changes
  - `security:` for vulnerability fixes
- Example: `fix: update iOS deployment target to 15.0`

## Ignored Files
- Always ensure `google-services.json` and `GoogleService-Info.plist` are in `.gitignore`.
- If accidentally tracked, use `git rm --cached` to stop tracking them without deleting from disk.
