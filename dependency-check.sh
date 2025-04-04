#!/bin/bash
mkdir -p reports
dependency-check.sh --project devsecops-demo --scan . --format HTML --out ./reports
