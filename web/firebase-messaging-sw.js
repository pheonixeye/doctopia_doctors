// const channel = new BroadcastChannel('sw-messages');

// function handleClick(event) {
//   if ('FCM_MSG' in event.notification.data) {
//     channel.postMessage(
//       { 'fcm_data': event.notification.data.FCM_MSG, 'clicked': 'true' }
//     );
//   }
// }

// self.addEventListener('notificationclick', handleClick);

importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyB8zG45ojV_GHfInJfi8nSsSR8vAfDAE5E",
  authDomain: "proklinik.firebaseapp.com",
  projectId: "proklinik",
  storageBucket: "proklinik.appspot.com",
  messagingSenderId: "996546589832",
  appId: "1:996546589832:web:77721870dbe02c42079b3d"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((payload) => {
  const title = payload.notification.title;
  const body = payload.notification.body;
  self.registration.showNotification(title, {
    body,
    icon: '/icons/android-chrome-192x92.png',
  });
  console.log('[firebase-messaging-sw.js] Received background message ');
});
console.log('firebase-messaging-sw.js => Registered.');