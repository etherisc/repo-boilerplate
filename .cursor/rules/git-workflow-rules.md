# Git Workflow Rules

## General Git Guidelines
- **Never push with --no-verify** - hooks must always pass
- **Never push --force** - if needed, ask for explicit approval by user
- **For administrative operations**: Use proper git commands that don't trigger hooks:
  - Delete remote branches: Use GitHub CLI `gh api --method DELETE /repos/:owner/:repo/git/refs/heads/branch-name`
  - Or delete via GitHub web interface
  - Avoid git push operations for administrative tasks when possible
  - If in doubt, **always ask the user** what to do

## Branching Strategy & Commits

### GitFlow Convention
- **Follow GitFlow**: main, develop, feature/*, release/*, hotfix/*
- **No direct commits to main or develop** - Instead, create PRs
- **Feature branches**: Always branch from develop, merge back to develop via PR
- **Release branches**: Created from develop when ready for release
- **Hotfix branches**: Created from main for urgent production fixes

### Branch Naming
- **Feature branches**: `feature/[task-number]-[short-description]`
- **Bugfix branches**: `bugfix/[issue-number]-[short-description]`
- **Hotfix branches**: `hotfix/[version]-[short-description]`
- **Release branches**: `release/[version-number]`

### Commit Standards
- **Follow Conventional Commits**: `type(scope): description`
- **Common types**: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`
- **Examples**:
  - `feat(auth): add user login functionality`
  - `fix(api): resolve validation error handling`
  - `docs(readme): update installation instructions`
- **Always rebase feature branch onto latest develop before PR**

## Pull Request Process

### PR Requirements
- PR title = Conventional Commit format summarizing change scope
- PR description must reference task ID & Definition of Done (DoD)
- Require green CI (lint, tests, build) before merge
- All conversations resolved before merge
- At least one approval from code owner (where applicable)

### PR Template
```markdown
## Description
Brief description of changes

## Task Reference
- Task ID: [task-number]
- Task Description: [brief description]

## Definition of Done
- [ ] [DoD criterion 1]
- [ ] [DoD criterion 2]
- [ ] [DoD criterion 3]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] New tests added for new functionality
- [ ] Manual testing completed

## Screenshots (if applicable)
[Add screenshots for UI changes]

## Additional Notes
[Any additional information for reviewers]
```

## Commit Message Guidelines

### Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes that affect the build system or external dependencies
- **ci**: Changes to CI configuration files and scripts
- **chore**: Other changes that don't modify src or test files
- **revert**: Reverts a previous commit

### Examples
```bash
feat(user): add user registration endpoint
fix(auth): resolve token expiration handling
docs(api): update authentication documentation
test(user): add unit tests for user service
refactor(db): optimize database query performance
```

## Branch Management

### Feature Branch Workflow
1. **Start from develop**:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/123-user-authentication
   ```

2. **Work on feature**:
   ```bash
   git add .
   git commit -m "feat(auth): implement user login"
   ```

3. **Keep branch updated**:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout feature/123-user-authentication
   git rebase develop
   ```

4. **Push and create PR**:
   ```bash
   git push origin feature/123-user-authentication
   # Create PR via web interface or CLI
   ```

5. **After merge, cleanup**:
   ```bash
   git checkout develop
   git pull origin develop
   git branch -d feature/123-user-authentication
   git push origin --delete feature/123-user-authentication
   ```

### Emergency Hotfix Workflow
1. **Start from main**:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b hotfix/1.2.1-security-fix
   ```

2. **Make fix and test**:
   ```bash
   git add .
   git commit -m "fix(security): patch XSS vulnerability"
   ```

3. **Merge to main and develop**:
   ```bash
   # Create PR to main
   # After merge, also merge to develop
   ```

## Code Review Guidelines

### For Authors
- **Self-review first**: Review your own code before creating PR
- **Small, focused PRs**: Keep changes focused and reviewable
- **Clear descriptions**: Explain what and why, not just what
- **Address feedback**: Respond to all review comments
- **Test thoroughly**: Ensure all tests pass and manual testing is complete

### For Reviewers
- **Review promptly**: Aim to review PRs within 24 hours
- **Be constructive**: Provide helpful, actionable feedback
- **Check requirements**: Verify DoD is met and requirements satisfied
- **Test locally**: Pull and test changes when appropriate
- **Approve when ready**: Don't hold up good code with minor nits

## Versioning & Tags

### Semantic Versioning
- Use semver format: `MAJOR.MINOR.PATCH`
- **MAJOR**: Breaking changes
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, backward compatible

### Tagging
- Tags are created automatically by CI/CD for releases
- Format: `v1.2.3`
- Include release notes with each tag
- Tag from main branch for production releases

## Git Hooks

### Pre-commit Hooks
- Linting and formatting checks
- Basic syntax validation
- Prevent commits to protected branches

### Pre-push Hooks
- Run test suite
- Check for merge conflicts
- Validate commit messages

### Setup
```bash
# Install pre-commit hooks (example for various tools)
# npm install husky --save-dev              # Node.js
# pip install pre-commit                    # Python
# go install github.com/pre-commit/pre-commit@latest  # Go
```

## Conflict Resolution

### Merge Conflicts
1. **Fetch latest changes**:
   ```bash
   git fetch origin
   git checkout develop
   git pull origin develop
   ```

2. **Rebase your branch**:
   ```bash
   git checkout feature/your-branch
   git rebase develop
   ```

3. **Resolve conflicts**:
   ```bash
   # Edit conflicted files
   git add resolved-file.txt
   git rebase --continue
   ```

4. **Force push if needed**:
   ```bash
   git push --force-with-lease origin feature/your-branch
   ```

## Security Considerations

### Sensitive Information
- Never commit secrets, passwords, or API keys
- Use environment variables for configuration
- Add sensitive files to .gitignore
- Use secret management tools for production

### Branch Protection
- Protect main and develop branches
- Require PR reviews
- Require status checks to pass
- Restrict direct pushes

## Troubleshooting

### Common Issues

#### "Commit rejected by hook"
- Run linting/formatting tools manually
- Fix any issues found
- Retry the commit

#### "Branch behind main"
- Fetch and rebase on latest main/develop
- Resolve any conflicts
- Force push with lease

#### "Tests failing in CI but passing locally"
- Check environment differences
- Verify dependencies are correct
- Review CI configuration

### Recovery Commands

#### Undo last commit (not pushed)
```bash
git reset --soft HEAD~1
```

#### Undo last commit (already pushed)
```bash
git revert HEAD
```

#### Reset branch to remote state
```bash
git fetch origin
git reset --hard origin/develop
```

## Best Practices

### Daily Workflow
1. Start day: `git pull origin develop`
2. Create feature branch for each task
3. Commit frequently with good messages
4. Push regularly to backup work
5. Create PR when feature is complete
6. Delete local branch after merge

### Collaboration
- Communicate about large changes
- Coordinate on shared files
- Use draft PRs for work in progress
- Tag team members for review input

### Repository Hygiene
- Delete merged branches
- Keep commit history clean
- Use meaningful branch names
- Update documentation with changes 