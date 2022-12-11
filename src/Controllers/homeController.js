import pool from "../configs/connectDB";
import multer from 'multer';
import session from "express-session";
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
let getSignUp = (req, res) => {
    return res.render('sign_up.ejs')
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
const upload = multer().single('profile_pic');

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
        res.send(`You have uploaded this image: <hr/><img src="/images/profile pic/${req.file.filename}" width="500"><hr />`);
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
let getFoodDetailpage = (req, res) => {
    return res.render('fooddetail.ejs');
}
//
let getOrderpage = async (req, res) => {
    if(req.session.user){
        let data_orders=[];
        await pool.connect();
        let orders = await pool.request().query(`exec sp_XemDanhSachDonHangCuaKhachHang '${req.session.user[0].KH_MA}'`);
        data_orders=orders.recordset;
        return res.render('orders.ejs',{
            dataOrders:data_orders
        });
    }
    else{
        return res.redirect('/accb_food.vn/cart')
    }
}
//

let getProcessOrderpage = async (req, res) => {
    if(req.body && req.session.user){
        let { pay} = req.body;
        await pool.connect();
        await pool.request().query(`exec SP_KHDATHANG '${req.session.user[0].KH_MA}',N'${pay}'`);
        return res.redirect('/accb_food.vn/order');
    }
    else{
        return res.redirect('/accb_food.vn/cart')
    }
}
//
let getProcessCancelOrderpage = async (req, res) => {
    if(req.body && req.session.user){
        let id = req.params.id;
        await pool.connect();
        await pool.request().query(`UPDATE DONHANG SET DH_TINHTRANG = N'Đã hủy' WHERE DH_MA = '${id}'`);
        return res.redirect('/accb_food.vn/order');
    }
    else{
        return res.redirect('/accb_food.vn/cart')
    }
}
//
let getAddtoCart = async (req, res) => {
    if (req.params && req.session.user) {
        let data_foods = []
        try {
            await pool.connect();
            let food=await pool.request().query(`select * from MONAN where MAN_MA=${req.params.id}`);
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
            // Branch
            for(let i=0; i<data_stores.length;i++){
                let branch = await pool.request().query(`exec sp_chinhanhcuahangdoitac '${req.session.partner[0].DT_MA}','${data_stores[i].CH_MA}'`);
                data_branchs.push(branch.recordset[0]);
            }
            // Food
            for(let i=0; i<data_stores.length;i++){
                let foods = await pool.request().query(`exec sp_monancuacuahangdoitac '${req.session.partner[0].DT_MA}','${data_stores[i].CH_MA}'`)
                data_foods.push(foods.recordset[0]);
            }

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
    return res.render('./partner/sign_up.ejs');
}
//
let getMenupageDT = async (req, res) => {
    return res.render('./partner/Menu.ejs');
}
//
let getAddFoodDT = async (req, res) => {
    return res.render('./partner/AddFood.ejs');
}
//
let getBranchpageDT = async (req, res) => {
    return res.render('./partner/Branch.ejs');
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
    return res.render('./partner/orders.ejs');
}
//
let getOrdersDetailpageDT = async (req, res) => {
    return res.render('./partner/OrsersDetails.ejs');
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
    return res.render('./partner/shop.ejs');
}
//Driver==========================================================================================================================================================================================
let getHomepageDriver = async (req, res) => {
    if (req.session.driver) {
        let data_orderforms_situation = [];
        try {
            await pool.connect();
            // Order form situation
            let order_forms_situation = await pool.request().query('select * from TINHTRANGGIAOHANG')
            data_orderforms_situation = order_forms_situation.recordset;

            return res.render('driver.ejs', {
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
    else {
        return res.redirect('/')
    }
}
//
let getProfilepageDriver = async (req, res) => {
    return res.render('./driver/info.ejs');
}
//
let getOrderspageDriver = async (req, res) => {
    return res.render('./driver/orders.ejs');
}
//
let getOrdersDetailpageDriver = async (req, res) => {
    return res.render('./driver/OrdersDetail.ejs');
}
//
let getSignUppageDriver = async (req, res) => {
    return res.render('./driver/signup.ejs');
}
//
let getWalletpageDriver = async (req, res) => {
    return res.render('./driver/Wallet.ejs');
}
//Agent===========================================================================================================================================================================================
let getHomepageNhanvien = async (req, res) => {
    if (req.session.agent) {
        let data_contracts = [];
        let data_regforms = [];
        try {
            await pool.connect();
            // Contracts
            let contracts = await pool.request().query('select * from HOPDONG')
            data_contracts = contracts.recordset;
            // Registration forms
            let registration_forms = await pool.request().query('select * from HOSODANGKY')
            data_regforms = registration_forms.recordset;

            return res.render('agent.ejs', {
                dataAgent: req.session.agent,
                dataContracts: data_contracts,
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
    else {
        return res.redirect('/');
    }
}
//
let getContractDetailpageNhanvien = async (req, res) => {
    return res.render('./agent/ContracDetails.ejs');
}
//
let getEmployeeContractpageNhanvien = async (req, res) => {
    return res.render('./agent/EmployeeContact.ejs');
}
//
let getEmployeePartnerpageNhanvien = async (req, res) => {
    return res.render('./agent/EmployeePartner.ejs');
}
//
let getProfilepageNhanvien = async (req, res) => {
    return res.render('./agent/info.ejs');
}
//
let getNotifypageNhanvien = async (req, res) => {
    return res.render('./agent/Notify.ejs');
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
//Test============================================================================================================================================================================================
let createSign_up = (req, res) => {
    console.log("check req : ", req.body)
    return res.send('call post create new user')
}
//
let getTest = (req, res) => {
    return res.render('./partner/Home.ejs');
}

//
module.exports = {
    getHomepage,
    getSignIn,
    getHomepageUser,
    getHomepageAdmin,
    getHomepageDoitac,
    getHomepageNhanvien,
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
    getOrderspageDriver,
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
    createSign_up,
    getTest
}