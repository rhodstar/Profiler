from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = os.environ.get('PROFILER_DEBUG')

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ.get('PROFILER_SECRET_KEY')

# SECURITY WARNING: define the correct hosts in production!
ALLOWED_HOSTS = os.environ.get('PROFILER_ALLOWED_HOSTS')

# PostgreSQL database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': os.environ.get('PROFILER_DATABASE_NAME'),
        'USER': os.environ.get('PROFILER_DATABASE_USER'),
        'PASSWORD': os.environ.get('PROFILER_DATABASE_PASSWORD'),
        'HOST': os.environ.get('PROFILER_DATABASE_HOST'),
        'PORT': os.environ.get('PROFILER_DATABASE_PORT'),
    }
}

try:
    from .local import *
except ImportError:
    pass
