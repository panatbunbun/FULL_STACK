const { PrismaClient } = require('@prisma/client');
const e = require('express');
const prisma = new PrismaClient();

//create a new customer
const createCustomer = async (req, res) => {
    const { customer_id, first_name, last_name, email, address, phone_number } = req.body;
    try {
        //create a new customer
        const cust = await prisma.customers.create({
            data: {
                customer_id,
                first_name,
                last_name,
                email,
                address,
                phone_number
            }
        });
        //return the newly created customer
        res.status(200).json({
            status: "ok",
            message: `User with ID = ${cust.customer_id} is created successfully`,
        });
    } catch (err) {
        //return an error if the customer is fail
        res.status(500).json({
            status: "error",
            message: "Failed to create user",
            error: err.message,
        });
    }
};

//get all customers

const getCustomers = async (req, res) => {
    const custs = await prisma.customers.findMany(); //ค้นหาข้อมูลลูกค้าทั้งหมด
    res.json(custs);
}

//delete a customer
const deleteCustomer = async (req, res) => {
    const id = req.params.id;
    try {
        const existingCustomer = await prisma.customers.findUnique({
            where: {
                customer_id: Number(id),
            },
        });
        //ถ้าไม่มีข้อมูลลูกค้า
        if (!existingCustomer) {
            return res.status(404).json({ message: `Customer not found` });
        }
        //ลบข้อมูลลูกค้า
        await prisma.customers.delete({
            where: {
                customer_id: Number(id),
            },
        });
        //ส่งข้อความว่าลูกค้าถูกลบ
        res.status(200).json({
            status: "ok",
            message: `User with ID = ${id} is deleted `,
        });

    } catch (err) {
        console.error('Delete user error:', err);
        res.status(500).json({ error: err.message });//ส่งข้อผิดพลาด
    }
}

//get customer by id
const getCustomer = async (req, res) => {
    const id = req.params.id;
    try {
        const cust = await prisma.customers.findUnique({ //ค้นหาข้อมูลลูกค้าโดยใช้ id
            where: {
                customer_id: Number(id),
            },
        });
        if (!cust) {
            return res.status(404).json({ 'message': `Customer not found` }); //ถ้าไม่มีข้อมูลลูกค้า
        } else {
            res.status(200).json(cust); //ส่งข้อมูลลูกค้า
        }
    } catch (err) {
        console.error('Get user error:', err);
        res.status(500).json(err);
    }
};

const updateCustomer = async (req, res) => {
    const { first_name, last_name, email, address, phone_number } = req.body;
    const { id } = req.params;//รับค่า id จาก url
    const data = {};
    if (first_name) data.first_name = first_name;
    if (last_name) data.last_name = last_name;
    if (email) data.email = email;
    if (address) data.address = address;
    if (phone_number) data.phone_number = phone_number;

    if (Object.keys(data).length === 0) {
        return res.status(400).json({
            status: 'error',
            message: 'Data is empty'
        });
    }

    try {
        const cust = await prisma.customers.update({
            data,
            where: {
                customer_id: Number(id),
            },
        });
        res.status(200).json({
            status: 'ok',
            message: `User with ID = ${id} is updated successfully`,
            user: cust,
        });
    }
    catch (err) {
        if (err.code === 'P2002') {
            res.status(400).json({
                status: 'error',
                message: 'Emailaddress already exists',
            });
        } else if (err.code === 'P2025') {
            res.status(400).json({
                status: 'error',
                message: `User with ID = ${id} not found`,
                error: err.message,
            });
        } else {
            res.status(500).json({
                status: 'error',
                message: 'Failed to update user',

            }
            );
        }
    }
}


module.exports = {
    createCustomer, getCustomers, deleteCustomer, getCustomer, updateCustomer
};