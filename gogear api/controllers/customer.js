const asyncHandler = require("../middleware/async");
const Customer = require("../models/customer");
const path = require("path");
const fs = require("fs");
const Customers = require("../models/customer");

// @desc    Get all students
// @route   GET /api/v1/students
// @access  Private

exports.getCustomers = asyncHandler(async (req, res, next) => {
  const customers = await Customers.find({});
  res.status(200).json({
    success: true,
    count: customers.length,
    data: customers,
  });
});

// @desc    Get single student
// @route   GET /api/v1/students/:id
// @access  Private

exports.getCustomer = asyncHandler(async (req, res, next) => {
  const customer = await Customer.findById(req.params.id);
  if (!customer) {
    return res
      .status(404)
      .json({ message: "Customer not found with id of ${req.params.id}" });
  } else {
    res.status(200).json({
      success: true,
      data: customer,
    });
  }
});

// @desc    Create new student
// @route   POST /api/v1/students
// @access  Public

exports.register = asyncHandler(async (req, res, next) => {
  const { username, email, password } = req.body;

  // Check if the customer already exists
  const customer = await Customer.findOne({ username });
  if (customer) {
    return res.status(400).send({ message: "Customer already exists" });
  }

  // Create a new customer object
  const newCustomer = new Customer({
    username,
    email,
    password,
  });

  // Save the customer to the database
  await newCustomer.save();

  // Return success response after saving the customer
  res.status(201).json({
    success: true,
    message: "Customer created successfully",
  });
});


// @desc   Login student
// @route  POST /api/v1/students/login
// @access Public

exports.login = asyncHandler(async (req, res, next) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res
      .status(400)
      .json({ message: "Please provide a username and password" });
  }

  // Check if student exists
  const customer = await Customer.findOne({ username }).select("+password");

  if (!customer || !(await customer.matchPassword(password))) {
    return res.status(401).json({ message: "Invalid credentials" });
  }

  sendTokenResponse(customer, 200, res);
});

//=========================== Searching ===========================

// @desc    Search student by batch
// @route   GET /api/v1/students/search/:batchId
// @access  Private



// @desc    Search student by course
// @route   GET /api/v1/students/search/:courseId
// @access  Private


// @desc Upload Single Image
// @route POST /api/v1/auth/upload
// @access Private

exports.uploadImage = asyncHandler(async (req, res, next) => {
  // // check for the file size and send an error message
  // if (req.file.size > process.env.MAX_FILE_UPLOAD) {
  //   return res.status(400).send({
  //     message: `Please upload an image less than ${process.env.MAX_FILE_UPLOAD}`,
  //   });
  // }

  if (!req.file) {
    return res.status(400).send({ message: "Please upload a file" });
  }
  res.status(200).json({
    success: true,
    data: req.file.filename,
  });
});

// Get token from model , create cookie and send response
const sendTokenResponse = (Customer, statusCode, res) => {
  const token = Customer.getSignedJwtToken();

  const options = {
    //Cookie will expire in 30 days
    expires: new Date(
      Date.now() + process.env.JWT_COOKIE_EXPIRE * 24 * 60 * 60 * 1000
    ),
    httpOnly: true,
  };

  // Cookie security is false .if you want https then use this code. do not use in development time
  if (process.env.NODE_ENV === "proc") {
    options.secure = true;
  }
  //we have created a cookie with a token

  res
    .status(statusCode)
    .cookie("token", token, options) // key , value ,options
    .json({
      success: true,
      token,
    });
};
