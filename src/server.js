//const express = require('express');
import express from 'express';
import configViewEngine from './configs/viewEngine';
import initWebRoute from './Routes/web';
import session from 'express-session';
//

require('dotenv').config();

const app = express();
const port = process.env.PORT;

//route pramas
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

//
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false }
}))

//setup view engine
configViewEngine(app);

//init web route
initWebRoute(app);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});