# Repository Blueprint

This repository blueprint provides a standardized project structure that can be adapted for any technology stack. It includes essential development infrastructure, documentation organization, and best practices.

## What's Included

- **DevContainer Setup** - Containerized development environment for consistency
- **Documentation Structure** - Comprehensive docs organization
- **Configuration Files** - Common dot-files for various development tools
- **Project Management** - Task planning and workflow templates
- **Cursor AI Rules** - AI assistant configuration for development workflows

## Quick Start

1. Copy this blueprint to your new project directory
2. Update `README.md` with project-specific information
3. Modify `.devcontainer/devcontainer.json` for your tech stack
4. Uncomment and configure relevant sections in config files
5. Update `docs/project-management/concept.md` with your project details
6. Customize `.cursor/rules/` files for your technology stack

## Repository Structure

```
├── .devcontainer/           # Development container configuration
├── .cursor/                 # AI assistant rules and configuration
├── docs/                    # Documentation
│   ├── deployment/          # Deployment guides and configurations
│   ├── development/         # Development setup and guidelines
│   ├── project-management/  # Project planning and management
│   ├── specification/       # Requirements and technical specs
│   └── bug-reports/         # Issue tracking and bug documentation
├── config/                  # Shared configuration files
├── scripts/                 # Utility scripts
└── README.md               # This file
```

## Technology Agnostic Features

### DevContainer
- Pre-configured development environment
- Consistent setup across team members
- Portable between different host systems

### Documentation
- Structured documentation organization
- Project management templates
- Development guidelines
- Deployment documentation

### Configuration
- Common editor configurations
- Linting and formatting setup
- Git workflow standards
- CI/CD pipeline templates

### Project Management
- Task planning templates
- Definition of Done (DoD) frameworks
- Pull request templates
- Issue tracking structure

## Customization Guidelines

### For Web Applications
1. Uncomment web-specific configurations in config files
2. Add frontend/backend folder structure
3. Configure appropriate ports in devcontainer
4. Update package.json template

### For API Projects
1. Enable API-specific linting rules
2. Configure database containers if needed
3. Add API documentation structure
4. Set up testing frameworks

### For Data Projects
1. Add data-specific tooling to devcontainer
2. Configure Jupyter notebook support
3. Add data governance documentation
4. Set up data pipeline configurations

### For Mobile Applications
1. Configure mobile development tools
2. Add device testing setup
3. Update build configurations
4. Add app store deployment guides

## Best Practices

1. **Always start with planning** - Use the task planning templates
2. **Follow Git workflows** - Use feature branches and proper commit messages
3. **Document decisions** - Use the architecture decision records
4. **Test thoroughly** - Follow the testing guidelines
5. **Review before merge** - Use pull request templates

## Getting Help

- Check `docs/development/` for development guidelines
- Review `docs/project-management/` for workflow information
- Consult `.cursor/rules/` for AI assistant guidance
- See `docs/deployment/` for deployment instructions

## License

Adapt the license section based on your project's requirements. 