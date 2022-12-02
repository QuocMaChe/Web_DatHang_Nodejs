import express from "express";
import homeController from '../Controllers/homeController';
let router=express.Router();

const initWebRoute=(app)=>{
    /* original
    router.get('/', (req,res)=>{
        res.render('index.js')
    });
    */
    router.get('/', homeController.getHomepage);
    router.get('/sign_in', homeController.getSign_in);
    router.get('/process_sign_out', homeController.processSign_out);
    router.post('/process_sign_in', homeController.processSign_in);
    router.get('/accb_food.vn', homeController.getHomepageUser);
    router.get('/accb_food.vn/admin', homeController.getHomepageAdmin);
    router.get('/accb_food.vn/doitac', homeController.getHomepageDoitac);
    router.get('/accb_food.vn/taixe', homeController.getHomepageDriver);
    router.get('/accb_food.vn/nhanvien', homeController.getHomepageNhanvien);
    //router.get('/accb_food.vn/process_add_to_cart/:id', homeController.process_add_to_cart);
    //router.get('/accb_food.vn/cart', homeController.getHomepageCart);
    return app.use('/',router);
}
export default initWebRoute;