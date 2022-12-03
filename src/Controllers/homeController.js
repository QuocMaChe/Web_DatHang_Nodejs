import {pool} from "../configs/connectDB";
import multer from 'multer';

let getHomepage =async (req,res)=>{
    let data_foods=[];
    if(req.session.user){
        return res.redirect('/accb_food.vn');
    }
    else if(req.session.admin){
        return res.redirect('/accb_food.vn/admin');
    }
    else if(req.session.driver){
        return res.redirect('/accb_food.vn/taixe');
    }
    else if(req.session.agent){
        return res.redirect('/accb_food.vn/nhanvien');
    }
    else if(req.session.partner){
        return res.redirect('/accb_food.vn/doitac');
    }
    else{
        try {
            await pool.connect();
            // Foods
            let foods = await pool.request().query('select * from MONAN')
            data_foods=foods.recordset;

            return res.render('index.ejs',{
                dataFoods: data_foods
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
}
//
let getSign_in=(req,res)=>{
    return res.render('sign_in.ejs')
}
//
let getHomepageUser= async (req,res)=>{
    if(req.session.user){
        let data_foods=[];
        let data_partners=[];
        let data_orderforms=[];
        let data_orderforms_situation=[];
        let data_menus=[];
        try {
            await pool.connect();
            // Food
            let foods = await pool.request().query('select * from MONAN')
            data_foods=foods.recordset;
            // Partner
            let partners = await pool.request().query('select * from DOITAC')
            data_partners=partners.recordset;
            // Menu
            let menus = await pool.request().query('select * from THUCDON')
            data_menus=menus.recordset;
            // Order form của khách hàng
            let order_forms = await pool.request().query('select * from DONHANG')
            data_orderforms=order_forms.recordset;
            // Order form situation
            let order_forms_situation = await pool.request().query('select * from TINHTRANGGIAOHANG')
            data_orderforms_situation=order_forms_situation.recordset;


            return res.render('user.ejs',{
                dataUser: req.session.user,
                dataFoods: data_foods,
                dataMenus: data_menus,
                dataPartners: data_partners,
                dataOrderForms: data_orderforms,
                dataOrderFormsSituation: data_orderforms_situation
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else{
        return res.redirect('/');
    }
}
//
let getHomepageAdmin= async (req,res)=>{
    if(req.session.admin){
        let data_drivers=[];
        let data_users=[];
        let data_agents=[];
        let data_partners=[];
        try {
            await pool.connect();
            // Driver
            let drivers = await pool.request().query('select * from TAIXE')
            data_drivers=drivers.recordset;
            // User
            let users = await pool.request().query('select * from KHACHHANG')
            data_users=users.recordset;
            // Agent
            let agents = await pool.request().query('select * from NHANVIEN')
            data_agents=agents.recordset;
            // Partner
            let partners = await pool.request().query('select * from DOITAC')
            data_partners=partners.recordset;

            return res.render('admin.ejs',{
                dataAdmin: req.session.admin,
                dataDrivers: data_drivers,
                dataUsers: data_users,
                dataAgents: data_agents,
                dataPartners: data_partners
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else{
        return res.redirect('/');
    }   
}
//
let getHomepageDriver= async (req,res)=>{
    if(req.session.driver){
        let data_orderforms_situation=[];
        try {
            await pool.connect();
            // Order form situation
            let order_forms_situation = await pool.request().query('select * from TINHTRANGGIAOHANG')
            data_orderforms_situation=order_forms_situation.recordset;

            return res.render('driver.ejs',{
                dataDriver: req.session.driver,
                dataOrderFormSituation: data_orderforms_situation
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else{
        return res.redirect('/')
    }
}
//
let getHomepageDoitac= async (req,res)=>{
    if(req.session.partner){
        let data_contracts=[];
        let data_stores=[];
        let data_orderforms=[];
        let data_orderforms_situation=[];
        let data_menus=[];
        let data_foods=[];
        try {
            await pool.connect();
            // Contracts
            let contracts = await pool.request().query('select * from HOPDONG')
            data_contracts=contracts.recordset;
            // Store
            let stores = await pool.request().query('select * from CUAHANG')
            data_stores=stores.recordset;
            // Order form
            let order_forms = await pool.request().query('select * from DONHANG')
            data_orderforms=order_forms.recordset;
            // Order form situation
            let order_forms_situation = await pool.request().query('select * from TINHTRANGGIAOHANG')
            data_orderforms_situation=order_forms_situation.recordset;
            // Menu
            let menus = await pool.request().query('select * from THUCDON')
            data_menus=menus.recordset;
            // Food
            let foods = await pool.request().query('select * from MONAN')
            data_menus=foods.recordset;

            return res.render('partner.ejs',{
                dataPartner: req.session.partner,
                dataContracts: data_contracts,
                dataStores: data_stores,
                dataOrderForms: data_orderforms,
                dataOrderFormsSituation: data_orderforms_situation,
                dataMenus: data_menus,
                dataFoods: data_foods
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else{
        return res.redirect('/');
    }
}
//
let getHomepageNhanvien= async (req,res)=>{
    if(req.session.agent){
        let data_contracts=[];
        let data_regforms=[];
        try {
            await pool.connect();
            // Contracts
            let contracts = await pool.request().query('select * from HOPDONG')
            data_contracts=contracts.recordset;
            // Registration forms
            let registration_forms = await pool.request().query('select * from HOSODANGKY')
            data_regforms=registration_forms.recordset;

            return res.render('agent.ejs',{
                dataAgent: req.session.agent,
                dataContracts:data_contracts,
                dataRegForms: data_regforms
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else{
        return res.redirect('/');
    }
}
//
let processSign_in=async (req,res)=>{
    let data_user=[];

    try {
        let {username,password,remember}=req.body;
        await pool.connect();
        // Get information
        let get_user = await pool.request().query(`select * from TAIKHOAN where UNAME='${username}' and PWD=${password}`);
        data_user=get_user.recordset;
        // Check information
        if(data_user.length==1){
            let s1=data_user[0].LOAI.trim();
            //
            if(s1 == 'Admin'.trim()){
                let result = await pool.request().query(`select * from Admin where MA='${data_user[0].MA}'`);
                let admin=result.recordset;
                req.session.admin=admin;
                return res.redirect('/accb_food.vn/admin');
            }//
            else if(s1 == 'KHACHHANG'.trim()){
                let result = await pool.request().query(`select * from KHACHHANG where MA='${data_user[0].MA}'`);
                let user=result.recordset;
                req.session.user=user;
                return res.redirect('/accb_food.vn');
            }//
            else if(s1 == 'DOITAC'.trim()){
                let result = await pool.request().query(`select * from DOITAC where MA='${data_user[0].MA}'`);
                let partner=result.recordset;
                req.session.partner=partner;
                return res.redirect('/accb_food.vn/doitac');
            }//
            else if(s1 == 'TAIXE'.trim()){
                let result = await pool.request().query(`select * from TAIXE where MA='${data_user[0].MA}'`);
                let driver=result.recordset;
                req.session.driver=driver;
                return res.redirect('/accb_food.vn/taixe');
            }//
            else{
                let result = await pool.request().query(`select * from NHANVIEN where MA='${data_user[0].MA}'`);
                let agent=result.recordset;
                req.session.agent=agent;
                return res.redirect('/accb_food.vn/nhanvien');
            }  
        }
        else{
            return res.redirect('/sign_in');
        }
    }
    catch (err) {
        console.log("ERROR:", err)
     }
    finally {
        pool.close();
    } 
}
//
let processSign_out=async (req,res)=>{
    req.session.destroy((err)=>{
        return res.redirect('/'); 
    });
}
//
let getProfilepage=async (req,res)=>{
    return res.render('profile.ejs')
}
//
const upload=multer().single('profile_pic');

let processUpload_file=async (req,res)=>{
    // 'profile_pic' is the name of our file input field in the HTML form
    upload(req, res, function(err) {
        // req.file contains information of uploaded file
        // req.body contains information of text fields, if there were any

        if (req.fileValidationError) {
            return res.send(req.fileValidationError);
        }
        else if (!req.file) {
            return res.send('Please select an image to upload');
        }
        else if (err instanceof multer.MulterError) {
            return res.send(err);
        }
        // Display uploaded image for user validation
        res.send(`You have uploaded this image: <hr/><img src="/images/${req.file.filename}" width="500"><hr />`);
    });
}
//
module.exports={
    getHomepage,
    getSign_in,
    getHomepageUser,
    getHomepageAdmin,
    getHomepageDoitac,
    getHomepageNhanvien,
    getHomepageDriver,
    processSign_in,
    processSign_out,
    getProfilepage,
    processUpload_file
}