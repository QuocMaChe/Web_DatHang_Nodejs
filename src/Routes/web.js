import express from "express";
import homeController from '../Controllers/homeController';
import multer from "multer";
import path from "path";
var appRoot=require('app-root-path');
//
let router=express.Router();
//
const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, appRoot+ '/src/publics/images/profile pic/');
    },

    // By default, multer removes file extensions so let's add them back
    filename: function(req, file, cb) {
        const uniqueSuffix = Date.now() + path.extname(file.originalname);
        cb(null, file.fieldname + '-' + uniqueSuffix);
    }
});
const imageFilter = function(req, file, cb) {
    // Accept images only
    if (!file.originalname.match(/\.(jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF)$/)) {
        req.fileValidationError = 'Only image files are allowed!';
        return cb(new Error('Only image files are allowed!'), false);
    }
    cb(null, true);
};
//
const upload = multer({ storage: storage, fileFilter: imageFilter });

const initWebRoute=(app)=>{
    /* original
    router.get('/', (req,res)=>{
        res.render('index.js')
    });
    */
    router.get('/', homeController.getHomepage);
    router.get('/sign_in', homeController.getSign_in);
    router.get('/sign_up', homeController.getSign_up);
    router.get('/process_sign_out', homeController.processSign_out);
    router.post('/process_sign_in', homeController.processSign_in);
    router.get('/accb_food.vn', homeController.getHomepageUser);
    router.get('/accb_food.vn/admin', homeController.getHomepageAdmin);
    router.get('/accb_food.vn/doitac', homeController.getHomepageDoitac);
    router.get('/accb_food.vn/taixe', homeController.getHomepageDriver);
    router.get('/accb_food.vn/nhanvien', homeController.getHomepageNhanvien);
    //router.get('/accb_food.vn/process_add_to_cart/:id', homeController.process_add_to_cart);
    //router.get('/accb_food.vn/cart', homeController.getHomepageCart);
    router.get('/accb_food.vn/profile', homeController.getProfilepage);
    router.post('/accb_food.vn/process_upload_file',upload.single('profile_pic'),homeController.processUpload_file);
    router.get('/test', homeController.getTest);
    router.get('/accb_food.vn/cart', homeController.getCartpage);
    router.get('/accb_food.vn/food_detail', homeController.getFoodDetailpage);
    router.get('/accb_food.vn/order', homeController.getOrderpage);
    router.get('/accb_food.vn/addto_cart/id/:id', homeController.getAddtoCart);

    return app.use('/',router);
}
//
export default initWebRoute;