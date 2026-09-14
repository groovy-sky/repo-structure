infrastructure/
├── README.md
│
├── iac/                         # Infrastructure definitions
│   ├── modules/                 # Reusable IaC components
│   │   ├── network/
│   │   ├── compute/
│   │   ├── database/
│   │   ├── storage/
│   │   └── monitoring/
│   │
│   ├── environments/            # Deployed infrastructure
│   │   ├── development/
│   │   ├── staging/
│   │   └── production/
│   │
│   └── README.md
│
├── docker/                      # Reproducible tool environment
│   ├── Dockerfile
│   ├── compose.yaml
│   ├── versions.env
│   ├── entrypoint.sh
│   └── README.md
│
├── scripts_and_tools/                     # Task-oriented automation
│   ├── setup/
│   ├── validation/
│   ├── planning/
│   ├── deployment/
│   ├── maintenance/
│   ├── reporting/
│   ├── libraries/
│   └── README.md
│
├── config/                      # Shared non-secret configuration
│   ├── linting/
│   ├── security/
│   ├── logging/
│   └── examples/
│
├── docs/                        # Human-readable documentation
│   ├── getting-started/
│   ├── architecture/
│   ├── operations/
│   ├── development/
│   ├── reference/
│   ├── decisions/
│   ├── diagrams/
│   └── README.md
│
├── artifacts/                   # Generated locally; usually ignored
│   ├── plans/
│   ├── reports/
│   └── logs/
│
├── .github/
│   ├── workflows/
│   │   ├── validate.yml
│   │   ├── test.yml
│   │   ├── plan.yml
│   │   ├── apply.yml
│   │   ├── drift-detection.yml
│   │   └── build-toolbox.yml
│   ├── CODEOWNERS
│   ├── dependabot.yml
│   └── pull_request_template.md
│
├── .dockerignore
├── .gitignore
└── .env.example

