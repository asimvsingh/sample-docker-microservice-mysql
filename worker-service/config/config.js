//  config.js
//
//  Simple application configuration. Extend as needed.
module.exports = {
	port: process.env.PORT || 8123,
  db: {
    host: process.env.DATABASE_HOST || '127.0.0.1',
    database: process.env.DATABASE_NAME || 'users',
    user: process.env.DATABASE_USER || 'users_service',
    password: process.env.DATABASE_PASSWD || '123',
    port: process.env.DATABASE_PORT || 3306
  }
};
