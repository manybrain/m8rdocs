---
title: Mailinator API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

toc_footers:
  - <a href='https://www.mailinator.com/v3/#/#pricing_table_pane'>Subscribe for Mailinator API access</a>

includes:
  - errors

search: true
---

# Introduction

The Mailinator API provides programmatic access to fetching and injecting messages into the Mailinator system. From there those messages will run through a subscriber's ruleset to determine the final destination(s) of that incoming message. Messages are typically (and historically) email messages, however, that is by no means a restriction. Any data with the general format of to, from, subject, and (optionally) body are applicable. This includes (at least) email, SMS, Http Post messages.

Subscribers can read messages in both the Public and their own Private Mailinator email systems with the API. They may also inject messages but only to their Private Mailinator domains.

In addition to message focused APIs, the API allows a programmatic to create and delete message routing rules (This may also be done in the Mailinator Web Interface).

Access to the API (and messages in general) are subject to your subscription plan's rate limits.

# Authentication

> To authorize, use this code:


```shell
# REST calls require your team's API token in every call
curl "api_endpoint_here?token=YourTeamAPIToken"
```

> Replace YourTeamAPIToken with the API Token found on your Team's settings page

Mailinator uses API tokens for authentication. All calls to the API must include the token query parameter

<aside class="notice">
You must replace <code>YourTeamAPIToken</code> with the API token found on your team's settings page
</aside>

# Messages

## Inbox

```shell
curl "http:/api/inbox?token=YourTeamAPIToken&to=joe"
```

> The above command returns the list of messages for the Inbox <b>joe</b>.
> It returns JSON structured like this:

```json
{
"to": "joe"
"messages" : [
        {
            "from": "Fit-X",
            "fromfull": "noreply@fitx.com",
            "id": "joe-1551548025-3982989",
            "origfrom": "Fitx <noreply@fitx.com>",
            "seconds_ago": 138,
            "subject": "Important information about your enquiry",
            "time": 1551548025000,
            "to": "joe"
        },
        {
            "from": "Wireless Charging",
            "fromfull": "WirelessTest@egtest.com",
            "id": "joe-1551548117-3983825",
            "origfrom": "Wireless Charging <wirelesstest@egtest.com>",
            "seconds_ago": 46,
            "subject": "Don't Throw Your Phone Away Just Yet! You can fix it.",
            "time": 1551548117000,
            "to": "joe"
        }
     ]
}
```

This endpoint retrieves both public and private-domain inboxes

### HTTP Request

`GET http://api.mailinator.com/api/inbox`

### Query Parameters

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
token | false | true | You must provide your API token with each request
to | false | public only | The inbox you wish to fetch<br>This may be a wildcard (i.e. <b>test*</b>) for fetching from your private domain<br>To fetch from a private domain, append the domain to this parameter (i.e. joe@myprivatedomain.com)<br>Public email fetches should only include the inbox itself
     
   Example **Public domain** (i.e. @mailinator.com) inbox fetchs:
    <br>
    &nbsp;
    &nbsp;
    &nbsp;    
    `https://api.mailinator.com/api/inbox?to=bob&token=YourTeamAPIToken`
    <br>
    &nbsp;
    &nbsp;
    &nbsp;    
    `https://api.mailinator.com/api/inbox?to=testaccount1234&token=YourTeamAPIToken`
    <br>
    <br>
    Example **Private Domain** inbox fetchs:
    <br>
    &nbsp;
    &nbsp;
    &nbsp;    
    `https://api.mailinator.com/api/inbox?to=testinbox@myprivatedomain.com&token=YourTeamAPIToken`
    <br>
    &nbsp;
    &nbsp;
    &nbsp;    
    `https://api.mailinator.com/api/inbox?to=test*&token=YourTeamAPIToken`


## Fetch a specific message


```shell
curl "https://api.mailinator.com/api/message?token=YourAPIToken&id=joe-1551548025-3982989"
```

> The above command returns JSON structured like this:

```json
{
    "data": {
        "requestId": "425041",
        "seconds_ago": 263,
        "subject": "Don't Throw Your Phone Away Just Yet! You can fix it.",
        "time": 1551549255000,
        "to": "joe"
        "from": "Wireless Charging",
        "fromfull": "WirelessTest@egtest.com",
        "headers": {
            "content-type": "multipart/alternative; boundary=\"d9f1e7876ccd20ca69a4286c31823fa2\"",
            "date": "Sat, 2 Mar 2019 12:51:10 -0500",
            "from": "\"Wireless Charging\" <WirelessTest@egtest.com>",
            "message-id": "<0ockv6sqfejl43fl-wlc9g9fho39kkla1-652@egtest.com>",
            "mime-version": "1.0",
            "received": "from ([50.3.73.178])\r\n        by mail.mailinator.com with SMTP (Postfix)\r\n",
            "reply-to": "\"Wireless Charging\" <WirelessTest@egtest.com>",
            "subject": "Don't Throw Your Phone Away Just Yet! You can fix it.",
            "to": "<joe@mailinator.com>"
        },
        "id": "joe-1551549255-4004891",
        "origfrom": "Wireless Charging <wirelesstest@egtest.com>",
        "parts": [
            {
                "body": "Fix your phone now!",
                "headers": {
                    "content-type": "text/plain;"
                }
            },
            {
                "headers": {
                    "content-transfer-encoding": "8bit",
                    "content-type": "text/html;"
                }
              "body": "<html><body>Fix your phone now!</body></html>",
            }
        ],
    }
}

```

This endpoint retrieves a specific message by id.

`GET http://api.mailinator.com/api/message`

### Query Parameters

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
token | false | true | You must provide your API token with each request
id | false | true | The message id (usually found in a previous inbox api call) to retrieve


## Delete a Message


```shell
curl "https://api.mailinator.com/api/delete?token=YourTeamAPIToken&id=joe-1551548025-3982989"
```

> The above command returns JSON structured like this:

```json
{
  "status": "ok",
}
```

This endpoint deletes a specific message.

### HTTP Request

`DELETE https://api.mailinator.com/api/delete<ID>`

### URL Parameters

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
token | false | true | You must provide your API token with each request
id | false | true | The message id (usually found in a previous inbox api call) to delete
delete_all | false | false | if **delete_all=true** is specified, ALL email will be deleted from your Team's private domain		


