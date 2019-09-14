---
title: Mailinator Documentation

<style>
  code {
      color: #fff;
      background-color:#000;
  }
  </style>

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

toc_footers:
- <a href='https://www.mailinator.com/'>Mailinator Home</a>

- <a href='https://www.mailinator.com/v3/#/#pricing_table_pane'>Subscribe for Mailinator API access</a>

search: true
---
# Mailinator

Mailinator is an email system that accepts email for any inbox with no sign-up, login, or account creation involved. Whereas most email systems revolve around "account ownership" which is centered on a given inbox (e.g. your_email@gmail.com), Mailinator is centered around entire domains.

## Public Mailinator

The public Mailinator system (i.e. every possible email address @mailinator.com) creates inboxes when email arrives for them. All inboxes (and emails) are in the public domain and readable and deleteable by anyone. By design, there is NO privacy in the public Mailinator system and is intended for occasional, personal use.

In addition, all emails in the public Mailinator sytem auto-delete after a few hours. They are un-retrievable after this happens.

Finally, it's important to note that the Mailinator system is RECEIVE-ONLY. <b>No one can send an email from Mailinator.</b> (Any email appearing to have arrived from an @mailinator address has had it's "From" field forged to appear as such).

There is no need to sign-up to use the public Mailinator system. Simply go to the home page and enter an inbox name (i.e. anything you wish up to 50 characters) to check a particular inbox.

Again, the public Mailinator is intended for personal and occasional use hence usage limits apply. Please see our Upgrade plans for corporate users.

## Private Mailinator

Mailinator offers upgraded subscriptions for corporate users wishing to use the Mailinator system. This offers many benefits.

Subscribers receive one or more "Private Domains" which provide a private version of Mailinator. That is, you control all inboxes for a given domain (i.e. either one your provide or the system will provide one for you). You may view all such inboxes in one "super inbox" which lists every email coming into the domain in realtime. Emails in Private domains are not automatically deleted until your team's storage is exhausted. At this time, new emails push out old emails. Otherwise, emails in private domains are persistent as long as the account is active.

In addition, Private users gain API access to messages within the Mailinator system. Subscribers may use the API to access all email in their Private Domain(s) in addition to the Public Mailinator system.

# Message Access

## Web

The web interface is available for all Public and Private email in the Mailinator system. Subscribers must login first in order to see their Private Team Inbox containing mail sent to their Private Domain(s).

## API

Subscribers may use programmatic access to poll inboxes and retrieve emails in JSON format. Documentation for the API can be found below.

## Rules

Instead of pulling emails via the API, Subscribers may set rules for Mailinator to "push" messages to them as they arrive. The rule system may be configured via the Web interface (i.e. Mailinator Routing Rules) or programmatically via the API (see API documentation below).

The Rule system allows subscribers to match on inbox and act upon every email that matches the conditional criteria.

<img src='images/ruleshot.png' alt="Rule Creation Dialog">

For example, a rule might be:

IF <b>TO = joe</b> THEN <b>Post Webhook To https://mywebsite.com/endpoint</b>

For a given Private domain, all emails that arrive to the "joe" inbox will be converted to JSON, and HTTP Posted to the designated endpoint.

Note that the Rule System is only available for Private Domains at this time. For more information on configuring Rules, see the Rules API documentation below (The Mailinator Web interface is merely a front-end for this API).

# Setting up your Mailinator Subscription

Thanks for being a Mailinator subscriber! This section will show you some immediate ways to get the most out of your Mailinator subscritpion.

You now (yes, already) have a Private domain. Every conceivable inbox is waiting for you to send email to it. Unlike the public Mailinator system however, you won't run into rate-limits or filters. The email at that domain is private to you.

When your subscription became active, a subdomain of Mailinator was created and assigned to your account as your private domain. For example, your initial private domain would be something like @you-yourcompany.mailinator.com. So any email to anything@you-yourcompany.mailinator.com will arrive in your private domain. On the left of the Web User Interface you'll see "Private Team Inbox". If you click that you'll be taken to the web interface fo r your private domain. Unlike Public Mailinator inboxes, you can see ALL incoming email to all inboxes at once! The inbox field in the upper right allows you to filter that incoming stream. 

To see what your current Private Domain is, go the Team Settings section of the Web interface and you'll see it listed. You can leave it as is, change it to another subdomain, or even put in a domain you already own (you must change the DNS record MX to point to our servers for this to work).

On the Team Settings page, you'll also notice your API token. This token allows you to access all email in Mailinator (public and private) via API instead of the Web. See our API documentation below.

The Team Management screen allows you to add co-workers to your account so they too can access your private domain emails. Also, checkout the Message Routing Rules system. While it's great to read emails via the web or API, Mailinator will push emails to you via webhooks. You can set this up in the Rules System.

Thanks for using Mailinator and feel free to browse this documentation. As always, if you have any questions, email us at support@manybrain.com.


# The Mailinator API

The Mailinator API provides programmatic access to the Mailinator system. This includes fetching and injecting messages into the Mailinator system and creating routing rules for specific message streams within the system. Messages are typically (and historically) email messages. Hence the format of messages tend to look like emails but in reality any message can be fed, routed, and read or delivered through the system. In a broader scope messages generally arrive via email, SMS, or direct HTTP Post.

Subscribers can read messages in both the Public and their own Private Mailinator email systems with the API. They may also route/inject messages but only to their Private Mailinator domains.

Access to the API (and messages in general) are subject to your subscription plan's rate limits.


## Definitions

- <b>Messages</b>

Messages within Mailinator are typically thought of as emails - however, messages can enter the system in a variety of ways including email, SMS, or HTTP Post. In general, the schema of messages contains a TO, FROM, SUBJECT, and message body. Message bodies can be simple string of text or as is allowed by email standards, a complicated multi-part, multi-encoded schema.

- <b>Private Domains / Streams</b>

Streams identify a specific source for messages. Emails automatically are assigned to the domain of their "to" address. Expectedly, each of your Private Domains represent a specific source for messages. Incoming SMS messages arrive to the reserved stream of <b>SMS</b>. 

Stream Name | Description
----------- | -----------
SMS | Any message arriving to one of your account's SMS inboxes are assigned to this stream
Each Private Domain | Each of your private domains has it's own stream and consequently, an available individual rule set

- <b>Destinations</b>

Mailinator routing rules allow immediate routing actions to take place on incoming messages. For example, you may wish to designate all incoming email messages to "Joe@YourPrivateDomain.com" should be forwarded to your work email. You could also designate that all incoming messages to "Bob@YourPrivateDomain.com" should be Posted via WebHook to an endpoint on your testing server.

You may define a set of Destinations to be reused by your rules.

## API Authentication

> To authorize, use this code:


```shell
# REST calls require your team's API token in every call
curl "https://api.mailinator.com/api_endpoint_here?token=YourTeamAPIToken"
```
>or

```shell
curl --header "Authorization: YourTeamAPIToken" 
     "https://api.mailinator.com/api_endpoint_here" 
```

> Replace YourTeamAPIToken with the API Token found on your Team's settings page

Mailinator uses API tokens for authentication. All calls to the API must include the token query parameter OR included as an HTTP Authorization header.

<aside class="notice">
You must replace <b>YourTeamAPIToken</b> with the API token found on your Team's Settings page
</aside>

## Message API

### Fetch Inbox

```shell
curl "https://api.mailinator.com/api/inbox?token=YourTeamAPIToken&to=joe"
```

> The above command returns the list of messages for the Inbox <b>joe</b>.
> It returns JSON structured like this:

```json
{ 
 "to": "joe",
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
    
#### HTTP Request
  
GET https://api.mailinator.com/api/inbox
    
#### Query Parameters
    
Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
token | false | true | You must provide your API token with each request
    to | false | no | The inbox you wish to fetch<br>
   private_domain | false | no | fetch from your Private Domain (not public Mailinator)
   skip | 0 | no | skip this many emails in your Private Domain
   limit | 50 | no | number of emails to fetch from your Private Domain  
    <br>
    To fetch from a private domain, append the domain to this parameter (i.e. joe@myprivatedomain.com)<br>Public email fetches should only include the inbox itself<br>
    <br>
    This may be a wildcard (i.e. <b>test*</b>) for fetching from your private domain<br>

     
Example **Public domain** (i.e. @mailinator.com) inbox fetchs:
<br>
    &nbsp;
    &nbsp;
    &nbsp;    
    https://api.mailinator.com/api/inbox?to=bob&token=YourTeamAPIToken
<br>
    &nbsp;
    &nbsp;
    &nbsp;    
    https://api.mailinator.com/api/inbox?to=testaccount1234&token=YourTeamAPIToken
<br>
<br>
Example **Private Domain** inbox fetchs:
<br>
    &nbsp;
    &nbsp;
    &nbsp;    
https://api.mailinator.com/api/inbox?to=testinbox@myprivatedomain.com&token=YourTeamAPIToken
    <br>
    &nbsp;
    &nbsp;
    &nbsp;    
https://api.mailinator.com/api/inbox?to=test*&token=YourTeamAPIToken


### Fetch a message
    
    
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
        "to": "joe",
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
                },
              "body": "<html><body>Fix your phone now!</body></html>"
            }
        ]
    }
}

```

This endpoint retrieves a specific message by id.

GET https://api.mailinator.com/api/message

#### Query Parameters

Parameter | Default | Required | Description
	      --------- | ------- | -------- | -----------
token | false | true | You must provide your API token with each request
id | false | true | The message id (usually found in a previous inbox api call) to retrieve


### Delete a Message
```shell
curl "https://api.mailinator.com/api/delete?token=YourTeamAPIToken&id=joe-1551548025-3982989"
```

> The above command returns JSON structured like this:

```json
{
  "status": "ok"
}
```
	      
This endpoint deletes a specific message.
      
#### HTTP Request
     
GET https://api.mailinator.com/api/delete
	      
#### URL Parameters
	      
Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
token | false | true | You must provide your API token with each request
id | false | true | The message id (usually found in a previous inbox api call) to delete
delete_all | false | false | if **delete_all=true** is specified, ALL email will be deleted from your Team's private domain		
	      

## Streams API
Several Streams are automatically created for you including ALL, SMS, and one for each of your private domains. You can also access streams without explicitly creating them, however you cannot assign rules to adhoc streams. You may add or replace Private Domains in your Team Settings panel.

<aside class="notice">
In general, "Streams" are synonymous with "Private Domains". When you add or delete a Private Domain, a corresponding Stream is also added or deleted.
</aside>

### Get All Streams
```shell
curl "https://api.mailinator.com/streams"
```

> The above command returns JSON showing the newly created Stream:

```json
{ 
  "streams" : 
     [
	     {
	       "_id": "5c9602f5e881b5fbe91c754a",
         "description": "Stream representing some testing",
         "enabled": true,
         "name": "my.test.stream",
         "ownerid": "59188558619b4f3879751781",
         "rules": []
	     }
	   ]
}
```

The endpoint fetches a list of all your streams. 

#### HTTP Request

GET https://api.mailinator.com/streams/
	      
### Get Stream
```shell
curl "https://api.mailinator.com/streams/:stream_id"
```

> The above command returns JSON showing the newly created Stream:

```json
{
   "_id": "5c9602f5e881b5fbe91c754a",
   "description": "Stream representing some testing",
   "enabled": true,
   "name": "my.test.stream",
   "ownerid": "59188558619b4f3879751781",
   "rules": []
}
```

The endpoint fetches a specific stream

#### HTTP Request

GET https://api.mailinator.com/streams/:stream_id
	      
#### PATH 

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
	      :stream_id | (none) | true | This must be the Stream *name* or the Stream *id*


## Rules API
You may define stream-specific rules to process incoming messages. Rules are executed in priority order (Rules with equal priority run simultaneously).

Rules contain one or more conditions and one or more actions.
### Rules Schema

> Example:

```json
{
   "_id": "5c9602f5e881b5fbe91c754a",
   "description": "Rule to post all incoming mail starting with test* to my webhook",
   "enabled": true,
   "name": "testprefixpost",
   "conditions": [
      {
        "operation": "PREFIX",
        "field": "to",
        "value": "test"
      }
   ],
   "actions": [
      {
        "action" : "WEBHOOK",
        "destination": "my_webhook1"
      }
   ]
}
```

Field | User Modifiable | Description
----- | ----------- | -----------
_id | no | System generated, unique Rule Id. You may use this ID to query a specific rule
name | yes | Names must be lowercase and 1-20 characters. They may only contain alphanumeric, dot, and underscore.
description | yes | 1-255 characters
enabled | yes | Enabled rules are immediately active.
match | yes | Indicates condition matching type - must be ANY, ALL, or ALWAYS_MATCH
priority | yes | An Integer between 1-99999 governing rule execution order. 1 is the highest priority, 99999 is the lowest.
conditions | yes | Conditions must be an array Conditions objects - see below
	      actions | yes | Actions must be an array of Actions objects - see below


<aside class="notice">
Note that <b>Conditions</b> and <b>Actions</b> make up IF and THEN in a classic if-statement. As in, <b>if CONDITION then ACTION</b>
</aside>

### Conditions Schema
	      Conditions are executed to determine if a particular incoming message matches this rule.
	      
#### Match Type
Match        | Description
------------ | -----------------------------------------
ANY          | Matches if ANY of the conditions are true 
ALL          | Matches if ALL of the conditions are true
ALWAYS_MATCH | Always matches
	      	      
#### Conditions Schema
Field |  Description | Valid Values
----- |  ----------- | ------------
operation | Comparison operation for field and value. | *EQUALS*, *PREFIX* 
field | The message field to compare. | *to*
value | The value to compare. | Any - E.g., "joe", "bob"

#### Condition Operations
Operation | Description
--------- | -------------------------------------
EQUALS    | Matches when the field (e.g. "to") exactly matches an inbox (e.g. "joe")
PREFIX    | Matches when the field (e.g. "to") starts with a string (e.g. "test" matches "test", "test1", "test9999")	     
	      
	      
### Actions Schema
Actions are executed if the condition set returns true

#### Actions Schema
Field       |  Description 
----------- |  -------------------------------------------------------- 
action      | Specific action to take if the rule condition was true 
action_data | A JsonObject containting action specific data (see below)

#### Actions
Action    | Description                                        | Action Data
--------- | -------------------------------------------------- | -----------
WEBHOOK   | POST JSON version of message to HTTP Rest Endpoint | url : your HTTP Rest Endpoint url
DROP      | Drop this email. No further rules will execute     |

<aside class='notice'>
A dropped email will not be saved in your Team Inbox. This is the only way to prevent an email from being saved in your Team Inbox (regardless of other rules that were executed)
</aside>

<aside class="notice">
A quick way to test webhooks is setup a free, disposable webhook at https://requestbin.com
</aside>


### Create Rule

> Create Rule

```shell
curl -H "content-type: application/json" 
     -X POST "https://api.mailinator.com/streams/:stream_id/rules/" 
     -d "@data.json"
```

> file: data.json

```json
{
   "description": "Rule to post all incoming mail starting with test* to my webhook",
   "enabled": true,
   "name": "testprefixpost",
   "conditions": [
      {
        "operation": "PREFIX",
        "field": "to",
        "value": "test"
      }
   ],
   "actions": [
      {
        "action" : "WEBHOOK",
        "action_data": {
           "url" : "https://www.mywebsite.com/restendpoint"
        }
      }
   ]
}
```

> The above command returns the created Rule:

```json
{
   "_id": "5c9602f5e881b5fbe91c754a",
   "description": "Rule to post all incoming mail starting with test* to my webhook",
   "enabled": true,
   "name": "testprefixpost",
   "conditions": [
      {
        "operation": "PREFIX",
        "field": "to",
        "value": "test"
      }
   ],
   "actions": [
      {
        "action" : "WEBHOOK",
        "action_data": {
           "url" : "https://www.mywebsite.com/restendpoint"
        }
      }
   ]
}
```

This endpoint allows you to create a Rule. Note that in the examples, ":stream_id" can be one of your private domains.

#### HTTP Request

POST https://api.mailinator.com/streams/:stream_id/rules/
	      
#### PATH 

Parameter | Default | Description
--------- | ------- | -----------
:stream_id | (none) | This must be the Stream *name* or the Stream *id* (i.e. your private domain)

#### POST Parameters

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
name | (none) | true | Names must be lowercase and 1-15 characters. They may only contain alphanumeric, dot, and underscore.
description | (none)  | false | 1-255 characters
enabled | true | false | Rules create enabled are immediately active.
match | ALL | false | Indicates condition matching type - must be ANY or ALL
priority | (none) | true | An Integer between 1-99999 governing rule execution order. 1 is the highest priority, 99999 is the lowest.
conditions | (none) | true | Conditions must be an array Conditions objects 
actions | (none) | true | Actions must be an array of Actions objects 

<aside class="notice">
Creating rules with enabled:true activates them immediately
</aside>

### Enable Rule
```shell
curl -X PUT "https://api.mailinator.com/streams/:stream_id/rules/:rule_id/enable"
```

> The above command returns JSON::

```json
{
   "status": "ok"
}
```

This endpoint allows you to enable an existing Rule

#### HTTP Request

PUT https://api.mailinator.com/streams/:stream_id/rules/:rule_id/enable
	      
#### PATH 

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
:stream_id | (none) | true | This must be the Stream *name* or the Stream *id*
:rule_id | (none) | true | This must be the Rule *name* or the Stream *id*






### Disable Rule
```shell
curl -X PUT "https://api.mailinator.com/streams/:stream_id/rules/:rule_id/disable"
```

> The above command returns JSON::

```json
{
   "status": "ok"
}
```

This endpoint allows you to disable an existing Rule

#### HTTP Request

PUT https://api.mailinator.com/streams/:stream_id/rules/:rule_id/disable
	      
#### PATH 

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
:stream_id | (none) | true | This must be the Stream *name* or the Stream *id*
:rule_id | (none) | true | This must be the Rule *name* or the Stream *id*







### Get All Rules
```shell
curl "https://api.mailinator.com/streams/:stream_id/rules/"
```
```json
{
   "rules" : 
   [
      {
         "_id": "5c9602f5e881b5fbe91c754a",
         "description": "Rule to post all incoming mail to test1 or test2, then drop the email",
         "enabled": true,
         "match" : "ANY",
         "name": "testprefixpost",
         "conditions": [
           { 
             "operation": "EQUALS",
             "field": "to",
             "value": "test1"
           },
           { 
             "operation": "EQUALS",
             "field": "to",
             "value": "test2"
           }
         ],  
         "actions" : [
           {
             "action" : "WEBHOOK",
             "action_data": {
                "url" : "https://www.mywebsite.com/restendpoint"
             }
           },
           {
             "action" : "DROP"           
           }
         ]
      }
   ]
}
```

This endpoint fetches all Rules for a Stream

### HTTP Request

GET https://api.mailinator.com/streams/:stream_id/rules/
	      
### PATH 

Parameter | Default | Description
--------- | ------- | -----------
:stream_id | (none) | This must be the Stream *name* or the Stream *id*




## Get Rule
```shell
curl "https://api.mailinator.com/streams/:stream_id/rules/:rule_id"
```
```json
{
   "_id": "5c9602f5e881b5fbe91c754a",
   "description": "Rule to post all incoming mail to test1 or test2, then drop the email",
   "enabled": true,
   "match" : "ANY",
   "name": "testprefixpost",
   "conditions": [
     { 
      "operation": "EQUALS",
      "field": "to",
      "value": "test1"
     },
     { 
      "operation": "EQUALS",
      "field": "to",
      "value": "test2"
     }
   ],  
   "actions" : [
     {
       "action" : "WEBHOOK",
       "action_data": {
          "url" : "https://www.mywebsite.com/restendpoint"
       }
     },
     {
       "action" : "DROP"           
     }
   ]
}
```

This endpoint fetches a Rules for a Stream

### HTTP Request

GET https://api.mailinator.com/streams/:stream_id/rules/:rule_id
	      
### PATH 

Parameter | Default | Description
--------- | ------- | -----------
:stream_id | (none) | This must be the Stream *name* or the Stream *id*
:rule_id | (none) | This must be the rule *name* or the Rule *id*

## Delete Rule

```shell
curl -X DELETE "https://api.mailinator.com/streams/:stream_id/rules/:rule_id"
```
```json
{
   "status" : "ok"
}
```

This endpoint deletes a specific Rule from a Stream

### HTTP Request

DELETE https://api.mailinator.com/streams/:stream_id/rules/:rule_id
	      
### PATH 

Parameter | Default | Description
--------- | ------- | -----------
:stream_id | (none) | This must be the Stream *name* or the Stream *id*
:rule_id | (none) | This must be the rule *name* or the Rule *id*
