import express from 'express';

const configViewEngine=(app)=>{
    // Static Files
    app.use(express.static('./src/publics'));
    // Set viewengine
    app.set("view_engine","ejs");
    app.set("views","./src/views");
}

export default configViewEngine