const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendChatNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snapshot, context) => {

    const message = snapshot.data();
    const chatId = context.params.chatId;

    const receiverId = message.receiverId;
    const senderName = message.senderName;
    const text = message.text;

    const userDoc = await admin.firestore()
      .collection("users")
      .doc(receiverId)
      .get();

    if (!userDoc.exists) return;

    const token = userDoc.data().fcmToken;
    if (!token) return;

    const payload = {
      notification: {
        title: senderName,
        body: text,
      },
      data: {
        chatId: chatId,
      },
    };

    await admin.messaging().sendToDevice(token, payload);
  });
