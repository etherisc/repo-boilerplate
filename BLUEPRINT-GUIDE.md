# Repository Blueprint Usage Guide

This blueprint provides a complete project structure that can be adapted for any technology stack. Follow this guide to customize it for your specific project.

## Quick Start

1. **Copy the Blueprint**:
   ```bash
   cp -r docs/repo-boilerplate/* /path/to/your/new/project/
   cp -r docs/repo-boilerplate/.* /path/to/your/new/project/ 2>/dev/null || true
   ```

2. **Customize Core Files**:
   - Rename `README-template.md` to `README.md`
   - Update project name and description throughout
   - Configure `.devcontainer/` for your tech stack
   - Uncomment relevant sections in configuration files

3. **Set Up Documentation**:
   - Fill in `docs/project-management/concept.md`
   - Customize documentation structure as needed

4. **Configure Development Environment**:
   - Update `.devcontainer/devcontainer.json` for your language
   - Copy and configure `.devcontainer/env.template` to `.env`
   - Modify `.devcontainer/scripts/post-create.sh`

## Customization by Technology Stack

### Web Applications (Node.js/React/Vue/Angular)

#### DevContainer Configuration
```json
// In .devcontainer/devcontainer.json
"features": {
  "ghcr.io/devcontainers/features/node:1": {
    "version": "20",
    "installTools": false
  }
},
"forwardPorts": [3000, 3001, 5173],
"customizations": {
  "vscode": {
    "extensions": [
      "esbenp.prettier-vscode",
      "dbaeumer.vscode-eslint",
      "bradlc.vscode-tailwindcss"
    ]
  }
}
```

#### Post-Create Script
Uncomment Node.js section in `.devcontainer/scripts/post-create.sh`:
```bash
echo "📦 Setting up Node.js environment..."
curl -fsSL https://get.pnpm.io/install.sh | sh -
source ~/.bashrc
if [ -f "package.json" ]; then
    echo "Installing Node.js dependencies..."
    pnpm install
fi
```

#### Configuration Files
- Uncomment Node.js sections in `.gitignore`
- Add `package.json`, `tsconfig.json`, `vite.config.ts` etc.

### Python Applications (Django/Flask/FastAPI)

#### DevContainer Configuration
```json
"features": {
  "ghcr.io/devcontainers/features/python:1": {
    "version": "3.11"
  }
},
"forwardPorts": [8000, 5000],
"customizations": {
  "vscode": {
    "extensions": [
      "ms-python.python",
      "ms-python.pylint",
      "ms-python.black-formatter"
    ]
  }
}
```

#### Post-Create Script
```bash
echo "🐍 Setting up Python environment..."
sudo apt-get install -y python3-pip python3-venv
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi
source .venv/bin/activate
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi
```

### Go Applications

#### DevContainer Configuration
```json
"features": {
  "ghcr.io/devcontainers/features/go:1": {
    "version": "latest"
  }
},
"forwardPorts": [8080],
"customizations": {
  "vscode": {
    "extensions": [
      "golang.go"
    ]
  }
}
```

### Java Applications (Spring Boot)

#### DevContainer Configuration
```json
"features": {
  "ghcr.io/devcontainers/features/java:1": {
    "version": "17"
  }
},
"forwardPorts": [8080],
"customizations": {
  "vscode": {
    "extensions": [
      "redhat.java",
      "vscjava.vscode-java-pack"
    ]
  }
}
```

### .NET Applications

#### DevContainer Configuration
```json
"features": {
  "ghcr.io/devcontainers/features/dotnet:1": {
    "version": "8.0"
  }
},
"forwardPorts": [5000, 5001],
"customizations": {
  "vscode": {
    "extensions": [
      "ms-dotnettools.csharp"
    ]
  }
}
```

## Documentation Customization

### Project Management Documents

1. **`docs/project-management/concept.md`**:
   - Replace all `[placeholder]` text with your project details
   - Define your project vision, goals, and scope
   - Identify stakeholders and success criteria

2. **`docs/project-management/project_plan.md`**:
   - Create this file based on your project requirements
   - Use the task planning format from the blueprint

### Development Documentation

1. **`docs/development/getting-started.md`**:
   - Uncomment sections relevant to your tech stack
   - Update installation and setup instructions
   - Add project-specific configuration steps

2. **`docs/deployment/deployment-guide.md`**:
   - Configure for your deployment strategy
   - Add environment-specific instructions
   - Include monitoring and backup procedures

3. **`docs/specification/requirements.md`**:
   - Define your functional and non-functional requirements
   - Create user stories and acceptance criteria
   - Document constraints and assumptions

## File Organization Checklist

### Root Level Files
- [ ] Copy `.gitignore` and uncomment relevant sections
- [ ] Copy `.editorconfig` and customize for your languages
- [ ] Rename `README-template.md` to `README.md` and customize
- [ ] Create `.env.example` from `.devcontainer/env.template`

### DevContainer Setup
- [ ] Configure `devcontainer.json` for your tech stack
- [ ] Update `docker-compose.yml` services as needed
- [ ] Customize `post-create.sh` script
- [ ] Create `.env` file from template

### Documentation Structure
- [ ] Fill in `docs/README.md` with project-specific navigation
- [ ] Complete `docs/project-management/concept.md`
- [ ] Customize `docs/development/getting-started.md`
- [ ] Update `docs/deployment/deployment-guide.md`
- [ ] Fill in `docs/specification/requirements.md`
- [ ] Configure `docs/bug-reports/` for your issue tracking

### Cursor AI Configuration
- [ ] Review `.cursor/rules/general-coding-rules.md`
- [ ] Customize `.cursor/rules/git-workflow-rules.md`
- [ ] Add tech-specific rule files as needed

## Advanced Customizations

### Adding Database Support

1. **Update `docker-compose.yml`**:
   ```yaml
   services:
     postgres:
       image: postgres:15
       environment:
         POSTGRES_USER: devuser
         POSTGRES_PASSWORD: devpass
         POSTGRES_DB: project_dev
       ports:
         - "5432:5432"
   ```

2. **Update Environment Variables**:
   ```bash
   DATABASE_URL=postgresql://devuser:devpass@localhost:5432/project_dev
   ```

### Adding CI/CD

1. **Create `.github/workflows/ci.yml`**:
   ```yaml
   name: CI
   on: [push, pull_request]
   jobs:
     test:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v3
         - name: Setup
           # Add your setup steps
         - name: Test
           # Add your test commands
   ```

### Adding Monitoring

1. **Add Health Check Endpoints**:
   - Implement `/health` endpoint in your application
   - Add dependency health checks
   - Configure monitoring dashboards

2. **Update Deployment Documentation**:
   - Document monitoring setup
   - Add alerting configuration
   - Include troubleshooting guides

## Best Practices

### Documentation Maintenance
- Keep documentation up-to-date with code changes
- Use consistent terminology throughout
- Include code examples and screenshots
- Test all setup instructions regularly

### Development Workflow
- Follow the GitFlow branching strategy
- Use conventional commit messages
- Create detailed PR descriptions
- Maintain comprehensive test coverage

### Security Considerations
- Never commit secrets or API keys
- Use environment variables for configuration
- Regularly update dependencies
- Follow security best practices for your tech stack

## Common Customization Patterns

### Multi-Service Applications
```
├── services/
│   ├── api/
│   ├── web/
│   └── worker/
├── shared/
│   ├── types/
│   └── utils/
└── docker-compose.yml
```

### Monorepo Structure
```
├── apps/
│   ├── frontend/
│   ├── backend/
│   └── mobile/
├── packages/
│   ├── ui/
│   ├── utils/
│   └── types/
└── package.json
```

### Microservices Architecture
```
├── services/
│   ├── user-service/
│   ├── auth-service/
│   └── notification-service/
├── gateway/
├── shared/
└── k8s/
```

## Troubleshooting

### DevContainer Issues
- **Container won't start**: Check Docker is running and port conflicts
- **Dependencies fail to install**: Verify internet connection and package sources
- **VS Code extensions not loading**: Check extension compatibility with container

### Documentation Issues
- **Links not working**: Use relative paths and check file locations
- **Images not displaying**: Verify image paths and formats
- **Markdown formatting**: Use a markdown linter to check syntax

### Project Setup Issues
- **Port conflicts**: Update port mappings in devcontainer.json
- **Permission errors**: Check file ownership and permissions
- **Environment variables**: Verify .env file exists and is properly formatted

## Getting Help

- Review the original project for implementation examples
- Check the documentation sections for detailed guides
- Use the issue template in `docs/bug-reports/` for problems
- Follow the contributing guidelines for improvements

## Contributing to the Blueprint

If you find improvements or missing features:

1. Test your changes with multiple tech stacks
2. Update this guide with new patterns
3. Add examples and documentation
4. Submit improvements back to the original project

---

This blueprint is designed to save setup time and ensure consistency across projects. Customize it freely for your needs! 