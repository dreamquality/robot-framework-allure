import os
import sys

def run_tests(dry_run=False):
    """Run Robot Framework tests with Pabot
    
    Args:
        dry_run (bool): If True, runs syntax validation only without executing tests
    """
    dry_run_flag = '--dryrun' if dry_run else ''
    command = f'pabot {dry_run_flag} --processes 4 --outputdir reports --listener allure_robotframework --loglevel DEBUG tests/'
    print(f"Running command: {command}")
    os.system(command)

if __name__ == "__main__":
    # Check for --dryrun argument
    dry_run = '--dryrun' in sys.argv
    run_tests(dry_run=dry_run)
