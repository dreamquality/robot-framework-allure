
# Robot Framework Project

This project is an example of a Robot Framework test automation setup, implementing best practices including:
- Page Object Model (POM)
- Parameterization of tests
- Parallel execution with Pabot
- Integration with Allure for reporting

## Project Structure

```
robot_project/
│
├── tests/                      # Test cases directory
│   └── github/
│       └── test_github.robot   # GitHub test cases
│
├── pages/                      # Page Object files
│
├── resources/                  # Shared resources like keywords and locators
│
├── variables/                  # Global variables and configuration
│
├── reports/                    # Allure reports
│
├── logs/                       # Log files
│
├── requirements.txt            # Python dependencies
│
├── robot_settings.py           # Script to run tests
│
└── .github/workflows/          # CI configuration
```

## Setup Instructions

### 1. Install Python Dependencies

Create a virtual environment and install the required packages:

```bash
python -m venv venv
source venv/bin/activate  # On Windows, use: venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Running Tests

**Quick syntax validation (recommended first step):**
```bash
python robot_settings.py --dryrun
```

**Run full tests with browser automation:**
```bash
python robot_settings.py
```

**Alternative commands:**
```bash
# Direct robot command
robot --outputdir reports tests/

# With Pabot for parallel execution
pabot --processes 4 --outputdir reports tests/

# Syntax check only
robot --dryrun tests/
```

This will execute the tests in the `tests/` directory and save the results in the `reports/` directory.

### 3. Generating Allure Reports

To generate an Allure report after test execution, use the following command:

```bash
allure generate reports -o reports/allure-report
```

### 4. Viewing Allure Reports

To serve the Allure report in a browser, use:

```bash
allure serve reports
```

This command will start a local server and automatically open the report in your default browser.

## CI Integration

The project is set up to run tests automatically via GitHub Actions, with results being uploaded as an artifact and a Slack notification sent (if configured).

## Writing Tests

For a comprehensive guide on how to write tests for this project, see [WRITING_TESTS.md](WRITING_TESTS.md).

The guide covers:
- Project architecture and Page Object Model
- Step-by-step test creation
- Best practices and common patterns
- Troubleshooting tips
- Quick reference for common keywords

## Notes

- **FIXED**: All syntax errors that prevented the TAF from running have been resolved
- Tests now support both headless (CI) and GUI (development) browser modes
- Use `--dryrun` flag for quick syntax validation without browser automation
- Ensure that the browser drivers (e.g., ChromeDriver, GeckoDriver) are installed and available in your system's PATH
- Update the credentials and variables in the `variables/global_variables.robot` and `variables/login_data.json` files as needed
- Adjust the browser settings and other configurations in `variables/config.robot`
- See `RUNNING_TESTS.md` for detailed configuration options
- See `WRITING_TESTS.md` for a comprehensive guide on writing tests
