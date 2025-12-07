# CI Pipeline with Linting & Build - Comprehensive Notes
**Class Date:** December 7, 2025  
**Topic:** CI - Lint Detailed  
**Pipeline Type:** Two-Stage Pipeline (Lint + Build with Job Dependencies)

---

## Table of Contents
1. [Executive Summary](#executive-summary)
2. [Pipeline Overview](#pipeline-overview)
3. [Trigger Configuration](#trigger-configuration)
4. [Pipeline Structure](#pipeline-structure)
5. [Job 1: Lint](#job-1-lint)
6. [Job 2: Build](#job-2-build)
7. [Job Dependencies](#job-dependencies)
8. [Key Concepts](#key-concepts)
9. [Complete Execution Flow](#complete-execution-flow)
10. [Error Handling & Continuation](#error-handling--continuation)
11. [Tools Overview](#tools-overview)
12. [Best Practices & Improvements](#best-practices--improvements)

---

## Executive Summary

This is a **professional CI pipeline** that automates:

✓ **Multi-stage validation** - Linting multiple file types before building  
✓ **Code quality gates** - Enforces standards for JS, CSS, YAML, Markdown  
✓ **Conditional execution** - Build only happens if lint succeeds  
✓ **Artifact publishing** - Publishes build output to pipeline artifacts  

**Pipeline Flow:**
```
Developer Push to develop branch
           ↓
   Triggered Pipeline Execution
           ↓
    ┌─────LINT JOB─────┐
    │ JavaScript (Biome)
    │ CSS (Stylelint)
    │ YAML (yamllint)
    │ Markdown (markdownlint)
    └───────────────────┘
           ↓
    ┌─────BUILD JOB────┐ (depends on lint)
    │ Node Setup
    │ npm install
    │ npm run build
    │ Publish artifacts
    └───────────────────┘
           ↓
   Pipeline Complete
   (Artifacts ready for deployment)
```

---

## Pipeline Overview

### High-Level Architecture

```yaml
trigger:          # What initiates the pipeline
pool:             # Where it executes (agent configuration)
jobs:             # Parallel/sequential work units
  - job: lint     # First job (linting validation)
  - job: build    # Second job (build compilation)
```

### Key Features

| Feature | Value | Purpose |
|---------|-------|---------|
| **Trigger** | develop branch | Auto-run on feature branch pushes |
| **Pool** | Default | Uses configured agent pool |
| **Jobs** | 2 (lint, build) | Sequential pipeline stages |
| **Dependency** | build depends on lint | Build only if lint passes |
| **Error Handling** | continueOnError | Don't halt on lint failures |

---

## Trigger Configuration

### Current Configuration
```yaml
trigger: 
- develop
```

### What This Means

**Trigger Event:** Pipeline runs automatically when code is pushed to the `develop` branch

**Workflow:**
```
Developer commits code
         ↓
Push to develop branch
         ↓
GitHub/Azure Repo webhook triggered
         ↓
Azure Pipelines receives notification
         ↓
Pipeline automatically starts
```

### Alternative Trigger Configurations

```yaml
# Trigger on multiple branches
trigger:
  - main
  - develop
  - release/*

# Trigger on specific paths only (avoid unnecessary runs)
trigger:
  branches:
    include:
      - develop
    exclude:
      - docs/*
  paths:
    include:
      - src/
      - package.json
    exclude:
      - README.md

# Disable automatic triggers
trigger: none
```

### Why develop Branch?

- **Typical workflow:** 
  - Feature branches → Develop branch → Main/Release
  - CI runs on develop to catch issues early
  - Main is reserved for tested, production-ready code

---

## Pipeline Structure

### YAML Structure Breakdown

```yaml
trigger:          # ├─ Configuration
pool:             # ├─ Environment
jobs:             # └─ Work units
  - job: X        #    ├─ Job name
    displayName:  #    ├─ Human-readable label
    dependsOn:    #    ├─ Job dependencies
    steps:        #    └─ Sequential tasks
      - task:     #       ├─ Task definition
      - script:   #       └─ Inline scripts
```

### Pool Configuration

```yaml
pool: Default
```

**What is a Pool?**
- Collection of build agents
- Agents are machines that execute pipeline jobs
- Agents must have required tools (Node.js, npm, Python, etc.)

**Agent Pool Types:**
- **Default** - Uses shared organization pool
- **Self-hosted** - On-premises or organization-owned agents
- **Microsoft-hosted** - Azure-managed agents

---

## Job 1: Lint

### Overview

```yaml
- job: lint
  displayName: Lint
  steps:
    - [4 linting tasks]
```

**Purpose:** Validate code quality across multiple file types  
**Execution:** Sequential (runs all steps)  
**Failure Behavior:** `continueOnError: true` - doesn't stop pipeline

### Step 1.1: JavaScript Linting (Biome)

```yaml
- task: PowerShell@2
  continueOnError: true
  displayName: Lint JavaScript(Biome)
  inputs:
    targetType: 'inline'
    script: |
      Invoke-WebRequest -Uri "https://github.com/biomejs/biome/releases/download/%40biomejs%2Fbiome%402.3.8/biome-win32-x64.exe" -OutFile "$(Agent.ToolsDirectory)/biome.exe"
      $(Agent.ToolsDirectory)/biome.exe lint $(System.DefaultWorkingDirectory)/src/
```

#### What is Biome?

**Definition:** Fast JavaScript linter and formatter (written in Rust)  
**Purpose:** Check code style, detect errors, suggest improvements  
**Project:** Modern replacement for ESLint

#### Command Breakdown

```powershell
# Step 1: Download Biome executable
Invoke-WebRequest `
  -Uri "https://github.com/biomejs/biome/releases/download/%40biomejs%2Fbiome%402.3.8/biome-win32-x64.exe" `
  -OutFile "$(Agent.ToolsDirectory)/biome.exe"

# Step 2: Run lint against src directory
$(Agent.ToolsDirectory)/biome.exe lint $(System.DefaultWorkingDirectory)/src/
```

#### Key Points

| Component | Explanation |
|-----------|-------------|
| `continueOnError: true` | Lint errors don't fail pipeline |
| `Invoke-WebRequest` | PowerShell command to download files |
| `%40biomejs%2Fbiome%402.3.8` | URL-encoded: `@biomejs/biome@2.3.8` |
| `$(Agent.ToolsDirectory)` | Agent's tools cache directory |
| `$(System.DefaultWorkingDirectory)/src/` | Source code directory |
| `biome.exe lint` | Execute Biome linter |

#### What Biome Checks

- Unused variables
- Incorrect syntax
- Inconsistent naming conventions
- Potential bugs
- Code style violations
- Import/require issues

#### Advantages of Biome

✓ **Fast** - Written in Rust, 10x faster than ESLint  
✓ **Self-contained** - Executable, no npm dependencies  
✓ **Comprehensive** - Linter + formatter in one tool  
✓ **Zero-config** - Works with sensible defaults  

---

### Step 1.2: CSS Linting (Stylelint)

```yaml
- task: PowerShell@2
  continueOnError: true
  displayName: Lint CSS(Styelint)  
  inputs:
    targetType: 'inline'
    script: |
      npm install -g stylelint
      npm install -g stylelint-config-standard        
      stylelint $(System.DefaultWorkingDirectory)/src --config stylelint.config.mjs
```

#### What is Stylelint?

**Definition:** CSS and SCSS linter  
**Purpose:** Enforce CSS coding standards and detect errors  
**Install Method:** npm global install

#### Command Breakdown

```powershell
# Install Stylelint globally
npm install -g stylelint

# Install standard CSS configuration rules
npm install -g stylelint-config-standard

# Run linter on CSS files in src directory
stylelint $(System.DefaultWorkingDirectory)/src --config stylelint.config.mjs
```

#### Configuration

**Stylelint Configuration File:** `stylelint.config.mjs`
- ESM (ECMAScript Module) format
- Defines rules, plugins, and standards
- Located in project root typically

#### What Stylelint Checks

- Property order and grouping
- Selector specificity
- Color notation consistency
- Indentation and spacing
- CSS syntax errors
- Vendor prefix usage
- Media query organization

#### Example Configuration (typical)

```javascript
// stylelint.config.mjs
export default {
  extends: ['stylelint-config-standard'],
  rules: {
    'color-hex-length': 'short',           // #fff instead of #ffffff
    'selector-class-pattern': '^[a-z]',    // CSS class naming
    'max-nesting-depth': 3,                // Prevent deep nesting
  }
}
```

---

### Step 1.3: YAML Linting (yamllint)

```yaml
- task: PowerShell@2
  continueOnError: true
  displayName: Lint YAML(yamllint)    
  inputs:
    targetType: 'inline'
    script: |
      pip install --user yamllint
      yamllint $(System.DefaultWorkingDirectory)
```

#### What is yamllint?

**Definition:** YAML syntax and style checker  
**Purpose:** Validate Azure Pipeline YAML, Kubernetes configs, etc.  
**Install Method:** pip (Python package manager)

#### Command Breakdown

```powershell
# Install yamllint via pip (Python package manager)
pip install --user yamllint

# Lint all YAML files in workspace
yamllint $(System.DefaultWorkingDirectory)
```

#### Why YAML Validation Matters

YAML is **whitespace-sensitive** - small errors break everything

**Common YAML Issues:**
- Tabs vs spaces (spaces required)
- Incorrect indentation
- Invalid quote usage
- Duplicate keys
- Syntax errors in pipeline files

#### What yamllint Checks

✓ Correct indentation (2 or 4 spaces)  
✓ No tabs (must be spaces)  
✓ Line length limits  
✓ Proper formatting of lists and mappings  
✓ No duplicate keys  
✓ Valid structure  

#### Example Issues Caught

```yaml
# ❌ INCORRECT - Tab indentation
	key: value

# ✓ CORRECT - Space indentation
  key: value

# ❌ INCORRECT - Wrong indentation
  key: value
    nested: wrong

# ✓ CORRECT - Proper nesting
  key:
    nested: correct
```

---

### Step 1.4: Markdown Linting (markdownlint)

```yaml
- task: PowerShell@2
  continueOnError: true
  displayName: Lint Markdown(markdownlint)      
  inputs:
    targetType: 'inline'
    script: |
      npm install -g markdownlint-cli      
      markdownlint $(System.DefaultWorkingDirectory)/
```

#### What is markdownlint?

**Definition:** Markdown style checker  
**Purpose:** Enforce consistent markdown formatting  
**Install Method:** npm global install  
**Tools:** markdownlint-cli (command-line interface)

#### Command Breakdown

```powershell
# Install markdownlint CLI globally
npm install -g markdownlint-cli

# Lint all markdown files in entire workspace
markdownlint $(System.DefaultWorkingDirectory)/
```

#### Why Markdown Linting?

- **Documentation quality** - README.md, docs consistency
- **Consistency** - Same formatting across all docs
- **Rendering** - Prevents markdown rendering issues
- **Standards** - Professional documentation appearance

#### What markdownlint Checks

| Rule | Purpose |
|------|---------|
| `MD001` | Heading level progression (no skipping h1 → h3) |
| `MD003` | Heading style consistency (ATX vs Setext) |
| `MD004` | Unordered list style consistency |
| `MD005` | Inconsistent indentation in lists |
| `MD007` | Unordered list indentation |
| `MD010` | Hard tabs usage (must use spaces) |
| `MD013` | Line length |
| `MD024` | Duplicate headings |
| `MD025` | Multiple top-level headings |
| `MD029` | Ordered list numbering |

#### Example Markdown Issues

```markdown
# Heading 1

### Heading 3       <- MD001: Skips Heading 2

Paragraph

- Item 1
  - Item 1.1    <- Different indentation pattern
- Item 2
	- Item 2.1   <- Tab instead of spaces
```

---

## Job 2: Build

### Overview

```yaml
- job: build
  dependsOn: lint
  displayName: Build
  steps:
    - [Node setup, npm install, build, publish]
```

**Purpose:** Compile and package application  
**Execution:** Only runs if lint job succeeds  
**Dependency:** `dependsOn: lint`

### Job Dependency

```yaml
dependsOn: lint
```

**Meaning:** Build job waits for lint job completion

**Behavior:**
- If lint **succeeds** → Build job starts
- If lint **fails** → Build job is **skipped**
- Even with `continueOnError: true`, job completes
- Dependency checks job completion status, not error status

**Note:** In this pipeline, lint uses `continueOnError: true` on individual tasks, meaning lint job itself completes successfully even if individual lint steps fail. Build will still run.

---

### Step 2.1: Node Tool Configuration

```yaml
- task: NodeTool@0
  inputs:
    versionSource: 'spec'
    versionSpec: '16.x'
```

**Purpose:** Ensure Node.js v16 is available on agent  
**Task:** `NodeTool@0` - Official Azure Pipelines Node.js setup task  

#### Input Parameters

| Parameter | Value | Meaning |
|-----------|-------|---------|
| `versionSource` | `'spec'` | Use specified version (not latest) |
| `versionSpec` | `'16.x'` | Node.js 16 (16.0.0 to 16.99.99) |

#### Version Spec Examples

```
'16.x'      → Latest 16.x.x (16.99.99)
'16.19.x'   → Latest 16.19.x (16.19.99)
'16.19.1'   → Exact version 16.19.1
'14.x'      → Node 14
'18.x'      → Node 18 LTS
'*'         → Latest node version
```

#### Why Node Version Lock?

✓ **Consistency** - Same environment on all builds  
✓ **Reproducibility** - Can rebuild any commit with same Node  
✓ **Compatibility** - Ensures dependencies work correctly  
✓ **Stability** - Avoids breaking changes from major updates  

#### Node 16 Status

- **Released:** April 2021
- **LTS Period:** October 2021 - September 2023
- **Maintenance:** October 2023 - September 2024
- **EOL:** September 2024
- **Status (Dec 2024):** **Deprecated, consider upgrading to 18/20 LTS**

---

### Step 2.2: NPM Install

```yaml
- task: PowerShell@2
  displayName: Npm Install
  inputs:
    targetType: 'inline'
    script: 'npm install'
```

**Purpose:** Install project dependencies

#### What Happens

```
npm install
    ↓
Read package.json
    ↓
Resolve dependency tree
    ↓
Download packages from npm registry
    ↓
Create node_modules/ directory
    ↓
Generate/update package-lock.json
```

#### Process Details

**package.json** - Lists dependencies with version ranges
```json
{
  "dependencies": {
    "react": "^18.2.0",
    "axios": "~1.4.0"
  }
}
```

**npm install** - Resolves exact versions
```
react@18.2.0 (latest compatible)
axios@1.4.x (latest 1.4 version)
```

**package-lock.json** - Locks exact versions for reproducibility
```json
{
  "dependencies": {
    "react": {
      "version": "18.2.0",
      "resolved": "https://registry.npmjs.org/react/-/react-18.2.0.tgz"
    }
  }
}
```

#### Performance Notes

- **Time:** 1-5 minutes (depends on dependencies count)
- **Network:** Downloads all packages to `node_modules/`
- **Size:** Typically 200MB-1GB for medium projects
- **Caching:** Azure Pipelines can cache node_modules between runs

---

### Step 2.3: NPM Build

```yaml
- task: PowerShell@2
  displayName: Npm Run Build
  inputs:
    targetType: 'inline'
    script: 'npm run build'
```

**Purpose:** Compile and optimize source code

#### What `npm run build` Does

Executes build script from package.json:

```json
{
  "scripts": {
    "build": "react-scripts build"
  }
}
```

#### Build Process (typical React app)

```
npm run build
    ↓
Execute webpack/parcel/vite bundler
    ↓
Transpile JSX → JavaScript
    ↓
Minify code (remove whitespace/comments)
    ↓
Optimize assets (images, CSS)
    ↓
Tree-shake unused code
    ↓
Generate source maps (debugging)
    ↓
Output to build/ directory
```

#### Build Directory Structure

```
build/
├── index.html           # Main entry point
├── favicon.ico         # Website icon
├── static/
│   ├── css/
│   │   ├── main.12345.css
│   │   └── main.12345.css.map
│   ├── js/
│   │   ├── main.12345.js        # Main app code (minified)
│   │   ├── main.12345.js.map    # Debug info
│   │   └── 2.12345.js           # Async chunks
│   └── media/
│       └── logo.12345.png
└── manifest.json        # PWA metadata
```

#### Optimization Details

**Before Build (Source):**
```javascript
// Development code
const firstName = "John";
const lastName = "Doe";
const fullName = `${firstName} ${lastName}`;
console.log("User:", fullName);  // Debug only
```

**After Build (Production):**
```javascript
// Minified - one line, removed logging
var a="John",b="Doe";
```

**Benefits:**
- Smaller file size (30-50% reduction)
- Faster downloads
- Better performance
- Code obfuscation (security through obscurity)

---

### Step 2.4: Publish Pipeline Artifact

```yaml
- task: PublishPipelineArtifact@1
  inputs:
    targetPath: '$(System.DefaultWorkingDirectory)/build/'
    artifact: 'todo-ui'
    publishLocation: 'pipeline'
```

**Purpose:** Publish build output to Azure Pipelines artifact storage

#### Input Parameters

| Parameter | Value | Meaning |
|-----------|-------|---------|
| `targetPath` | `'$(System.DefaultWorkingDirectory)/build/'` | What to publish (build output) |
| `artifact` | `'todo-ui'` | Artifact name (identifier) |
| `publishLocation` | `'pipeline'` | Store in pipeline (not container registry) |

#### Build Directory Path

```
$(System.DefaultWorkingDirectory)  = /workspace/
    └── build/                     = Compiled output
        ├── index.html
        ├── static/
        │   ├── css/
        │   └── js/
        └── ...
```

#### What Gets Published

**All files** in the `build/` directory are packaged as artifact named `todo-ui`

#### Artifact Storage

**Location:** Azure Pipelines artifact repository  
**Access:** Available for:
- Downloading in subsequent pipeline runs
- Deployment tasks (release pipelines)
- Manual download from Azure DevOps UI

#### Artifact vs Container Upload

| Method | Previous Notes | This Pipeline |
|--------|---|---|
| **Container Blob** | Upload to Azure Storage Blob | `PublishPipelineArtifact` |
| **Purpose** | Long-term storage | Short-term pipeline use |
| **Duration** | Indefinite | 30 days default |
| **Access** | Via Storage Account | Via Azure DevOps |
| **Use Case** | Backup, archival | Release pipelines |

---

## Job Dependencies

### Dependency Graph

```yaml
- job: lint
  steps:
    - [Linting steps]

- job: build
  dependsOn: lint
  steps:
    - [Building steps]
```

### Execution Timeline

```
Timeline:
─────────────────────────────────────────────────

t=0s:  Pipeline starts
       Job: lint begins (in parallel if agent available)

t=30s: JavaScript lint completes
       CSS lint runs
       YAML lint runs
       Markdown lint runs

t=120s: All lint steps complete
        Job: lint completes

        Job: build condition evaluated
        ✓ lint.status = Success
        → build job is triggered

t=125s: Node setup in build job
        npm install begins

t=240s: npm install completes
        npm run build begins

t=300s: Build completes
        PublishPipelineArtifact runs

t=315s: Artifact published
        Pipeline completes ✓
```

### Dependency Behavior

**Condition:** `dependsOn: lint`

```
If lint.status == "success" → continue to build ✓
If lint.status == "failure" → skip build, pipeline fails
```

**Note:** With `continueOnError: true` on lint steps, the lint job completes successfully even if individual lint steps fail. Therefore, build will run.

### Alternative Dependency Patterns

```yaml
# Condition: Only if lint succeeds
dependsOn: lint
condition: succeeded()

# Condition: Even if lint fails
dependsOn: lint
condition: succeeded('lint')

# Multiple dependencies
dependsOn:
  - lint
  - security-scan
condition: and(succeeded('lint'), succeeded('security-scan'))

# Run even if previous failed
condition: always()
```

---

## Key Concepts

### 1. Linting vs Testing vs Building

| Activity | Purpose | Tools |
|----------|---------|-------|
| **Linting** | Code quality & style | Biome, Stylelint, yamllint, markdownlint |
| **Testing** | Verify functionality | Jest, Mocha, Cypress |
| **Building** | Compile to production | npm run build, webpack |

**Pipeline Flow:**
```
Linting (quality checks)
    ↓
Building (compilation)
    ↓
Testing (verification)
    ↓
Deployment
```

### 2. Linters and Formatters

**Linters** - Report problems
```
ESLint: "Unused variable 'x' on line 5"
```

**Formatters** - Fix automatically
```
Prettier: Rewrites code to match style
```

**This pipeline:** Uses linters (reporting only), not formatters

### 3. continueOnError

```yaml
continueOnError: true
```

**Behavior:**
- If lint step fails → Don't stop
- Log error but continue to next step
- Job still completes successfully
- Build job still runs

**Use Case:** Warnings/style issues shouldn't block pipeline

### 4. Agent Pool Capabilities

Agent must have:
✓ PowerShell (for script execution)  
✓ Node.js & npm (for JavaScript tools)  
✓ Python & pip (for yamllint)  
✓ Network access (for downloading tools)  

---

## Complete Execution Flow

### Full Pipeline Visualization

```
┌─────────────────────────────────────────────────────────┐
│ Event: Code pushed to develop branch                    │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ Pipeline Triggered                                      │
│ Agent allocated from 'Default' pool                     │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ JOB: LINT                                               │
│ ┌──────────────────────────────────────────────────┐   │
│ │ STEP 1.1: JavaScript Linting (Biome)            │   │
│ │ - Download biome.exe                            │   │
│ │ - Lint /src/ directory                          │   │
│ │ - Report issues (errors allowed to continue)    │   │
│ └──────────────────────────────────────────────────┘   │
│ ┌──────────────────────────────────────────────────┐   │
│ │ STEP 1.2: CSS Linting (Stylelint)               │   │
│ │ - npm install -g stylelint                      │   │
│ │ - npm install -g stylelint-config-standard      │   │
│ │ - Lint CSS files with config                    │   │
│ │ - Report style issues                           │   │
│ └──────────────────────────────────────────────────┘   │
│ ┌──────────────────────────────────────────────────┐   │
│ │ STEP 1.3: YAML Linting (yamllint)               │   │
│ │ - pip install --user yamllint                   │   │
│ │ - Lint entire workspace for YAML                │   │
│ │ - Validate pipeline definitions                 │   │
│ └──────────────────────────────────────────────────┘   │
│ ┌──────────────────────────────────────────────────┐   │
│ │ STEP 1.4: Markdown Linting (markdownlint)       │   │
│ │ - npm install -g markdownlint-cli               │   │
│ │ - Lint all .md files                            │   │
│ │ - Check formatting consistency                  │   │
│ └──────────────────────────────────────────────────┘   │
│                                                         │
│ Result: ✓ COMPLETED (errors logged but allowed)        │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ Dependency Check: build depends on lint                │
│ lint.status = Success ✓                                │
│ → Proceed to build job                                 │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ JOB: BUILD                                              │
│ ┌──────────────────────────────────────────────────┐   │
│ │ STEP 2.1: Node Tool Configuration               │   │
│ │ - Setup Node.js v16.x                           │   │
│ │ - Verify npm availability                       │   │
│ └──────────────────────────────────────────────────┘   │
│ ┌──────────────────────────────────────────────────┐   │
│ │ STEP 2.2: NPM Install                           │   │
│ │ - Read package.json                             │   │
│ │ - Download dependencies                         │   │
│ │ - Create node_modules/                          │   │
│ └──────────────────────────────────────────────────┘   │
│ ┌──────────────────────────────────────────────────┐   │
│ │ STEP 2.3: NPM Run Build                         │   │
│ │ - Execute build script                          │   │
│ │ - Transpile & minify source                     │   │
│ │ - Optimize assets                               │   │
│ │ - Generate /build/ directory                    │   │
│ └──────────────────────────────────────────────────┘   │
│ ┌──────────────────────────────────────────────────┐   │
│ │ STEP 2.4: Publish Pipeline Artifact             │   │
│ │ - Package /build/ directory                     │   │
│ │ - Publish as 'todo-ui' artifact                 │   │
│ │ - Available for deployment/download             │   │
│ └──────────────────────────────────────────────────┘   │
│                                                         │
│ Result: ✓ COMPLETED SUCCESSFULLY                       │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ PIPELINE SUMMARY                                        │
│ ✓ Lint job completed                                   │
│ ✓ Build job completed                                  │
│ ✓ Artifact 'todo-ui' published                         │
│ ✓ Ready for deployment                                 │
└─────────────────────────────────────────────────────────┘
```

---

## Error Handling & Continuation

### continueOnError Analysis

```yaml
- task: PowerShell@2
  continueOnError: true
  displayName: Lint JavaScript(Biome)
  inputs:
    targetType: 'inline'
    script: |
      Invoke-WebRequest -Uri "https://github.com/..."
      $(Agent.ToolsDirectory)/biome.exe lint $(System.DefaultWorkingDirectory)/src/
```

### What continueOnError Does

| Scenario | Without continueOnError | With continueOnError |
|----------|---|---|
| Lint succeeds | ✓ Continue | ✓ Continue |
| Lint fails | ✗ Stop pipeline | ✓ Continue |
| Job status | Failed | Success |

### Practical Example

**Scenario:** Biome finds 5 linting errors

**Without continueOnError:**
```
❌ Linting Error: Unused variable on line 42
Pipeline STOPS
Build job SKIPPED
Outcome: FAILED
```

**With continueOnError:**
```
⚠️ Linting Error: Unused variable on line 42
Logged and continues
CSS linting runs
YAML linting runs
Markdown linting runs
Outcome: SUCCESS (warnings logged)
Build job RUNS
```

### Why continueOnError in Linting?

**Rationale:**
- Lint errors are **warnings**, not blockers
- Code quality issues ≠ compilation errors
- Want to see **all** lint issues in one run
- Developers fix issues after CI reports them

**Analogy:**
```
Spell checker finds mistakes → Shows all → You fix them
vs
Spell checker finds 1 mistake → Stops → You see only 1

Both ways work, but showing all is better.
```

### When to Use continueOnError

✓ **Use:** Linting, code quality checks, style issues  
✗ **Don't use:** Build errors, deployment failures, critical issues

---

## Tools Overview

### Summary Table

| Tool | Type | Language | Install | Purpose |
|------|------|----------|---------|---------|
| **Biome** | Linter | JavaScript/JSX | Download exe | Fast JS linting |
| **Stylelint** | Linter | CSS/SCSS | npm | CSS style validation |
| **yamllint** | Linter | YAML | pip | YAML syntax check |
| **markdownlint** | Linter | Markdown | npm | Documentation formatting |

### Tool Comparisons

#### JavaScript: Biome vs ESLint

| Feature | Biome | ESLint |
|---------|-------|--------|
| Speed | ⚡ 10x faster | Normal |
| Language | Rust | JavaScript |
| Learning curve | Easier | More config |
| Ecosystem | Growing | Mature |
| Recommended | ✓ Modern choice | ✓ Industry standard |

#### CSS: Stylelint

| Feature | Value |
|---------|-------|
| Standard support | CSS, SCSS, Less, PostCSS |
| Plugins | Extensive |
| Share config | Yes (stylelint-config-*) |
| Auto-fix | Via stylelint-prettier integration |

#### YAML: yamllint

| Feature | Value |
|---------|-------|
| Purpose | YAML linting for all uses |
| Key use | Pipeline validation |
| Strictness | Configurable rules |
| Output | Clear error messages with line numbers |

#### Markdown: markdownlint

| Feature | Value |
|---------|-------|
| File scope | All .md files |
| Rules | 30+ predefined rules |
| Config | .markdownlintrc or inline |
| Integration | CI/CD friendly |

---

## Best Practices & Improvements

### Current Pipeline Strengths

✓ **Comprehensive linting** - Multiple file types checked  
✓ **Proper sequencing** - Lint before build  
✓ **Error tolerance** - Linting warnings don't block build  
✓ **Job dependencies** - Logical workflow  
✓ **Artifact publishing** - Builds stored for deployment  

### Recommended Improvements

#### 1. Add Build Failure Condition

**Current:** Build runs even if linting fails (warnings)  
**Recommendation:** Add explicit condition

```yaml
- job: build
  dependsOn: lint
  condition: succeeded('lint')  # Only if lint truly succeeds
  displayName: Build
```

#### 2. Artifact Versioning

**Current:** Artifact always named 'todo-ui'  
**Improvement:** Include build ID

```yaml
- task: PublishPipelineArtifact@1
  inputs:
    targetPath: '$(System.DefaultWorkingDirectory)/build/'
    artifact: 'todo-ui-$(Build.BuildId)'  # Unique per build
    publishLocation: 'pipeline'
```

#### 3. Caching Dependencies

**Current:** npm install downloads every time  
**Improvement:** Cache node_modules

```yaml
- task: CacheBeta@1
  inputs:
    key: 'npm | "$(Agent.OS)" | package-lock.json'
    restoreKeys: |
      npm | "$(Agent.OS)"
    path: '$(System.DefaultWorkingDirectory)/node_modules'
```

#### 4. Add Test Step

**Current:** No automated testing  
**Recommendation:** Add jest/vitest

```yaml
- task: PowerShell@2
  displayName: Run Tests
  inputs:
    targetType: 'inline'
    script: 'npm run test'
```

#### 5. Notifications

**Current:** No notifications on success/failure  
**Recommendation:** Add Slack/email notifications

```yaml
- task: SlackNotification@0
  inputs:
    WebhookUrl: '$(SlackWebhook)'
    Message: 'Build $(Build.BuildId) completed'
```

#### 6. Code Coverage

**Add:**
```yaml
- task: PublishCodeCoverageResults@1
  inputs:
    codeCoverageTool: cobertura
    summaryFileLocation: '$(System.DefaultWorkingDirectory)/coverage/cobertura-coverage.xml'
```

#### 7. Environment Specification

**Current:**
```yaml
pool: Default
```

**Better:**
```yaml
pool:
  name: Default
  vmImage: 'windows-latest'  # Explicit OS
```

#### 8. Timeout Configuration

**Add to prevent hung builds:**
```yaml
jobs:
- job: lint
  timeoutInMinutes: 10  # Fail if takes longer
  
- job: build
  timeoutInMinutes: 15
```

---

## Related Commands Reference

### PowerShell in Pipelines

```powershell
# Download files
Invoke-WebRequest -Uri $url -OutFile $path

# Run executables
& "path/to/executable.exe" args

# Working directory
Get-Location
Push-Location "path"
Pop-Location

# Multi-line scripts (use @" "@ or |)
$script = @"
line 1
line 2
"@
```

### npm Commands

```powershell
npm install              # Install all dependencies
npm install -g package   # Install globally
npm run build           # Execute build script
npm run test            # Execute test script
npm list               # List installed packages
npm outdated           # Show outdated packages
```

### Azure CLI Storage Commands

```powershell
# Upload (from previous notes)
az storage blob upload --account-name X --container-name Y --name Z --file path

# List
az storage blob list --account-name X --container-name Y

# Download
az storage blob download --account-name X --container-name Y --name Z --file output
```

---

## Summary

### Pipeline Purpose

This CI pipeline is a **professional-grade code quality gate** that ensures:

1. **Code Quality** - JavaScript, CSS, YAML, Markdown all validated
2. **Sequential Execution** - Linting before building prevents wasted builds
3. **Proper Artifacts** - Build output published for deployment
4. **Controlled Failure** - Linting warnings don't block builds, but are visible

### Execution Pattern

```
Developer → develop branch push
         → Trigger pipeline (automatic)
         → Lint stage (4 concurrent tasks, errors tolerated)
         → Build stage (if lint completes)
         → Publish artifacts
         → Ready for deployment
```

### Key Learnings

✓ **Linting** validates code style and quality  
✓ **Multiple linters** catch issues in different file types  
✓ **Job dependencies** create logical workflow  
✓ **continueOnError** distinguishes warnings from failures  
✓ **Artifact publishing** makes builds available for deployment  
✓ **Agent pools** centralize build resources  

### Next Steps in CI/CD

1. Add automated testing (Jest, Cypress)
2. Add security scanning (SAST, dependency checks)
3. Add code coverage measurement
4. Add release/deployment pipeline
5. Add notifications (Slack, email)
6. Add approval gates for production

---

## File Locations

**This pipeline file:** `azurepipeline.yml`  
**Configuration file:** `stylelint.config.mjs`  
**Package definitions:** `package.json`, `package-lock.json`  
**Source code:** `src/` directory  
**Build output:** `build/` directory (after npm run build)  

