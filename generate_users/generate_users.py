import random
import secrets
from string import ascii_letters, digits
from typing import Iterator, Protocol, TypeAlias, NamedTuple

from faker import Faker

T_LOGIN: TypeAlias = str
T_PASSWORD: TypeAlias = str

fake = Faker()


class UserProtocol(Protocol):
    login: T_LOGIN
    password: T_PASSWORD


class User(NamedTuple):
    login: str
    password: str


def validate(users: list[UserProtocol], amount: int) -> None:
    logins = set(map(lambda user: user.login, users))
    if amount != (amount_of_logins := len(logins)):
        raise ValueError(
            f'Not enough of unique items. Required: "{amount}". Provided: "{amount_of_logins}"'
        )


def get_password():
    number_of_signs = random.randint(10, 20)
    password_values = ascii_letters + digits
    return "".join(secrets.choice(password_values) for _ in range(number_of_signs))


def get_login():
    unique_identificator = "".join(secrets.choice(ascii_letters) for _ in range(3))
    return f"{fake.first_name()}_{fake.last_name()}__{random.randint(0, 10000)}{unique_identificator}"


def generate_users(amount: int) -> Iterator[UserProtocol]:
    password_list = set()
    passwords_duplicate = 0
    login_list = set()
    logins_duplicate = 0

    while len(login_list) < amount:
        new_login = get_login()
        if new_login not in login_list:
            login_list.add(new_login)
        else:
            logins_duplicate += 1

        new_password = get_password()
        if new_password not in password_list:
            password_list.add(new_password)
        else:
            passwords_duplicate += 1

        yield User(login=new_login, password=new_password)

    print(f"Set amount: {amount}" "\n" f"Actual amount: {len(login_list)}")


def main():
    amount = 100_000
    users = list(generate_users(amount=amount))
    validate(users=users, amount=amount)


if __name__ == "__main__":
    main()
