import express from 'express';

const configViewEngine=(app)=>{
    app.use(express.static('./src/publics'));

    app.set("view_engine","ejs");
    app.set("views","./src/views");
}

export default configViewEngine