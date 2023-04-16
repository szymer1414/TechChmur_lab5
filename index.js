const express = require('express');

const app = express();

const os = require('os');

const port = 8080;

app.get('/',(req,res) => {
    const ip = req.headers['x-forwarded-for'] || req. connection.remoteAddress;
    const hostname = os.hostname();
    const version = process.env.APP_VERSION || '19';
    res.send(`Adres IP serwera: ${ip} <br> Nazwa serwera: ${hostname} <br> Wersja aplikacji: ${version}`);
});

app.listen(8080, () => {
    console.log('Listening on port 8080');
});
