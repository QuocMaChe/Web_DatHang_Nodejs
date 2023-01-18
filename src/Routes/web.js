import express from "express";
import homeController from '../Controllers/homeController';
import multer from "multer";
import path from "path";
var appRoot = require('app-root-path');
//
let router = express.Router();
//
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, appRoot + '/src/publics/images/foods/');
    },

    // By default, multer removes file extensions so let's add them back
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + path.extname(file.originalname);
        cb(null, file.fieldname + '-' + uniqueSuffix);
    }
});
const imageFilter = function (req, file, cb) {
    // Accept images only
    if (!file.originalname.match(/\.(jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF)$/)) {
        req.fileValidationError = 'Only image files are allowed!';
        return cb(new Error('Only image files are allowed!'), false);
    }
    cb(null, true);
};
//
const upload = multer({ storage: storage, fileFilter: imageFilter });

const initWebRoute = (app) => {
    /* original
    router.get('/', (req,res)=>{
        res.render('index.js')
    });
    */
    router.get('/', homeController.getHomepage);
    router.get('/sign_in', homeController.getSignIn);
    router.get('/sign_up', homeController.getSignUp);
    router.get('/process_sign_out', homeController.processSignOut);
    router.post('/process_sign_in', homeController.processSignIn);
    router.get('/accb_food.vn', homeController.getHomepageUser);
    router.get('/accb_food.vn/profile', homeController.getProfilepage);
    router.get('/accb_food.vn/cart', homeController.getCartpage);
    router.get('/accb_food.vn/food_detail/id/:id', homeController.getFoodDetailpage);
    router.post('/accb_food.vn/process_order', homeController.getProcessOrderpage);
    router.post('/accb_food.vn/process_cancel_order/id/:id', homeController.getProcessCancelOrderpage);
    router.get('/accb_food.vn/order', homeController.getOrderpage);
    router.get('/accb_food.vn/addto_cart/id/:id', homeController.getAddtoCart);
    router.get('/accb_food.vn/cart/quantity/:operator/id/:id', homeController.updateQuantity);
    router.post('/sign_upUser', homeController.createNewUser)
    router.post('/accb_food.vn/search', homeController.processSearch);
    //Route of Partner============================================================================================================================================================================
    router.get('/accb_food.vn/doitac', homeController.getHomepageDoitac);
    router.get('/accb_food.vn/doitac/sign_up', homeController.getSignUpDT);
    router.get('/accb_food.vn/doitac/menu', homeController.getMenupageDT);
    router.post('/accb_food.vn/process_upload_file', upload.single('food_pic'), homeController.processUploadFile);
    router.get('/accb_food.vn/doitac/add_food/id/:id', homeController.getAddFoodDT);
    router.post('/accb_food.vn/doitac/process_add_food/id/:id',upload.single('food_pic'), homeController.getProcessAddFoodDT);
    router.get('/accb_food.vn/doitac/branch/id/:id', homeController.getBranchpageDT);
    router.get('/accb_food.vn/doitac/contract_detail', homeController.getContractDetailpageDT);
    router.get('/accb_food.vn/doitac/food_detail', homeController.getFoodDetailpageDT);
    router.get('/accb_food.vn/doitac/orders', homeController.getOrderspageDT);
    router.post('/accb_food.vn/doitac/cancel_order/id/:id', homeController.getProcessCancelOrderpageDT);
    router.get('/accb_food.vn/doitac/orders_detail', homeController.getOrdersDetailpageDT);
    router.get('/accb_food.vn/doitac/part_contracts', homeController.getPartContractspageDT);
    router.get('/accb_food.vn/doitac/renew_contract', homeController.getRenewContractpageDT);
    router.get('/accb_food.vn/doitac/shop', homeController.getShoppageDT);
    router.post('/accb_food.vn/doitac/edit_shop', homeController.getEditShoppageDT);
    router.post('/accb_food.vn/doitac/branch/xoamonan/id_mn/:id_mn', homeController.getDeletFoodBranchpageDT);
    router.post('/accb_food.vn/doitac/sign_upPartner', homeController.createrNewPartner);
    //Route of Driver=============================================================================================================================================================================
    router.get('/accb_food.vn/taixe', homeController.getHomepageDriver);
    router.post('/accb_food.vn/taixe/accept_order/id/:id', homeController.getAcceptOrderspageDriver);
    router.get('/accb_food.vn/taixe/profile', homeController.getProfilepageDriver);
    router.get('/accb_food.vn/taixe/orders_detail', homeController.getOrdersDetailpageDriver);
    router.get('/accb_food.vn/taixe/sign_up', homeController.getSignUppageDriver);
    router.get('/accb_food.vn/taixe/wallet', homeController.getWalletpageDriver);
    router.post('/accb_food.vn/taixe/edit_profile', homeController.getEditProfileDriver);
    router.post('/accb_food.vn/taixe/sign_upDriver', homeController.createrNewDriver)
    //Route of Agent==============================================================================================================================================================================
    router.get('/accb_food.vn/nhanvien', homeController.getEmployeeContractpageNhanvien);
    router.get('/accb_food.vn/nhanvien/contract_detail/id/:id', homeController.getContractDetailpageNhanvien);
    router.get('/accb_food.vn/nhanvien/employee_partner', homeController.getEmployeePartnerpageNhanvien);
    router.get('/accb_food.vn/nhanvien/profile', homeController.getProfilepageNhanvien);
    router.get('/accb_food.vn/nhanvien/notify', homeController.getNotifypageNhanvien);
    router.post('/accb_food.vn/nhanvien/edit_profile', homeController.getEditProfilepageNhanvien);
    router.post('/accb_food.vn/nhanvien/duyet_contract', homeController.getAcceptContractNhanvien);
    //Route of Admin==============================================================================================================================================================================
    router.get('/accb_food.vn/admin', homeController.getHomepageAdmin);
    router.get('/accb_food.vn/admin/add_user', homeController.getAddUserpageAdmin);
    router.get('/accb_food.vn/admin/admins', homeController.getAdminspageAdmin);
    router.get('/accb_food.vn/admin/customers', homeController.getCustomerspageAdmin);
    router.get('/accb_food.vn/admin/drivers', homeController.getDriverspageAdmin);
    router.get('/accb_food.vn/admin/edit_user', homeController.getEditUserpageAdmin);
    router.get('/accb_food.vn/admin/employees', homeController.getEmployeespageAdmin);
    router.get('/accb_food.vn/admin/list_lock', homeController.getListLockpageAdmin);
    router.get('/accb_food.vn/admin/partners', homeController.getPartnerspageAdmin);
    router.get('/accb_food.vn/admin/user_profile', homeController.getUserProfilepageAdmin);

    //Test========================================================================================================================================================================================

    //============================================================================================================================================================================================
    return app.use('/', router);
}
//
export default initWebRoute;