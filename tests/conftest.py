import logging

import pytest
import requests
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

from pages.registration_facade import RegistrationFacade

from data.users import UserCreator
from data.RegistrationTestsPath import RegistrationTestsDataPath


@pytest.fixture()
def registration_user():
    users = UserCreator.registration_users(RegistrationTestsDataPath)
    for user in users:
        if user.first_name == 'John':
            yield user


"""User_log_in_credentials() fixture to pass into session fixture (Alternative 1)"""


# @pytest.fixture()
# def user_log_in_credentials():
#     users = UserCreator.registration_users(RegistrationTestsDataPath)
#     for user in users:
#         if user.first_name == 'John':
#             credentials = dict(
#                 email=user.email,
#                 password=user.password,
#                 remember=False
#             )
#             return credentials


@pytest.fixture
def logger():
    yield logging.getLogger()


@pytest.fixture
def driver():
    options = Options()
    # options.add_argument("--headless") # Ubuntu server required option
    driver = webdriver.Chrome(options=options)
    driver.implicitly_wait(3)
    yield driver
    driver.close()


@pytest.fixture
def registration_facade(driver):
    facade = RegistrationFacade(driver)
    yield facade


'''Alternative 1 to pass user_credentials into session fixture'''

# @pytest.fixture
# def session(user_log_in_credentials):
#     session = requests.Session()
#     yield session
#     session.post(url="https://qauto2.forstudy.space/api/auth/signin", json=user_log_in_credentials)
#     session.delete(url="https://qauto2.forstudy.space/api/users")

'''Alternative 2'''


@pytest.fixture
def session(registration_user):
    session = requests.Session()
    yield session
    session.post(url="https://qauto2.forstudy.space/api/auth/signin", json={"email": registration_user.email,
                                                                            "password": registration_user.password,
                                                                            "remember": False})
    session.delete(url="https://qauto2.forstudy.space/api/users")
