const functions = require('firebase-functions');
const admin = require('firebase-admin');
 
admin.initializeApp(functions.config().functions);
 
var newData;
 
exports.myTrigger = functions.firestore.document('notifications/{messageid}').onCreate(async (snapshot, context) => {
    //
 
    if (snapshot.empty) {
        console.log('No Devices');
        return;
    }
 
    newData = snapshot.data();
 
    var tokens = [];
 
    tokens.push(newData['deviceid']);
    
    var payload = {
        notification: {
            title: newData['sendby'],
            body: newData['message'],
            sound: 'default',
        }
    };
 
    try {
        const response = await admin.messaging().sendToDevice(tokens, payload);
        console.log('Notification sent successfully');
    } catch (err) {
        console.log(err);
    }
});