import os


def _get_and_set_env_var(env_key=None, default=None):

    env_value = os.environ.get(env_key)

    if env_value is None:

        if default is None:
            raise Exception(
                "Error: No value found for env. key: {env_key}".format(
                    env_key=env_key
                )
            )

        env_value = default
        os.environ[env_key] = env_value

    return env_value


BROWSER = _get_and_set_env_var(
    'BROWSER',
    'chrome'
)

SELENIUM_ADDRESS = _get_and_set_env_var(
    'SELENIUM_ADDRESS', 
    'http://hub-cloud.browserstack.com/wd/hub'
)

DATA_DIR = _get_and_set_env_var(
    'DATA_DIR', 
    '{base_dir}/data'.format(
        base_dir=os.getcwd()
    )
)

RESOURCE_DIR = _get_and_set_env_var(
    'RESOURCE_DIR',
    '{base_dir}/resources'.format(
        base_dir=os.getcwd()
    )
)

CLICK_SLEEP = _get_and_set_env_var(
    'CLICK_SLEEP', '5 seconds'
)

ZEBRA_HOST = _get_and_set_env_var(
    'ZEBRA_HOST',
    'www.thezebra.com'
)

ZEBRA_URL = _get_and_set_env_var(
    'ZEBRA_URL', "https://{zebra_host}".format(
        zebra_host=ZEBRA_HOST
    )
)
