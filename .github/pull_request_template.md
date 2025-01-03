# Pull Request Template

## Title: 
<!-- Provide a clear and concise title for your PR (e.g., "Add new dbt model for customer segmentation") -->

---

## Description:
### Purpose and Motivation:
<!-- Why are these changes necessary? What problem are they solving? -->

### What was changed?
<!-- Describe the changes made (e.g., transformations, models, logic added/modified). -->

### Impacted Components:
<!-- Identify which data sources, tables, views, or pipelines are affected. -->

### Expected Output:
<!-- Describe the expected result of these changes (e.g., improved model performance, new data available). -->

### Assumptions or Dependencies:
<!-- Are there any assumptions or dependencies that could affect this PR? -->

---

## Change Type:
<!-- Check the box that applies to your changes. -->

- [ ] dbt model(s) modification
- [ ] Data pipeline update
- [ ] Configuration change (e.g., CDP, lead scoring, etc.)
- [ ] Schema change (e.g., table creation, column modification)
- [ ] Bug fix (data issue, calculation fix, etc.)
- [ ] Test or validation update
- [ ] Documentation update
- [ ] Other (please describe):

---

## Testing and Validation:
### Unit Tests:
<!-- Describe any automated tests that confirm the behavior of the code. -->

### Manual Verification:
<!-- Describe any manual steps taken to verify the data (e.g., running dbt models, checking output tables). -->

### Data Verification:
<!-- Confirm that the output data is correct (e.g., schema consistency, data integrity). -->

### Evidence of Successful Tests:
<!-- Attach any logs, data samples, or screenshots as evidence of successful tests. -->

---

## Documentation:
### Model, Table, and Data Pipeline Documentation:
<!-- Ensure that any new models, tables, or data sources are documented in the relevant sections (e.g., data dictionary, README). -->

### Configuration Changes:
<!-- If applicable, ensure any changes to configurations (e.g., CDP, lead scoring) are documented. -->

### Impact on Existing Documentation:
<!-- If this PR impacts existing documentation, ensure those updates are made as well. -->

---

## Related Issues or Tickets:
<!-- Reference any relevant issues or tickets related to the PR. -->

- Fixes # [issue_number]
- Closes # [issue_number]
- Related to # [issue_number]

---

## Code Quality and Best Practices:
### Coding Standards:
<!-- Ensure that the code follows the repository’s coding standards (e.g., consistent naming conventions, readable code). -->

### Modularity:
<!-- Ensure the code is modular and reusable where possible. -->

### Commented-out Code:
<!-- Ensure no commented-out code is left in the PR. Remove unnecessary debug statements. -->

### Descriptive Comments:
<!-- Add comments where needed to explain complex logic or decision-making. -->

### Error Handling:
<!-- Ensure proper error handling is implemented where appropriate. -->

---

## Performance Considerations:
### Query Optimization:
<!-- Ensure queries (especially for dbt models) are optimized for performance. -->

### Data Volume:
<!-- Ensure the solution can scale effectively with data volume. -->

### Cost Impact:
<!-- Ensure that changes do not introduce unnecessary resource consumption or cost. -->

---

## Review and Approvals:
- **Peer Review:** The PR should be reviewed by at least one team member.
- **Approval Before Merging:** The PR must be approved by the reviewer(s) before merging into the main branch.
- **Approval Criteria:** The reviewer(s) will check for:
  - Correctness of code and logic
  - Adherence to documentation and testing standards
  - No breaking changes to the existing codebase

---

### Additional Notes:
<!-- Add any other relevant information or context that reviewers should know about. -->
