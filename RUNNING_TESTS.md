# Robot Framework TAF - Configuration Guide

## Running Tests

### For Development (with visible browser):
Edit `variables/config.robot` and change the `BROWSER_OPTIONS` to:
```
${BROWSER_OPTIONS}    add_argument("--disable-dev-shm-usage")
```

### For CI/Headless (no visible browser):
The default configuration uses headless mode:
```
${BROWSER_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")
```

### Running Tests:
```bash
# Quick syntax check (no browser needed)
robot --dryrun tests/

# Run with browser (may take time for actual web interactions)
python robot_settings.py

# Or use robot directly
robot --outputdir reports tests/
```

## Troubleshooting

- If tests hang, ensure Chrome and ChromeDriver are installed
- Use `--dryrun` flag to validate syntax without browser automation
- Check the browser options in `variables/config.robot` for your environment