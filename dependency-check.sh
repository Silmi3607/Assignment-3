#!/bin/bash
mkdir -p reports

# Run the dependency-check tool
dependency-check --project devsecops-demo --scan . --format HTML --out ./reports
