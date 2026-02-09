const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendChatNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snapshot, context) => {
    try {
      const message = snapshot.data();
      const chatId = context.params.chatId;

      console.log("📨 New message created:", {
        chatId,
        messageId: context.params.messageId,
        senderId: message.senderId,
        receiverId: message.receiverId,
        senderName: message.senderName,
      });

      const receiverId = message.receiverId;
      const senderId = message.senderId;

      // تجنب إرسال notification للمرسل نفسه
      if (receiverId === senderId) {
        console.log("❌ Sender and receiver are the same");
        return null;
      }

      const senderName = message.senderName;
      const text = message.text;

      // جلب بيانات المستقبل
      const userDoc = await admin.firestore()
        .collection("users")
        .doc(receiverId)
        .get();

      if (!userDoc.exists) {
        console.log("❌ User not found:", receiverId);
        return null;
      }

      const token = userDoc.data().fcmToken;
      
      if (!token) {
        console.log("❌ No FCM token for user:", receiverId);
        return null;
      }

      console.log("✅ Sending notification to token:", token);

      const payload = {
        notification: {
          title: senderName,
          body: text,
        },
        data: {
          chatId: chatId,
          senderId: senderId,
        },
      };

      const response = await admin.messaging().sendToDevice(token, payload);
      
      console.log("✅ Notification sent successfully:", response);
      console.log("   Success count:", response.successCount);
      console.log("   Failure count:", response.failureCount);
      
      if (response.failureCount > 0) {
        console.log("❌ Failed results:", response.results);
      }

      return response;
    } catch (error) {
      console.error("❌ Error sending notification:", error);
      return null;
    }
  });