import os

def run_tests():
    os.system('pabot --processes 4 --outputdir reports --listener allure_robotframework --loglevel DEBUG tests/')

if __name__ == "__main__":
    run_tests()
