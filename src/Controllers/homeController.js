import pool from "../configs/connectDB";
import multer from 'multer';
import session from "express-session";
import { response } from "express";
//User============================================================================================================================================================================================
let getHomepage = async (req, res) => {
    let data_foods = [];
    if (req.session.user) {
        return res.redirect('/accb_food.vn');
    }
    else if (req.session.admin) {
        return res.redirect('/accb_food.vn/admin');
    }
    else if (req.session.driver) {
        return res.redirect('/accb_food.vn/taixe');
    }
    else if (req.session.agent) {
        return res.redirect('/accb_food.vn/nhanvien');
    }
    else if (req.session.partner) {
        return res.redirect('/accb_food.vn/doitac');
    }
    else {
        try {
            await pool.connect();
            // Foods
            let foods = await pool.request().query('select * from MONAN')
            data_foods = foods.recordset;

            return res.render('index.ejs', {
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
let getSignIn = (req, res) => {
    return res.render('sign_in.ejs')
}
//
let getSignUp = async (req, res) => {
    await pool.connect();
    let data_conscious = [];
    let conscious = await pool.request().query('select *  from DIACHI ');
    data_conscious = conscious.recordset;
    return res.render('sign_up.ejs', { dataConscious: data_conscious });
}
//
let getHomepageUser = async (req, res) => {
    if (req.session.user) {
        let data_foods = [];
        let data_partners = [];
        let data_orderforms = [];
        let data_orderforms_situation = [];
        let data_menus = [];
        try {
            await pool.connect();
            // Food
            let foods = await pool.request().query('select * from MONAN')
            data_foods = foods.recordset;
            // Partner
            let partners = await pool.request().query('select * from DOITAC')
            data_partners = partners.recordset;
            // Menu
            let menus = await pool.request().query('select * from THUCDON')
            data_menus = menus.recordset;
            // Order form của khách hàng
            let order_forms = await pool.request().query('select * from DONHANG')
            data_orderforms = order_forms.recordset;
            // Order form situation
            let order_forms_situation = await pool.request().query('select * from TINHTRANGGIAOHANG')
            data_orderforms_situation = order_forms_situation.recordset;


            return res.render('user.ejs', {
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
    else {
        return res.redirect('/');
    }
}
//
let processSignIn = async (req, res) => {
    let data_user = [];

    try {
        let { username, password, remember } = req.body;
        await pool.connect();
        // Get information
        let get_user = await pool.request().query(`select * from TAIKHOAN where UNAME='${username}' and PWD=${password}`);
        data_user = get_user.recordset;
        // Check information
        if (data_user.length == 1) {
            let s1 = data_user[0].LOAI.trim();
            //
            if (s1 == 'Admin'.trim()) {
                let result = await pool.request().query(`select * from Admin where MA='${data_user[0].MA}'`);
                let admin = result.recordset;
                req.session.admin = admin;
                return res.redirect('/accb_food.vn/admin');
            }//
            else if (s1 == 'KHACHHANG'.trim()) {
                let result = await pool.request().query(`select * from KHACHHANG where KH_MA='${data_user[0].MA}'`);
                let user = result.recordset;
                req.session.user = user;
                return res.redirect('/accb_food.vn');
            }//
            else if (s1 == 'DOITAC'.trim()) {
                let result = await pool.request().query(`select * from DOITAC where DT_MA='${data_user[0].MA}'`);
                let partner = result.recordset;
                req.session.partner = partner;
                return res.redirect('/accb_food.vn/doitac');
            }//
            else if (s1 == 'TAIXE'.trim()) {
                let result = await pool.request().query(`select * from TAIXE where TX_MA='${data_user[0].MA}'`);
                let driver = result.recordset;
                req.session.driver = driver;
                return res.redirect('/accb_food.vn/taixe');
            }//
            else {
                let result = await pool.request().query(`select * from NHANVIEN where NV_MA='${data_user[0].MA}'`);
                let agent = result.recordset;
                req.session.agent = agent;
                return res.redirect('/accb_food.vn/nhanvien');
            }
        }
        else {
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
let processSignOut = async (req, res) => {
    req.session.destroy((err) => {
        return res.redirect('/');
    });
}
//
let getProfilepage = async (req, res) => {
    if (req.session.user) {
        let data_address = [];
        try {
            await pool.connect();
            // Dia Chi
            let address = await pool.request().query(`select * from DIACHI where DC_MATINH='${req.session.user[0].DC_MATINH}' and DC_MAHUYEN='${req.session.user[0].DC_MAHUYEN}' and DC_MAXA='${req.session.user[0].DC_MAXA}'`)
            data_address = address.recordset;

            return res.render('profile.ejs', {
                dataUser: req.session.user,
                dataAddress: data_address
            });
        }
        catch (err) {
            return res.redirect('/');
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/');
    }
}
//
let processUploadFile = async (req, res) => {
    // 'profile_pic' is the name of our file input field in the HTML form
    upload(req, res, function (err) {
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
        req.session.file=file;
        return res.redirect('/accb_food.vn/doitac/add_food');
    });
}
//
let getCartpage = async (req, res) => {
    if (req.session.user) {
        let data_foods_incart = [];
        let data_foods = [];
        try {
            await pool.connect();
            // Gio hang
            let foods_in_cart = await pool.request().query(`select * from GIOHANG where KH_MA='${req.session.user[0].KH_MA}'`);
            data_foods_incart = foods_in_cart.recordset;
            // Foods
            for (let i = 0; i < data_foods_incart.length; i++) {
                let foods = await pool.request().query(`select * from MONAN where MAN_MA='${data_foods_incart[i].MAN_MA}'`);
                data_foods.push(foods.recordset[0]);
            }
            // Total cost
            let cost = 0;
            for (let i = 0; i < data_foods_incart.length; i++) {
                cost += data_foods[i].MAN_GIA * data_foods_incart[i].SOLUONG;
            }

            return res.render('cart.ejs', {
                dataFoodsinCart: data_foods_incart,
                dataFoods: data_foods,
                totalCost: cost
            });

        } catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/');
    }
}
//
let getFoodDetailpage = async (req, res) => {
    if(req.session.user && req.params){
        let id=req.params.id;
        try{
            let data_food=[];
            let data_menu=[];
            await pool.connect();
            let food=await pool.request().query(`select * from MONAN where MAN_MA='${id}'`)
            data_food=food.recordset;
            let menu=await pool.request().query(`select * from THUCDON where TD_MA='${data_food[0].TD_MA}'`);
            data_menu=menu.recordset;
            return res.render('fooddetail.ejs',{
                dataFood: data_food,
                dataMenu: data_menu
            });
        }catch(err){
            return res.redirect('/accb_food.vn')
        }
        finally{
            pool.close();
        }
    }
    else{
        return res.redirect('/accb_food.vn')
    }
}
//
let getOrderpage = async (req, res) => {
    if (req.session.user) {
        let data_orders = [];
        await pool.connect();
        let orders = await pool.request().query(`exec sp_XemDanhSachDonHangCuaKhachHang '${req.session.user[0].KH_MA}'`);
        data_orders = orders.recordset;
        return res.render('orders.ejs', {
            dataOrders: data_orders
        });
    }
    else {
        return res.redirect('/accb_food.vn/cart')
    }
}
//
let getProcessOrderpage = async (req, res) => {
    if (req.body && req.session.user) {
        let { pay } = req.body;
        await pool.connect();
        await pool.request().query(`exec SP_KHDATHANG '${req.session.user[0].KH_MA}',N'${pay}'`);
        return res.redirect('/accb_food.vn/order');
    }
    else {
        return res.redirect('/accb_food.vn/cart')
    }
}
//
let getProcessCancelOrderpage = async (req, res) => {
    if (req.body && req.session.user) {
        let id = req.params.id;
        await pool.connect();
        await pool.request().query(`UPDATE DONHANG SET DH_TINHTRANG = N'Đã hủy' WHERE DH_MA = '${id}'`);
        return res.redirect('/accb_food.vn/order');
    }
    else {
        return res.redirect('/accb_food.vn/cart')
    }
}
//
let getAddtoCart = async (req, res) => {
    if (req.params && req.session.user) {
        let data_foods = []
        try {
            await pool.connect();
            let food = await pool.request().query(`select * from MONAN where MAN_MA=${req.params.id}`);
            // Them vao gio hang
            let count = await pool.request().query(`select count(*) as count from GIOHANG`);
            if (count.recordset[0].count == 0) {
                await pool.request().query(`insert into GIOHANG(MAN_MA,TD_MA,CN_MA,CH_MA,KH_MA,SOLUONG,NOTES) values (${req.params.id},'${food.recordset[0].TD_MA}','${food.recordset[0].CN_MA}','${food.recordset[0].CH_MA}','${req.session.user[0].KH_MA}', '1','${food.recordset[0].MAN_MIEUTA}')`);
                return res.redirect('/accb_food.vn/');
            }
            else {
                //
                let foods = await pool.request().query(`select * from GIOHANG where MAN_MA=${req.params.id} and KH_MA='${req.session.user[0].KH_MA}'`);
                data_foods = foods.recordset;
                if (data_foods.length) {
                    var soluong_bd = data_foods[0].SOLUONG;
                    var soluong_sau = soluong_bd + 1;
                    //console.log('check==>2 ==>',`update GIOHANG set SOLUONG='${soluong_sau}' where MAN_MA=${req.params.id} and KH_MA='${req.session.user[0].KH_MA}'`)
                    await pool.request().query(`update GIOHANG set SOLUONG='${soluong_sau}' where MAN_MA=${req.params.id} and KH_MA='${req.session.user[0].KH_MA}'`);
                    return res.redirect('/accb_food.vn/');
                }
                else if (!data_foods.length) {
                    await pool.request().query(`insert into GIOHANG(MAN_MA,TD_MA,CN_MA,CH_MA,KH_MA,SOLUONG,NOTES) values (${req.params.id},'${food.recordset[0].TD_MA}','${food.recordset[0].CN_MA}','${food.recordset[0].CH_MA}','${req.session.user[0].KH_MA}', '1','${food.recordset[0].MAN_MIEUTA}')`);
                    return res.redirect('/accb_food.vn/');
                }
                else {
                    console.log("error!");
                }
            }
        } catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/accb_food.vn');
    }
}
//
let updateQuantity = async (req, res) => {
    if (req.params && req.session.user) {
        let data_foods = []
        try {
            let operator = req.params.operator;
            let id = req.params.id;

            await pool.connect();

            let foods = await pool.request().query(`select * from GIOHANG where MAN_MA='${req.params.id}' and KH_MA='${req.session.user[0].KH_MA}'`);
            data_foods = foods.recordset;
            var soluong_bd = data_foods[0].SOLUONG;

            if (operator == 0) {
                var soluong_sau = soluong_bd + 1;

                await pool.request().query(`update GIOHANG set SOLUONG='${soluong_sau}' where MAN_MA='${req.params.id}' and KH_MA='${req.session.user[0].KH_MA}'`);
                return res.redirect('/accb_food.vn/cart');
            }
            else if (operator == 1) {
                var soluong_sau = soluong_bd - 1;
                if (soluong_sau <= 0) {
                    await pool.request().query(`delete from GIOHANG where MAN_MA='${req.params.id}' and KH_MA='${req.session.user[0].KH_MA}'`);
                    return res.redirect('/accb_food.vn/cart');
                } else {
                    await pool.request().query(`update GIOHANG set SOLUONG='${soluong_sau}' where MAN_MA='${req.params.id}' and KH_MA='${req.session.user[0].KH_MA}'`);
                    return res.redirect('/accb_food.vn/cart');
                }
            }
            else {
                return res.redirect('/');
            }

        } catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/accb_food.vn');
    }
}

let createNewUser = async (req, res) => {
   try{
    await pool.connect();
    let name = req.body.name;
    let sex = req.body.userSex;
    let email = req.body.userEmail;
    let phone = req.body.userPhoneNumber;
    let MATINH = req.body.DC_MATINH.trim();
    let MAHUYEN = req.body.DC_MAHUYEN.trim();
    let MAXA = req.body.DC_MAXA.trim();
    let SONHA = req.body.userAddress;
    let userName = req.body.userName;
    let userPass = req.body.userPassword;
    await pool.request().query(`exec sp_ThemThongTinKhachHang N'${name}','${phone}','${email}',N'${sex}','${MATINH}','${MAHUYEN}','${MAXA}','${SONHA}'`);
    await pool.request().query(`exec pr_taoUSER '${userName}','${userPass}','KHACHHANG'`);
    return res.redirect('/sign_in');
   }catch(err){
    return res.redirect('/sign_up');
   }
   finally {
    pool.close();
    }
}
//
let processSearch = async (req, res) => {
    try {
        let search = req.body.search;
        
        await pool.connect();
        let data_foods=[];
        let foods=await pool.request().query(`exec sp_DanSachMonAnKhachHangTimKiem N'${search}'`);
        
        data_foods=foods.recordset;
        
        return res.render('search_page.ejs',{
            dataFoods: data_foods
        })
    }catch(err) {
        return res.redirect('/');
    }
}
//Partner=========================================================================================================================================================================================
let getHomepageDoitac = async (req, res) => {
    if (req.session.partner) {
        let data_branchs = [];
        let data_stores = [];
        let data_foods = [];
        try {
            await pool.connect();
            // Store
            let stores = await pool.request().query(`exec sp_dscuahangdoitac '${req.session.partner[0].DT_MA}'`);
            data_stores = stores.recordset;
            req.session.store=data_stores
            // Branch
            let branch = await pool.request().query(`exec sp_chinhanhcuadoitac '${req.session.partner[0].DT_MA}','${data_stores[0].CH_MA}'`);
            data_branchs=branch.recordset;
            // Food
            let foods = await pool.request().query(`exec sp_monancuacuahang '${req.session.partner[0].DT_MA}','${data_stores[0].CH_MA}'`)
            data_foods=foods.recordset;
            //
            return res.render('./partner/Home.ejs', {
                dataPartner: req.session.partner,
                dataStores: data_stores,
                dataBranch: data_branchs,
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
    else {
        return res.redirect('/');
    }
}
//
let getSignUpDT = async (req, res) => {
    return res.render('./partner/signup.ejs');
}
//
let getMenupageDT = async (req, res) => {
    if(req.session.partner&&req.session.store){
        let foods_of_store=[];
        await pool.connect();
        let foods=await pool.request().query(`exec sp_monancuacuahang '${req.session.partner[0].DT_MA}','${req.session.store[0].CH_MA}'`);
        foods_of_store=foods.recordset;

        return res.render('./partner/Menu.ejs',{
            dataFoodsofStore:foods_of_store
        });
    }
    else{
        return res.redirect('/accb_food.vn/doitac');
    }
}
//
let getAddFoodDT = async (req, res) => {
    await pool.connect();
    let data_menu=[];
    let menu=await pool.request().query(`select * from THUCDON where CH_MA='${req.session.store[0].CH_MA}' and CN_MA='${req.params.id}'`);
    data_menu=menu.recordset;
    return res.render('./partner/AddFood.ejs',{
        idBranch:req.params.id,
        dataMenus: data_menu
    });
}
//
const upload = multer().single('food_pic');

let getProcessAddFoodDT = async (req, res) => {
    if(req.session.partner && req.session.store && req.params.id && req.body ){
        let food_name=req.body.name;
        let food_detail=req.body.detail;
        let food_price=req.body.cost;
        let id_menu=req.body.menu;
        let name_menu=req.body.name_menu ?? ''

        // 'profile_pic' is the name of our file input field in the HTML form
        upload(req, res,async function (err) {
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
            let image_path='/images/foods/'+req.file.filename;
            await pool.connect();
            if(name_menu ){
                await pool.request().query(`exec sp_themThucDon '${req.params.id}','${req.session.store[0].CH_MA}', '${name_menu}'`);
                let menu=await pool.request().query(`select * from THUCDON where CH_MA='${req.session.store[0].CH_MA}' and CN_MA='${req.params.id}' and TD_TEN='${name_menu}'`);
                await pool.request().query(`exec sp_themMonAn '${req.session.partner[0].DT_MA}','${menu.recordset[0].TD_MA}' ,'${req.params.id}','${req.session.store[0].CH_MA}' ,'${food_name}' ,'${food_detail}' ,'${image_path}','${food_price}'`);
            }else{
                await pool.request().query(`exec sp_themMonAn '${req.session.partner[0].DT_MA}','${id_menu}' ,'${req.params.id}','${req.session.store[0].CH_MA}' ,N'${food_name}' ,N'${food_detail}' ,'${image_path}','${food_price}'`);
            }
            
            return res.redirect(`/accb_food.vn/doitac/add_food/id/${req.params.id}`);
        });

    }
    else{
        return res.redirect('/');
    }
}
//
let getBranchpageDT = async (req, res) => {
    if(req.session.partner && req.session.store && req.params.id){
        let foods_of_branch=[];
        let data_branch=[];
        await pool.connect();
        let foods=await pool.request().query(`exec sp_monanchinhanhcuahang '${req.session.partner[0].DT_MA}','${req.session.store[0].CH_MA}','${req.params.id}'`);
        foods_of_branch=foods.recordset;
        //
        let branch=await pool.request().query(`select * from CHINHANH where CN_MA='${req.params.id}'`);
        data_branch=branch.recordset;

        return res.render('./partner/Branch.ejs',{
            dataFoodsofBranch:foods_of_branch,
            dataBranch:data_branch
        });
    }
    else{
        return res.redirect('/');
    }
}
//
let getContractDetailpageDT = async (req, res) => {
    return res.render('./partner/ContractDetails.ejs');
}
//
let getFoodDetailpageDT = async (req, res) => {
    return res.render('./partner/fooddetail.ejs');
}
//
let getOrderspageDT = async (req, res) => {
    if(req.session.partner){
        let orders=[];
        await pool.connect();
        let order = await pool.request().query(`select * from DONHANG where CH_MA='${req.session.store[0].CH_MA}'`);
        orders=order.recordset;
        return res.render('./partner/orders.ejs',{
            dataOrders: orders
        });
    }else{
        return res.redirect('/');
    }
}
//
let getProcessCancelOrderpageDT = async (req, res) => {
    if (req.params && req.session.partner) {
        let id = req.params.id;
        await pool.connect();
        await pool.request().query(`UPDATE DONHANG SET DH_TINHTRANG = N'Đã hủy' WHERE DH_MA = '${id}'`);
        return res.redirect('/accb_food.vn/doitac/orders');
    }
    else {
        return res.redirect('/accb_food.vn/doitac');
    }
}
//
let getDeletFoodBranchpageDT= async (req, res) => {
    if (req.params.id_mn && req.session.partner) {
        let id_cn = req.body.MA_CN;
        let id_mn = req.params.id_mn;

        try{
            await pool.connect();
            await pool.request().query(`exec sp_xoamonan '${id_mn}', '${id_cn}', '${req.session.store[0].CH_MA}'`);
            return res.redirect(`/accb_food.vn/doitac/branch/id/${id_cn}`);
        }catch(err){
            return res.redirect('/accb_food.vn/doitac');
        }
    }
    else {
        return res.redirect('/accb_food.vn/doitac');
    }
}
//
let getOrdersDetailpageDT = async (req, res) => {
    return res.render('./partner/OrdersDetails.ejs');
}
//
let getPartContractspageDT = async (req, res) => {
    return res.render('./partner/PartContract.ejs');
}
//
let getRenewContractpageDT = async (req, res) => {
    return res.render('./partner/RenewContract.ejs');
}
//
let getShoppageDT = async (req, res) => {
    if(req.session.partner){
        await pool.connect();
        let store = await pool.request().query(`select * from CUAHANG where DT_MA='${req.session.partner[0].DT_MA}' and CH_MA='${req.session.store[0].CH_MA}'`);
        req.session.store=store.recordset;
        return res.render('./partner/shop.ejs',{
            dataStore: req.session.store
        });
    }else{
        return res.redirect('/');
    }
}
//
let getEditShoppageDT = async (req, res) => {
    if(req.session.partner){
        await pool.connect();
        await pool.request().query(`exec sp_updateCuaHang '${req.session.partner[0].DT_MA}','${req.session.store[0].CH_MA}','${req.body.name}','${req.body.number_phone}',N'${req.body.tinhtrang}'`);
        return res.redirect('/accb_food.vn/doitac/shop');
    }else{
        return res.redirect('/');
    } 
}
//
let createrNewPartner = async (req, res) => {
    await pool.connect();
    let mail = req.body.mail;
    let shopname = req.body.shopName;
    let representatives = req.body.representatives;
    let city = req.body.city;
    let county = req.body.county;
    let branchesNumber = req.body.branchesNumber;
    let NumberOrderPerDay = req.body.NumberOrderPerDay;
    let cuisineType = req.body.cuisineType;
    let phone = req.body.phone;
    let password = req.body.password;
    let address=req.body.address;
    await pool.request().query(`exec sp_themHoSoDangKy '${mail}',N'${shopname}',N'${city}',N'${county}',${branchesNumber},${NumberOrderPerDay},N'${cuisineType}',N'${representatives}','${phone}','${password[0]}','${address}'`)
    return res.redirect('/accb_food.vn/doitac')
}
//Driver==========================================================================================================================================================================================
let getHomepageDriver = async (req, res) => {
    if (req.session.driver) {
        let data_orders = [];
        try {
            await pool.connect();
            let orders= await pool.request().query('select * from DONHANG')
            data_orders = orders.recordset;

            return res.render('./driver/orders.ejs', {
                dataDriver: req.session.driver,
                dataOrders: data_orders
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/')
    }
}
//
let getProfilepageDriver = async (req, res) => {
    if (req.session.driver) {
        try {
            return res.render('./driver/info.ejs', {
                dataDriver: req.session.driver
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/')
    }
}
//
let getEditProfileDriver = async (req, res) => {
    if (req.session.driver && req.body) {
        try {
            await pool.connect();

            
            await pool.request().query(`update TAIXE set TX_TEN=N'${req.body.name}', TX_CMND='${req.body.cmnd}', TX_SDT='${req.body.sdt}', TX_BIENSOXE='${req.body.bike_number}', TX_STK='${req.body.bank_number}', TX_GIOITINH='${req.body.sex}' WHERE TX_MA ='${req.session.driver[0].TX_MA}'`)

            let driver = await pool.request().query(`select * from TAIXE where TX_MA='${req.session.driver[0].TX_MA}'`)
            req.session.driver=driver.recordset;
            return res.render('./driver/info.ejs', {
                dataDriver: req.session.driver
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/')
    }
}
//
let getAcceptOrderspageDriver = async (req, res) => {
    if (req.session.driver && req.params) {
        let data_order = [];
        let id_dh=req.body.id_dh;
        let id_tx=req.params.id;
        try {
            await pool.connect();

            let order= await pool.request().query(`select * from DONHANG where DH_MA='${id_dh}'`)
            data_order = order.recordset;

            await pool.request().query(`exec sp_acceptOrder '${id_tx}','${data_order[0].DH_MA}',N'Đã nhận đơn hàng','${data_order[0].DC_MATINH}','${data_order[0].DC_MAHUYEN}','${data_order[0].DC_MAXA}'`)

            return res.redirect('/accb_food.vn/taixe');
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/')
    }
}
//
let getOrdersDetailpageDriver = async (req, res) => {
    return res.render('./driver/OrdersDetail.ejs');
}
//
let getSignUppageDriver = async (req, res) => {
    await pool.connect();
    let data_conscious = [];
    let conscious = await pool.request().query('select *  from DIACHI ');
    data_conscious = conscious.recordset;
    return res.render('./driver/signup.ejs', { dataConscious: data_conscious });
}
//
let getWalletpageDriver = async (req, res) => {
    if (req.session.driver) {
        try {
            let data_orderforms_situation=[];
            let data_orders=[]; 

            await pool.connect();
            let order_forms_situation= await pool.request().query(`select * from TINHTRANGGIAOHANG where TX_MA='${req.session.driver[0].TX_MA}'`)
            data_orderforms_situation = order_forms_situation.recordset;

            for(let i=0; i<data_orderforms_situation.length;i++){
                let orders= await pool.request().query(`select * from DONHANG where DH_MA='${data_orderforms_situation[0].DH_MA}'`)
                data_orders.push(orders.recordset[0]) ;
            }

            let cost =0 ;
            for(let i=0; i<data_orders.length ;i++){
                cost+=data_orders[0].DH_PHIVANCHUYEN;
            }
            return res.render('./driver/Wallet.ejs', {
                dataDriver: req.session.driver,
                dataOrders: data_orders,
                cost:cost
            });
        }
        catch (err) {
            console.log("ERROR:", err)
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/')
    }
}
//
let createrNewDriver = async (req, res) => {
    try{
        await pool.connect();
        let name = req.body.name;
        let sex = req.body.sex;
        let email = req.body.email;
        let phone = req.body.phone;
        let MATINH = req.body.DC_MATINH.trim();
        let MAHUYEN = req.body.DC_MAHUYEN.trim();
        let MAXA = req.body.DC_MAXA.trim();
        let id = req.body.id;
        let licenseplate = req.body.licensePlate;
        let bank = req.body.bank;
        let banknumber = req.body.bankNumber;
        let userName = req.body.userName;
        let userPass = req.body.pass;
        console.log(`exec sp_themthongtintaixe N'${name}','${id}','${phone}',N'${licenseplate}','${banknumber}','${bank}','${sex}','${MATINH}','${MAHUYEN}','${MAXA}'`);
        console.log(`exec pr_taoUSER '${userName}','${userPass}','TAIXE'`);
        await pool.request().query(`exec sp_themthongtintaixe N'${name}','${id}','${phone}',N'${licenseplate}','${banknumber}','${bank}','${sex}','${MATINH}','${MAHUYEN}','${MAXA}'`);
        await pool.request().query(`exec pr_taoUSER '${userName}','${userPass}','TAIXE'`);
        return res.redirect('/sign_in');
    }catch(err){
        return res.redirect('/');
    }finally{
        return res.redirect('/sign_in');
    }
}
//Agent===========================================================================================================================================================================================
let getEmployeeContractpageNhanvien = async (req, res) => {
    if (req.session.agent) {
        let data_contracts = [];
        try {
            await pool.connect();
            // Contracts
            let contracts = await pool.request().query('select * from HOSODANGKY where NV_MA=NULL')
            data_contracts = contracts.recordset;
            return res.render('./agent/EmployeeContact.ejs', {
                dataAgent: req.session.agent,
                dataContracts: data_contracts
            });
        }
        catch (err) {
            return res.redirect('/accb_food.vn/nhanvien/');
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/');
    }
}
//
let getContractDetailpageNhanvien = async (req, res) => {
    if (req.session.agent) {
        let data_contracts = [];
        let id=req.params.id;
        try {
            await pool.connect();
            // Contracts
            let contracts = await pool.request().query(`select * from HOSODANGKY where HSDK_MA='${id}'`)
            data_contracts = contracts.recordset;
            return res.render('./agent/ContractDetails.ejs', {
                dataAgent: req.session.agent,
                dataContracts: data_contracts
            });
        }
        catch (err) {
            return res.redirect('/accb_food.vn/nhanvien/');
        }
        finally {
            pool.close();
        }
    }
    else {
        return res.redirect('/');
    }
}
//
let getEmployeePartnerpageNhanvien = async (req, res) => {
    if(req.session.agent){
        try{
            let data_partners=[];
            await pool.connect();
            let partners = await pool.request().query(`select * from DOITAC`);
            data_partners=partners.recordset;
            return res.render('./agent/EmployeePartner.ejs',{
                dataAgent: req.session.agent,
                dataPartners: data_partners
            });
        }catch(err){
            return res.redirect('/accb_food.vn/nhanvien');
        }
        finally{
            pool.close();
        }
    }
    else{
        return res.redirect('/accb_food.vn/nhanvien');
    }
}
//
let getProfilepageNhanvien = async (req, res) => {
    if(req.session.agent){
        return res.render('./agent/info.ejs',{
            dataAgent: req.session.agent
        });
    }else{
        return res.redirect('/accb_food.vn/nhanvien');
    }
}
//
let getEditProfilepageNhanvien = async (req, res) => {
    if(req.session.agent && req.body){
        let name=req.body.name;
        let mail=req.body.mail;
        let sex=req.body.sex;
        let cmnd=req.body.cmnd;
        let phone_number=req.body.phone_number;
        console.log(req.body);
        try{
            await pool.connect();
            await pool.request().query(`exec sp_CapNhatThongTinNhanVien '${req.session.agent[0].NV_MA}',N'${name}','${mail}','${sex}','${cmnd}','${phone_number}'`);
            let agent=await pool.request().query(`select * from NHANVIEN where NV_MA='${req.session.agent[0].NV_MA}'`);
            req.session.agent=agent.recordset;

            return res.redirect('/accb_food.vn/nhanvien/profile');
        }
        catch(err){
            return res.redirect('/accb_food.vn/nhanvien/profile');
        }finally{
            pool.close();
        }
    }else{
        return res.redirect('/accb_food.vn/nhanvien');
    }
}
//
let getNotifypageNhanvien = async (req, res) => {
    return res.render('./agent/Notify.ejs');
}
//
let getAcceptContractNhanvien = async (req, res) => {
    if(req.body && req.session.agent){
        let id_hsdk=req.body.id_hsdk;
        let id_nv=req.body.id_nv
        try{
            await pool.connect();
            await pool.request().query(`exec sp_duyetHSDK '${id_hsdk}','${id_nv}'`);
            return res.redirect(`/accb_food.vn/nhanvien/`);
        }catch(err){
            return res.redirect(`/accb_food.vn/nhanvien/contract_detail/id/'${id_hsdk}'`);
        }finally{
            pool.close();
        }
    }
    else{
        return res.redirect('/accb_food.vn/nhanvien/');
    }
}
//Admin===========================================================================================================================================================================================
let getHomepageAdmin = async (req, res) => {
    if (req.session.admin) {
        let data_drivers = [];
        let data_users = [];
        let data_agents = [];
        let data_partners = [];
        try {
            await pool.connect();
            // Driver
            let drivers = await pool.request().query('select * from TAIXE')
            data_drivers = drivers.recordset;
            // User
            let users = await pool.request().query('select * from KHACHHANG')
            data_users = users.recordset;
            // Agent
            let agents = await pool.request().query('select * from NHANVIEN')
            data_agents = agents.recordset;
            // Partner
            let partners = await pool.request().query('select * from DOITAC')
            data_partners = partners.recordset;

            return res.render('./admin/Home.ejs', {
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
    else {
        return res.redirect('/');
    }
}
//
let getAddUserpageAdmin = async (req, res) => {
    return res.render('./admin/AddUser.ejs');
}
//
let getAdminspageAdmin = async (req, res) => {
    return res.render('./admin/admin.ejs');
}
//
let getCustomerspageAdmin = async (req, res) => {
    return res.render('./admin/Customer.ejs');
}
//
let getDriverspageAdmin = async (req, res) => {
    return res.render('./admin/Driver.ejs');
}
//
let getEditUserpageAdmin = async (req, res) => {
    return res.render('./admin/EditUser.ejs');
}
//
let getEmployeespageAdmin = async (req, res) => {
    return res.render('./admin/employee.ejs');
}
//
let getListLockpageAdmin = async (req, res) => {
    return res.render('./admin/ListLock.ejs');
}
//
let getPartnerspageAdmin = async (req, res) => {
    return res.render('./admin/partner.ejs');
}
//
let getUserProfilepageAdmin = async (req, res) => {
    return res.render('./admin/UserInfo.ejs');
}
//
module.exports = {
    getHomepage,
    getSignIn,
    getHomepageUser,
    getHomepageAdmin,
    getHomepageDoitac,
    getHomepageDriver,
    processSignIn,
    processSignOut,
    getProfilepage,
    processUploadFile,
    getSignUp,
    getCartpage,
    getFoodDetailpage,
    getOrderpage,
    getProcessOrderpage,
    getProcessCancelOrderpage,
    getAddtoCart,
    updateQuantity,
    getSignUpDT,
    getMenupageDT,
    getAddFoodDT,
    getBranchpageDT,
    getContractDetailpageDT,
    getFoodDetailpageDT,
    getOrderspageDT,
    getOrdersDetailpageDT,
    getPartContractspageDT,
    getRenewContractpageDT,
    getShoppageDT,
    getProfilepageDriver,
    getAcceptOrderspageDriver,
    getOrdersDetailpageDriver,
    getSignUppageDriver,
    getWalletpageDriver,
    getContractDetailpageNhanvien,
    getEmployeeContractpageNhanvien,
    getEmployeePartnerpageNhanvien,
    getProfilepageNhanvien,
    getNotifypageNhanvien,
    getAddUserpageAdmin,
    getAdminspageAdmin,
    getCustomerspageAdmin,
    getDriverspageAdmin,
    getEditUserpageAdmin,
    getEmployeespageAdmin,
    getListLockpageAdmin,
    getPartnerspageAdmin,
    getUserProfilepageAdmin,
    createNewUser,
    getProcessAddFoodDT,
    getEditShoppageDT,
    getProcessCancelOrderpageDT,
    getDeletFoodBranchpageDT,
    getEditProfileDriver,
    createrNewPartner,
    createrNewDriver,
    getEditProfilepageNhanvien,
    getAcceptContractNhanvien,
    processSearch
}