import pool from "../configs/connectDB";
import multer from 'multer';
//
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
let getTest = (req,res)=>{
    return res.render('homepage.ejs');
}
//
let getSign_in = (req,res)=>{
    return res.render('sign_in.ejs')
}
//
let getSign_up = (req,res)=>{
    return res.render('sign_up.ejs')
}
//
let getHomepageUser = async (req,res)=>{
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
let getHomepageAdmin = async (req,res)=>{
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
let getHomepageDriver = async (req,res)=>{
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
let getHomepageDoitac = async (req,res)=>{
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
let getHomepageNhanvien = async (req,res)=>{
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
let processSign_in = async (req,res)=>{
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
                let result = await pool.request().query(`select * from KHACHHANG where KH_MA='${data_user[0].MA}'`);
                let user=result.recordset;
                req.session.user=user;
                return res.redirect('/accb_food.vn');
            }//
            else if(s1 == 'DOITAC'.trim()){
                let result = await pool.request().query(`select * from DOITAC where DT_MA='${data_user[0].MA}'`);
                let partner=result.recordset;
                req.session.partner=partner;
                return res.redirect('/accb_food.vn/doitac');
            }//
            else if(s1 == 'TAIXE'.trim()){
                let result = await pool.request().query(`select * from TAIXE where TX_MA='${data_user[0].MA}'`);
                let driver=result.recordset;
                req.session.driver=driver;
                return res.redirect('/accb_food.vn/taixe');
            }//
            else{
                let result = await pool.request().query(`select * from NHANVIEN where NV_MA='${data_user[0].MA}'`);
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
let processSign_out = async (req,res)=>{
    req.session.destroy((err)=>{
        return res.redirect('/'); 
    });
}
//
let getProfilepage = async (req,res)=>{
    if(req.session.user){
        let data_address=[];
        try {
            await pool.connect();
            // Dia Chi
            let address = await pool.request().query(`select * from DIACHI where DC_MATINH='${req.session.user[0].DC_MATINH}' and DC_MAHUYEN='${req.session.user[0].DC_MAHUYEN}' and DC_MAXA='${req.session.user[0].DC_MAXA}'`)
            data_address=address.recordset;
            
            return res.render('profile.ejs',{
                dataUser: req.session.user,
                dataAddress: data_address
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
const upload = multer().single('profile_pic');

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
        res.send(`You have uploaded this image: <hr/><img src="/images/profile pic/${req.file.filename}" width="500"><hr />`);
    });
}
//
let getCartpage =async (req,res)=>{
    if(req.session.user){
        let data_foods_incart=[];
        let data_foods=[];
        try{
            await pool.connect();
            // Gio hang
            let foods_in_cart=await pool.request().query(`select * from GIOHANG where KH_MA='${req.session.user[0].KH_MA}'`);
            data_foods_incart=foods_in_cart.recordset;
            // Foods
            for(let i=0;i<data_foods_incart.length;i++){
                let foods=await pool.request().query(`select * from MONAN where MAN_MA='${data_foods_incart[i].MAN_MA}'`);
                data_foods.push(foods.recordset[0]);
            }
            // Total cost
            let cost=0;
            for(let i=0;i<data_foods_incart.length;i++){
                cost += data_foods[i].MAN_GIA*data_foods_incart[i].SOLUONG;
            }

            return res.render('cart.ejs',{
                dataFoodsinCart: data_foods_incart,
                dataFoods: data_foods,
                totalCost: cost
            });

        }catch (err) {
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
let getFoodDetailpage = (req,res)=>{
    return res.render('fooddetail.ejs');
}
//
let getOrderpage = async (req,res)=>{
    return res.render('orders.ejs')
}
//
let getAddtoCart = async (req,res)=>{
    if(req.params && req.session.user){
        let data_foods=[]
        try{
            await pool.connect();
            // Them vao gio hang
            let count=await pool.request().query(`select count(*) as count from GIOHANG`);
            if(count.recordset[0].count==0){
                await pool.request().query(`insert into GIOHANG(MAN_MA,KH_MA,SOLUONG) values (${req.params.id},'${req.session.user[0].KH_MA}', '1')`);
                return res.redirect('/accb_food.vn/');
            }
            else{
                //
                let foods=await pool.request().query(`select * from GIOHANG where MAN_MA=${req.params.id} and KH_MA='${req.session.user[0].KH_MA}'`);
                data_foods=foods.recordset;
                if(data_foods.length){
                    var soluong_bd=data_foods[0].SOLUONG;
                    var soluong_sau=soluong_bd+1;
                    //console.log('check==>2 ==>',`update GIOHANG set SOLUONG='${soluong_sau}' where MAN_MA=${req.params.id} and KH_MA='${req.session.user[0].KH_MA}'`)
                    await pool.request().query(`update GIOHANG set SOLUONG='${soluong_sau}' where MAN_MA=${req.params.id} and KH_MA='${req.session.user[0].KH_MA}'`);
                    return res.redirect('/accb_food.vn/');
                }
                else if(!data_foods.length){
                    await pool.request().query(`insert into GIOHANG(MAN_MA,KH_MA,SOLUONG) values (${req.params.id},'${req.session.user[0].KH_MA}', '1')`);
                    return res.redirect('/accb_food.vn/');
                }
                else{
                    console.log("error!");
                }
            }
        }catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else{
        return res.redirect('/accb_food.vn');
    }
}
//
let updateQuantity = async (req,res)=>{
    if(req.params && req.session.user){
        let data_foods=[]
        try{
            let operator=req.params.operator;
            let id=req.params.id;

            await pool.connect();

            let foods=await pool.request().query(`select * from GIOHANG where MAN_MA='${req.params.id}' and KH_MA='${req.session.user[0].KH_MA}'`);
            data_foods=foods.recordset;
            var soluong_bd=data_foods[0].SOLUONG;

            if(operator==0){
                var soluong_sau=soluong_bd+1;
                
                await pool.request().query(`update GIOHANG set SOLUONG='${soluong_sau}' where MAN_MA='${req.params.id}' and KH_MA='${req.session.user[0].KH_MA}'`);
                return res.redirect('/accb_food.vn/cart');
            }
            else if(operator==1){
                var soluong_sau=soluong_bd-1;
                if(soluong_sau<=0){
                    await pool.request().query(`delete from GIOHANG where MAN_MA='${req.params.id}' and KH_MA='${req.session.user[0].KH_MA}'`);
                    return res.redirect('/accb_food.vn/cart');
                }else{
                    await pool.request().query(`update GIOHANG set SOLUONG='${soluong_sau}' where MAN_MA='${req.params.id}' and KH_MA='${req.session.user[0].KH_MA}'`);
                    return res.redirect('/accb_food.vn/cart');
                }
            }
            else{
                return res.redirect('/');
            }
            
        }catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else{
        return res.redirect('/accb_food.vn');
    }
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
    processUpload_file,
    getTest,
    getSign_up,
    getCartpage,
    getFoodDetailpage,
    getOrderpage,
    getAddtoCart,
    updateQuantity
}