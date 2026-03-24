const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendChatNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snapshot, context) => {
    console.log("🔔 Function triggered!");
    
    try {
      const message = snapshot.data();
      const chatId = context.params.chatId;
      const messageId = context.params.messageId;

      console.log("📨 Message data:", {
        chatId,
        messageId,
        senderId: message.senderId,
        receiverId: message.receiverId,
        senderName: message.senderName,
        text: message.text,
      });

      const receiverId = message.receiverId;
      const senderId = message.senderId;

      // Check if sender and receiver are different
      if (receiverId === senderId) {
        console.log("❌ Sender and receiver are the same, skipping");
        return null;
      }

      const senderName = message.senderName;
      const text = message.text;

      console.log(`🔍 Fetching user doc for: ${receiverId}`);

      // Get receiver's FCM token
      const userDoc = await admin.firestore()
        .collection("users")
        .doc(receiverId)
        .get();

      if (!userDoc.exists) {
        console.log(`❌ User not found: ${receiverId}`);
        return null;
      }

      const userData = userDoc.data();
      const token = userData.fcmToken;

      console.log(`📱 User data:`, {
        userId: receiverId,
        name: userData.name,
        email: userData.email,
        hasToken: !!token,
        token: token ? `${token.substring(0, 20)}...` : null,
      });

      if (!token) {
        console.log(`❌ No FCM token for user: ${receiverId}`);
        return null;
      }

      const payload = {
        notification: {
          title: senderName,
          body: text,
        },
        data: {
          chatId: chatId,
          senderId: senderId,
          click_action: "FLUTTER_NOTIFICATION_CLICK",
        },
      };

      console.log("📤 Sending notification:", payload);

      const response = await admin.messaging().sendToDevice(token, payload);

      console.log("✅ Notification sent!");
      console.log("   Success count:", response.successCount);
      console.log("   Failure count:", response.failureCount);

      if (response.failureCount > 0) {
        console.log("❌ Failures:", JSON.stringify(response.results, null, 2));
      }

      return response;
    } catch (error) {
      console.error("❌ Error in function:", error);
      return null;
    }
  });