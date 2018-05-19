#!/usr/bin/env php

<?php

$envToWrite = [
    'APP_ENV',
    'APP_DEBUG',
    'APP_URL',
    'APP_KEY',
    'APP_URL_TO_EMAIL',
    'APP_CIPHER',
    'SENTRY_DSN',
    'DB_DRIVER',
    'DB_DATABASE',
    'DB_HOST',
    'DB_USERNAME',
    'DB_PASSWORD',
    'DB_ALIAS',
    'DB_LOG',
    'DB_DATABASE_2',
    'DB_HOST_2',
    'DB_USERNAME_2',
    'DB_PASSWORD_2',
    'CACHE_DRIVER',
    'S3_PROTOCOL',
    'S3_AWS_ENDPOINT',
    'S3_BUCKET',
    'S3_REGION',
    'S3_AWS_ACCESS_KEY_ID',
    'S3_AWS_SECRET_ACCESS_KEY',
    'JWT_SECRET',
    'JWT_BLACKLIST_ENABLED',
    'MAIL_DRIVER',
    'MAIL_FROM_DEFAULT',
    'MAIL_NAME_DEFAULT',
    'AWS_ACCESS_KEY_ID',
    'AWS_SECRET_ACCESS_KEY',
    'AWS_REGION',
    'AWS_CONFIG_FILE',
    'GOPUSH_URL',
    'GOPUSH_PRODUCTION',
    'APNS_TOPIC',
    'AWS_DEFAULT_REGION',
    'CDN',
    'IS_ON_AWS'
];

$envFile = "";
foreach ($envToWrite as $envKey) {
    $key = $envKey;
    $value = getenv($key);
    $envFile .= "$key=$value\n";
}

file_put_contents(getenv('APP_DIR') . '/.env', $envFile);
