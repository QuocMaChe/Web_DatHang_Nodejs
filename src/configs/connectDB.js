import sql from "mssql/msnodesqlv8";

// database configuration
const config = {
    server: 'ADMIN\\SQLEXPRESS',
    //user:'',
    //password:'',
    database: 'DOAN_HQTCSDL',
    driver: 'msnodesqlv8',
    options: {
        trustedConnection: true,
    }
}
// connect to database
const pool = new sql.ConnectionPool(config);

export default pool;
