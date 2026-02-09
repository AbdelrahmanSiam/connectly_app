const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendChatNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snapshot, context) => {
    try {  // ✅ إضافة try-catch
      const message = snapshot.data();
      const chatId = context.params.chatId;

      const receiverId = message.receiverId;
      const senderId = message.senderId;  // ✅ إضافة
      
      // ✅ تجنب إرسال notification للمرسل نفسه
      if (receiverId === senderId) {
        console.log("Sender and receiver are the same, skipping notification");
        return null;
      }

      const senderName = message.senderName;
      const text = message.text;

      const userDoc = await admin.firestore()
        .collection("users")
        .doc(receiverId)
        .get();

      if (!userDoc.exists) {
        console.log("User not found:", receiverId);
        return null;
      }

      const token = userDoc.data().fcmToken;
      if (!token) {
        console.log("No FCM token for user:", receiverId);
        return null;
      }

      const payload = {
        notification: {
          title: senderName,
          body: text,
        },
        data: {
          chatId: chatId,
          senderId: senderId,  // ✅ مفيد للـ navigation
        },
      };

      const response = await admin.messaging().sendToDevice(token, payload);
      console.log("Notification sent successfully:", response);  // ✅ logging
      return response;
      
    } catch (error) {
      console.error("Error sending notification:", error);
      return null;
    }
  });
