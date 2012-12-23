require("coffee-script");

var app = require("./app"),
    fs = require('fs'),
    appConfig = JSON.parse(fs.readFileSync(__dirname + '/config/app.json', 'UTF-8')),
    cluster = require("cluster"),
    mongo = require("mongodb"),
    db = new mongo.Db(appConfig.db.name, new mongo.Server(appConfig.db.host, appConfig.db.port, appConfig.db.options));




