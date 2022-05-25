const functions = require("firebase-functions");

const braintree = require('braintree');

const gateway = new braintree.BraintreeGateway({
    environment: braintree.Environment.Sandbox,
    merchantId: 'gkmp5b3ry9wxxwvq',
    publicKey: 'rpt6rzg3rjsyy6t2',
    privateKey: '0171e854b06c9bebe3331bce3e212d5c'
});

exports.paypalPayment = functions.https.onRequest(async (req, res) => {
    const nonceFromTheClient = req.body.payment_method_nonce;
    const deviceData = req.body.device_data;

    gateway.transaction.sale({
        amount: '10.00',
        paymentMethodNonce: 'fake-paypal-one-time-nonce',
        deviceData: deviceData,
        options: {
            submitForSettlement: true
        }
    }, (err, result) => {
        if (err != null) {
            console.log(err);
        }
        else {
            res.json({
                result: 'success'
            });
        }
    });
});