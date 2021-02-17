function UpdateAppUnreadAdd(app, unread)
    SendNUIMessage({
        action = 'updateUnread',
        app = app,
        unread = unread,
    })
end