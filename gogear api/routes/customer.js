const express = require("express");
const router = express.Router();
const { protect } = require("../middleware/auth");

const upload = require("../middleware/uploads");

const {
  getCustomers,
  getCustomer,
  register,
  login,
  uploadImage,
} = require("../controllers/customer");

router.post("/uploadImage", upload, uploadImage);
router.post("/register", register);
router.post("/login", login);
router.get("/getCustomer", protect, getCustomer);
router.get("/getAllCustomers", getCustomers);


module.exports = router;
