"""<div id="portalLink">
                <a class="genu" onclick="StackExchange.ready(function(){genuwine.click();});return false;">Stack Exchange</a><a class="unreadCount" title="unread messages in your inbox" style="margin-top: 3px; opacity: 1;">1</a>
            </div>
"""
default_check_period = 5 * 60 * 1000
set_text = (text) ->
  chrome.browserAction.setBadgeText({text: "#{text}"})

show_notification = (icon,title,text) ->
  notif = webkitNotifications.createNotification(icon, title, text)
  notif.show()

check_stack = ->
  console.log "doing request"
  req = $.get "http://www.stackoverflow.com/",(data) ->
    $unread = $("#portalLink a.unreadCount",data)
    unread  = $unread.html()
    set_text(unread) if unread?
    setTimeout(check_stack, default_check_period)
  req.error (a,b,c) ->
    alert "Error accessing SO"
    setTimeout(check_stack, 2 * default_check_period)

set_text("")
check_stack()
