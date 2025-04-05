#!/bin/bash
echo "Sending email with test and dependency-check reports..."
# Example placeholder script (requires mailx or sendemail tool)
# sudo apt install mailutils -y
echo "DevSecOps Report" | mail -s "Pipeline Report" -A unit-test-report.txt -A reports/dependency-check-report.html k213607@nu.edu.pk
