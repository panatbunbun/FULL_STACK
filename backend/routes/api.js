const express = require('express');
const rateLimit = require('express-rate-limit');
 
const apiLimiter = rateLimit({
    windowMs: 1000*60*3,   // 3 minutes
    max: 100,
    message: 'Too many requests, please try again after 3 minutes!'
});
const router = express.Router();
const customerController = require('../controllers/customers');
 
router.post('/customers', apiLimiter, customerController.createCustomer);
router.put('/customers/:id', apiLimiter, customerController.updateCustomer);
router.delete('/customers/:id', apiLimiter, customerController.deleteCustomer);
router.get('/customers/:id', customerController.getCustomer);
//router.get('/customers/q/:term', apiLimiter, customerController.getCustomersByTerm);
router.get('/customers', apiLimiter, customerController.getCustomers);
 
module.exports = router;