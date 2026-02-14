---
description: Scaffolds a new feature with directory structure and boilerplate.
---

This workflow helps in creating a new feature consistently across the project.

1. Create the feature directory:
```bash
mkdir -p lib/features/[feature_name]
```
2. Create subdirectories for data, domain, and presentation:
```bash
mkdir -p lib/features/[feature_name]/data
mkdir -p lib/features/[feature_name]/domain
mkdir -p lib/features/[feature_name]/presentation/widgets
mkdir -p lib/features/[feature_name]/presentation/pages
```
3. Create a base page widget using the project's design system.
4. If needed, create a basic unit test file in `test/features/`.
5. Add the new feature entry to the main router.
