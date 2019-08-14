`use strict`
const admin = require('firebase-admin');
const functions = require('firebase-functions');
const firebase_tools = require('firebase-tools');

admin.initializeApp();
const store = admin.firestore();

// update sticky in some day 
exports.updateDaysOnCreate = functions.firestore.document("/users/{uid}/stickies/{stickyId}").onCreate((snapshot, context) => {
    const uid = context.params.uid;
    const stickyId = context.params.stickyId;
    const createTime = snapshot.get("create_time");
    const stickyRef = store.doc(`/users/${uid}/days/${createTime}/stickies/${stickyId}`);
    stickyRef.set({
        ref: store.doc(`/users/${uid}/stickies/${stickyId}`),
    });
});

// update sticky in some day 
exports.updateDaysOnDelete = functions.firestore.document("/users/{uid}/stickies/{stickyId}").onDelete((snapshot, context) => {
    const uid = context.params.uid;
    const stickyId = context.params.stickyId;
    const createTime = snapshot.get("create_time");
    const stickyRef = store.doc(`/users/${uid}/days/${createTime}/stickies/${stickyId}`);
    stickyRef.delete();
});

// init user profile
exports.initUserProfile = functions.auth.user().onCreate((user) => {
    user.displayName = user.email.substring(0, user.email.indexOf('@'));
});

// delete user all data
exports.deleteUserData = functions.auth.user().onDelete((user) => {
    const userDataPath = "/users/" + user.uid;
    // store.doc(userDataPath).delete();
    firebase_tools.firestore
        .delete(userDataPath, {
            project: process.env.GCLOUD_PROJECT,
            recursive: true,
            yes: true,
        })
        .then(() => {
            return {
                path: path
            };
        });
});