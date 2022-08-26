---
title: Mailinator Documentation

language_tabs: # must be one of https://git.io/vQNgJ
- shell: cURL
- java: Java
- javascript: Javascript
- csharp: C#
- go: Go
- ruby: Ruby
- python: Python

toc_footers:
- <a href='https://www.mailinator.com/'>Mailinator Home</a>
- <a href='https://www.mailinator.com/pricing.jsp'>Subscribe for Mailinator API access</a>

search: true
---
# Mailinator

Whereas most email systems are bulit around the concept of "account/inbox ownership", Mailinator is an email system built around "entire domain-inbox ownership". This allows companies to have instant access to millions of email addresses for system and automation testing of their software.

Mailinator also provides a "public" domain for personal use where all email addresses (@mailinator.com) are completely public and usable by anyone.

## Public Mailinator (all email @mailinator.com)

The Public Mailinator system (i.e. every possible email address @mailinator.com) creates inboxes when email arrives for them. All inboxes (and emails) are in the public domain. They are readable and deleteable by anyone. By design, there is NO privacy in the public Mailinator system and is intended for occasional, personal use.

In addition, all emails in the public Mailinator system auto-delete after a few hours. They are un-retrievable after this happens. Public Mailinator emails also may not contain attachments (if an attachment is sent, it will either not be delivered, or have the attachments stripped before delivery).

Finally, it's important to note that the Mailinator system is RECEIVE-ONLY. <b>No one can send an email from Mailinator.</b> (Any email appearing to have arrived from an @mailinator address has had it's "From" field forged to appear as such).

There is no need to sign-up to use the public Mailinator system. Simply go to the home page and enter an inbox name (i.e. anything you wish up to 50 characters) to check a particular inbox.

Again, the Public Mailinator is intended for personal and occasional use hence usage limits apply. Please see our Upgrade plans for corporate users.

## Private Mailinator

Mailinator offers upgraded subscriptions for corporate users wishing to use the Mailinator system. This offers many benefits.

Subscribers receive one or more "Private Domains" which provide a private version of Mailinator. That is, you control all inboxes for a given domain (i.e. you can use a Domain you provide or the system will provide one for you). You may view all such inboxes in one "super inbox" which lists every email coming into the domain in realtime. Emails in Private domains are not automatically deleted until your team's storage is exhausted. At this time, new emails push out old emails. Otherwise, emails in private domains are persistent as long as the account is active.

In addition, Private users gain API access to messages within the Mailinator system. Subscribers may use the API to access all email in their Private Domain(s) in addition to the Public Mailinator system.

## Message Delivery

<img src='images/m8rmsgflow.png' alt='Mailinator Message Flow'>

Messages arrive in the Mailinator system several ways.

+ Email
+ SMS
+ HTTP Post / Webhooks

The classic way is they arrive as email. However, messages may also enter the system via SMS (i.e. text message), or HTTP Post. Regardless of how a message arrives, it lands in a designated inbox and is then available for retrieval or manipulation/re-delivery via the rule system.

## Message Access

### Web

The Web Interface is available for all Public and Private email in the Mailinator system. Subscribers must login first in order to see their Private Team Inbox containing mail sent to their Private Domain(s). The Web interface will first attempt to show a message as an email. However, if the formatting of the message does not follow email conventions (i.e. maybe it arrived as an HTTP Post with a custom format), the message will be displayed in raw JSON.

### API

Subscribers may use programmatic access to poll inboxes and retrieve emails in JSON format. Documentation for the API can be found below.

### Rules

Instead of pulling emails via the API, Subscribers may set rules for Mailinator to "push" messages to them as they arrive. The rule system may be configured via the Web interface (i.e. Mailinator Routing Rules) or programmatically via the API (see API documentation below).

The Rule system allows subscribers to match on inbox and act upon every email that matches the conditional criteria.

<img src='images/ruleshot.png' alt="Rule Creation Dialog">

For example, a rule might be:

IF <b>TO == mytestinbox</b> THEN <b>POST Webhook To https://mywebsite.com/endpoint</b>

For a given Private domain, all emails that arrive to the "mytestinbox" address will be converted to JSON, and HTTP Posted to the designated endpoint.

For more information on configuring Rules, see the Rules API documentation below.

# Public Webhooks

Email is just one entry point for messages into the Mailinator system. Mailinator allows public users to setup
webhooks (or HTTP Posts) from their own systems or from third-party systems to inject messages into the Mailinator system.

When a message is injected in this way, it will appear in the appropriate inbox and is readable just like any
other message. The most notable difference is that the messages appear as pure JSON instead of parsed Email 
messages.

In this case, all that Mailinator provides is a public URL destination. As with other parts of the Public
Mailinator system, no authentication or authorization is required. However, strict rate and count limits
exist on public incoming webhooks. If you need this webhook functionality for your business, you are
encouraged to Subscribe to gain privacy, authentication, higher rate limits, the rule-system and more.

## Public Webhook URLS


```shell
This command will deliver the message to the "bob" inbox

curl -v -d '{"from":"MyMailinatorTest", "subject":"testing message", "text" : "hello world", "to" : "jack" }'      
-H "Content-Type: application/json"      
-X POST "https://www.mailinator.com/api/v2/domains/public/webhook/bob/"
```
```shell
This command will deliver the message to the "jack" inbox

curl -v -d '{"from":"MyMailinatorTest", "subject":"testing message", "text" : "hello world", "to" : "jack" }'      
-H "Content-Type: application/json"      
-X POST "https://www.mailinator.com/api/v2/domains/public/webhook/"
```


You may use these urls in your own systems, or give to third-party systems that deliver webhooks
(i.e. Zapier, Twilio, IFTTT, etc.)

The urls take two forms:

#### HTTP Request

POST https://www.mailinator.com/api/v2/domains/public/webhook/:to

A JSON Payload delivered to this url will be put into the ":to" inbox.

You may also allow the webhook to determine which inbox to deliver the message so long as
the incoming JSON contains a "to" field.


Note that if the Mailinator system cannot determine the destination inbox via the URL or a "to" field
in the payload, the message will be rejected.

If the message contains a "from" and "subject" field, these will be visible on the inbox page.

Note: This section specifically describes *Public* Webhooks. Subscribers may also use webhooks to inject
messages into their Private Domains which provide many more features. Please refer to that Documentation 
<a href="https://manybrain.github.io/m8rdocs/#private-webhooks">HERE</a>.

## Twilio Webhooks

If you have a Twilio account which receives incoming SMS messages. You may direct those messages through
this facility to inject those messages into the Mailinator system.

Set the Webhook URL in your Twilio phone number to:

POST https://www.mailinator.com/api/v2/domains/public/<b>twilio</b>

The SMS message will arrive in the Public Mailinator inbox corresponding to the Twilio Phone Number.
(only the digits, if a plus sign precedes the number it will be removed)
If you wish the message to arrive in a different inbox, you may append the destination inbox to the URL.

POST https://www.mailinator.com/api/v2/domains/public/<b>twilio</b>/bob


# Setting up your Mailinator Subscription

Thanks for being a Mailinator subscriber! This section will show you some immediate ways to get the most out of your Mailinator subscritpion.

You now have a Private domain (yes, already - check your Team Settings tab). Every conceivable inbox at that domain is waiting for you to send email to it. Unlike the public Mailinator system however, you won't run into rate-limits or filters. The email at that domain is private to you.

When your subscription became active, a subdomain of Testinator.com (i.e. a Mailinator testing domain) was created and assigned to your account as your private domain. For example, your initial private domain would be something like <b>@you-yourcompany.testinator.com</b>. So any email to <b>anything@you-yourcompany.testinator.com</b> will arrive in your private domain. On the left of the Web User Interface you'll see "Private Team Inbox". If you click that you'll be taken to the web interface for your private domain. Unlike Public Mailinator inboxes, you can see ALL incoming email to all inboxes at once! The inbox field in the upper right allows you to filter that incoming domain.

To see what your current Private Domain is, go the Team Settings section of the Web interface and you'll see it listed. You can leave it as is, change it to another subdomain, or even put in a domain you already own (you must change your MX DNS record of your domain to point to our servers for this to work).

On the Team Settings page, you'll also notice your API token. This token allows you to access all email in Mailinator (public and private) via API instead of the Web. See our API documentation below.

The Team Management screen allows you to add co-workers to your account so they too can access your private domain emails. Also, checkout the Message Routing Rules system. While it's great to read emails via the web or API, Mailinator will push emails to you via webhooks. You can set this up in the Rules System.

# Single Sign-On

Mailinator Enterprise subscriptions support Single Sign-On (SSO) using SAML. Please contact support (support@manybrain.com) for more information or help with configuration.

# Private Webhooks

Mailinator allows you to HTTP Post or Webhook messages into your Private Domain. This is extremely convenient for
testing as now all your test emails, SMS messages, and Webhooks will reside in the same place and are accessible
via same Web Interface, API, and Rule System.

```shell
This command will deliver the message to the "bob" inbox

curl -v -d '{"from":"someplace@xyz.com", "subject":"testing", "text" : "helloworld", "to" : "jack" }'      
-H "Content-Type: application/json"      
-X POST "https://www.mailinator.com/api/v2/domains/<your_webhook_token>/webhook/bob/"
```

<aside class="notice">
Webhooks into your Private System do <b>NOT</b> use your regular API Token. 
<br>
This is because a typical use case is to 
enter the Webhook URL into 3rd-party systems (i.e. Twilio, Zapier, IFTTT, etc) and you should never give out
your API Token.
</aside>
<br>
<aside class="notice">
Check your Team Settings where you can create "Webhook Tokens" designed for this purpose.
</aside>

There are several permutations of the Webhook URLS. Say your Private Domain is <b>mypd.com</b> then
all of the following urls are identical:

<b>https://www.mailinator.com/api/v2/domains/&lt;wh-token&gt;/webhook/</b><br>
<b>https://www.mailinator.com/api/v2/domains/mypd.com/webhook/?whtoken=&lt;wh-token&gt;</b><br>
<b>https://www.mailinator.com/api/v2/domains/private/webhook/?whtoken=&lt;wh-token&gt;</b>

The incoming Webhook will arrive in the inbox designated by the "to" field in the incoming JSON payload.
If the incoming payload does not contain a "to" field, or you wish to override the incoming destination,
you may specify the desination inbox in the url:

https://www.mailinator.com/api/v2/domains/&lt;token&gt;/webhook/<b>bob</b><br>

Incoming Webhooks are delivered to Mailinator inboxes and from that point onward are not notably different
than other messages in the system (i.e. emails). You may retrieve such messages via the Web Interface,
the API, or the Rule System. See the following documentation on the Message API for more information.

As normal, Mailinator will list all messages in the Inbox page and via the Inbox API calls. If the incoming
JSON payload does not contain a "from" or "subject", then dummy values will be inserted in these fields.

## Twilio

Mailinator intends to apply specific mappings for certain services that commonly publish webhooks.

If you test incoming Messages to SMS numbers via Twilio, you may use this endpoint to correctly map
"to", "from", and "subject" of those messages to the Mailinator system.  By default, the destination 
inbox is the Twilio phone number. This may be overridden by specifying the destination inbox in the URL
(second example below).

https://www.mailinator.com/api/v2/domains/&lt;wh-token&gt;/<b>twilio</b>/<br>
https://www.mailinator.com/api/v2/domains/&lt;wh-token&gt;/<b>twilio</b>/someinbox

# The Mailinator API

The Mailinator API provides programmatic access to the Mailinator system. This includes fetching and injecting messages into the Mailinator system and creating routing rules for specific message domains within the system. Messages are typically (and historically) email messages. Hence the format of messages tend to look like emails but in reality any message can be fed, routed, and read or delivered through the system. In a broader scope messages generally arrive via email, SMS, or direct HTTP Post.

Subscribers can read messages in both the Public and their own Private Mailinator email systems with the API. They may also route/inject messages but only to their Private Mailinator domains.

Access to the API (and messages in general) are subject to your subscription plan's rate limits.

## Definitions

- <b>Messages</b>

Messages within Mailinator are typically thought of as emails - however, messages can enter the system in a variety of ways including email, SMS, or HTTP Post. In general, the schema of messages contains a TO, FROM, SUBJECT, and message body. Message bodies can be simple string of text or - as is allowed by email standards, a complicated multi-part, multi-encoded schema.

- <b>Domains</b>

Domains identify a specific source for messages. Emails automatically are assigned to the domain of their "to" address. Expectedly, each of your Private Domains represent a specific source for messages. Each Domain may have it's own set of rules.

<!--
- <b>Destinations</b>

Mailinator routing rules allow immediate routing actions to take place on incoming messages. For example, you may wish to designate all incoming email messages to "Joe@YourPrivateDomain.com" should be forwarded to your work email. You could also designate that all incoming messages to "Bob@YourPrivateDomain.com" should be Posted via WebHook to an endpoint on your testing server.

You may define a set of Destinations to be reused by your rules.
-->

## SDK
Mailinator provides several official SDKs. Please select your language in the upper right to see examples in your preferred language.

Java:
<a href='https://github.com/manybrain/mailinator-java-client' rel=nofollow>https://github.com/manybrain/mailinator-java-client</a>
<br>
Javascript:
<a href='https://github.com/manybrain/mailinator-javascript-client' rel=nofollow>https://github.com/manybrain/mailinator-javascript-client</a>
<br>
C#:
<a href='https://github.com/manybrain/mailinator-csharp-client' rel=nofollow>https://github.com/manybrain/mailinator-csharp-client</a>
<br>
Go:
<a href='https://github.com/manybrain/mailinator-go-client' rel=nofollow>https://github.com/manybrain/mailinator-go-client</a>
<br>
Ruby:
<a href='https://github.com/manybrain/mailinator-ruby-client' rel=nofollow>https://github.com/manybrain/mailinator-ruby-client</a>
<br>
Python:
<a href='https://github.com/manybrain/mailinator-python-client' rel=nofollow>https://github.com/manybrain/mailinator-python-client</a>
<br>

``` java
Maven:
  <dependencies>
    <dependency>
      <groupId>com.manybrain</groupId>
      <artifactId>mailinator-client</artifactId>
      <version>1.0</version>
    </dependency>
  </dependencies>

Gradle:
  compile 'com.manybrain:mailinator-client:1.0'
```

## API Authentication

> To authorize, use this code:

```shell
# REST calls require your team's API token in every call
curl "https://api.mailinator.com/api_endpoint_here?token=YourTeamAPIToken"

or

curl --header "Authorization: YourTeamAPIToken"
     "https://api.mailinator.com/api_endpoint_here"
```

```java
MailinatorClient mailinatorClient = new MailinatorClient("YourTeamAPIToken");
```

```javascript
const mailinatorClient = new MailinatorClient("YourTeamAPIToken");
```

```csharp
MailinatorClient mailinatorClient = new MailinatorClient("YourTeamAPIToken");
```

```go
mailinatorClient := mailinator.NewMailinatorClient("YourTeamAPIToken")
```

```ruby
mailinatorClient = MailinatorClient::Client.new(auth_token: "YourTeamAPIToken")
```

```python
mailinatorClient = Mailinator(API_TOKEN)
```

> Replace YourTeamAPIToken with the API Token found on your Team's settings page

Mailinator uses API tokens for authentication. All calls to the API must include the token query parameter OR included as an HTTP Authorization header.

<aside class="notice">
You must replace <b>YourTeamAPIToken</b> with the API token found on your Team Settings page
</aside>


# Message API

## Fetch Inbox <span style='font-size:.8em'>(aka Fetch Message Summaries)
This endpoint retrieves a list of messages summaries. You can retreive a list by inbox, inboxes, or entire domain.

```shell
curl "https://mailinator.com/api/v2/domains/private/inboxes/testinbox?limit=2&sort=descending"

Response:
{
    "domain": "yourprivatedomain.com",
    "to": "testinbox"
    "msgs": [
        {
            "subject": "this is a test email 1",
            "domain": "yourprivatedomain.com",
            "from": "Our Qa Tester <qatester@company.com>"
            "id": "testinbox-1571155952-33840774",
            "to": "testinbox",
            "time": 1571155952000,
            "seconds_ago": 258277
        },
        {
            "subject": "This is my test email [with attachment]",
            "domain": "yourprivatedomain.com",
            "from": "Our Qa Tester <qatester@company.com>"
            "id": "testinbox-1570635306-12914603",
            "to": "testinbox",
            "time": 1570635306000,
            "seconds_ago": 778923
        }
    ],
   }
}

```

``` java
   Inbox inbox = mailinatorClient.request(new GetInboxRequest("private"));
   List<Message> messages = inbox.getMsgs();
   for (Message m : messages) {
     String subject = m.getSubject();
     List<Part> parts = m.getParts();
     // process message
   }
```

``` javascript
   mailinatorClient.request(new GetInboxRequest(domain.name))
          .then(response => {
          const result = response.result;
          const msgs = result?.msgs;
          if (msgs !== undefined) {
            msgs.forEach((msg) => {
              const subject = msg.subject;
              const parts = msg.parts;
	      ..
              // process message
              })
            }
          });
```

```csharp
    FetchInboxRequest fetchInboxRequest = new FetchInboxRequest() 
    { 
        Domain = "yourDomainNameHere", 
        Inbox = "yourInboxHere", 
        Skip = 0, 
        Limit = 20, 
        Sort = Sort.asc 
    };
    FetchInboxResponse fetchInboxResponse = await mailinatorClient.MessagesClient.FetchInboxAsync(fetchInboxRequest);
```

```go
    res, err := mailinatorClient.FetchInbox(&FetchInboxOptions{Domain: "yourDomainNameHere", Inbox: "yourInboxHere"})
```

```ruby
    response = mailinatorClient.messages.fetch_inbox(domain:"yourDomainNameHere", inbox: "yourInboxHere", skip: 0, limit: 50, sort: "ascending", decodeSubject: false)
```

```python
    inbox = mailinator.request( GetInboxRequest(DOMAIN, INBOX) )
```

### HTTP Request
<b>GET</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/<b>:inbox</b>



Path Element |  Value | Description
--------- | ------- | -------- | -----------
:domain   | public  | Fetch Message Summaries from the Public Mailinator System
          | private | Fetch Message Summaries from all Your Private Domains
          | [your_private_domain.com] |  Fetch Message Summaries from a specific Private Domain
:inbox    | null    | Fetch All Messages summaries for an entire domain
          | *       | Fetch All Messages summaries for an entire domain
          | [inbox_name]   | Fetch All Messages summaries for a given Inbox
          | [inbox_name*]  | Fetch All Messages summaries for a given Inbox Prefix

### Query Parameters

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
skip | 0 | no | skip this many emails in your Private Domain
limit | 50 | no | number of emails to fetch from your Private Domain
sort | descending | no | Sort results by ascending or descending
decode_subject | false | no | true: decode encoded subjects







## Fetch Message
This endpoint retrieves a specific message by id.

```shell
curl "https://mailinator.com/api/v2/domain/private/inboxes/testinbox/messages/testinbox-1570635306-12914603"

Response:
{
    "fromfull": "Our Qa Tester <qatester.company.com>",
    "headers": {
        "mime-version": "1.0",
        "date": "Tue, 15 Oct 2019 12:12:20 -0400",
        "subject": "this is a test email 1",
        "content-type": "multipart/mixed",
    },
    "subject": "this is a test email 1",
    "parts": [
        {
            "headers": {
                "content-type": "text/plain; charset=\"UTF-8\""
            },
            "body": "here is our test email\r\n"
        },
        {
            "headers": {
                "content-type": "text/html; charset=\"UTF-8\""
            },
            "body": "<div dir=\"ltr\"><div class=\"gmail_default\"
                     style=\"font-family:tahoma,sans-serif;font-size:large\">
                     here&#39;s the test email</div></div>\r\n"
        },
        {
            "headers": {
                "content-disposition": "attachment; filename=\"notes.pdf\"",
                "content-transfer-encoding": "base64",
                "content-type": "application/pdf; name=\"notes.pdf\"",
            },
        "body": "iVBO4JYRUE2VGk85o6MBpC9E1frV8djCh24TVzy6CdiTEFkJoFGwRxy0jeivb3t8f6+e+uo4P==="
        }
    ],
    "from": "Our Qa Tester",
    "to": "testinbox",
    "id": "testinbox-1570635306-12914603",
    "time": 1571155952000,
    "seconds_ago": 260276
}

```

``` java
  // Message m = mailinatorClient.request(
  // new GetMessageRequest("<domain>", "<inbox-name>", "<msg-id>"));
    Message m = mailinatorClient.request(
      new GetMessageRequest("private", "testinbox", "testinbox-1570635306-12914603"));

   List<Parts> parts = m.getParts();
   String subject = m.getSubject();
   Map<String, Object> headers = m.getHeaders();
```

``` javascript
    mailinatorClient.request(new GetMessageRequest("<domain>", "<inbox-name>", "<msg-id>"))
            .then(response => {
                const result = response.result;
                const parts = result?.parts;
                const subject = result?.subject;
                const headers = result?.headers;
            });
```

```csharp
    FetchMessageRequest fetchMessageRequest = new FetchMessageRequest() 
    { 
        Domain = "yourDomainNameHere", 
        Inbox = "yourInboxHere", 
        MessageId = "yourMessageIdHere" 
    };
    FetchMessageResponse fetchMessageResponse = await mailinatorClient.MessagesClient.FetchMessageAsync(fetchMessageRequest);
```

```go
    res, err := mailinatorClient.FetchMessage(&FetchMessageOptions{"yourDomainNameHere", "yourInboxHere", "yourMessageIdHere"})
```

```ruby
    response = mailinatorClient.messages.fetch_message(domain:"yourDomainNameHere", inbox: "yourInboxHere", messageId: "yourMessageIdHere")
```

```python
    message = self.mailinator.request( GetMessageRequest(DOMAIN, INBOX, message_id) )
```

### HTTP Request
<b>GET</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/<b>:inbox</b>/messages/<b>:message_id</b>

Path Element |  Value | Description
--------- | ------- | -------- | -----------
:domain   | public  | Fetch Message Summaries from the Public Mailinator System
          | private | Fetch Message Summaries from any Private Domains
          | [your_private_domain.com] |  Fetch Message from a specific Private Domain
:inbox    | [inbox_name]   | Fetch Message for this inbox
:message_id | [msg_id] | Fetch Message with this ID (found via previous Message Summary call)


## Fetch an SMS Messages
SMS messages go into an inbox by the name of their phone number. Retrieving them is the same as any other message, simply use the phone number as the Inbox you are fetching.

### HTTP Request
<b>GET</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/<b>:YOUR_TEAM_SMS_NUMBER</b>


## Fetch List of Attachments
This endpoint retrieves a list of attachments for a message. Note attachments are expected to be in Email format.

```shell
curl "https://mailinator.com/api/v2/domain/private/inboxes/testinbox/messages/testinbox-1570635306-12914603/attachments"

Response:
{
   "attachments": [
        {
            "filename": "notes.pdf",
            "content-disposition": "attachment; filename=\"notes.pdf\"",
            "content-transfer-encoding": "base64",
            "content-type": "application/pdf",
            "attachment-id": 0
        }
    ]
}

```

``` java
  List<Attachment> attachments = mailinatorClient.request(
    new GetAttachmentsRequest("private", "testinbox", "testinbox-1570635306-12914603"));
```

``` javascript
    mailinatorClient.request(new GetAttachmentsRequest("private", "testinbox", "testinbox-1570635306-12914603"))
            .then(response => {
                const result = response.result;
                const attachments = result?.attachments;
                if (attachments !== undefined) {
                    attachments.forEach((element)=>{
                        const filename = element.filename;
                    });
                }
            });
```

```csharp
    FetchAttachmentsRequest fetchAttachmentsRequest = new FetchAttachmentsRequest() 
    { 
        Domain = "yourDomainNameHere", 
        Inbox = "yourInboxHere", 
        MessageId = "yourMessageIdWithAttachmentHere" 
    };
    FetchAttachmentsResponse fetchAttachmentsResponse = await mailinatorClient.MessagesClient.FetchAttachmentsAsync(fetchAttachmentsRequest);
```

```go
    res, err := mailinatorClient.FetchAtachments(&FetchAttachmentsOptions{"yourDomainNameHere", "yourInboxHere", "yourMessageIdWithAttachmentHere"})
```

```ruby
    response = mailinatorClient.messages.fetch_attachments(domain:"yourDomainNameHere", inbox: "yourInboxHere", messageId: "yourMessageIdWithAttachmentHere")
```

```python
    attachments = self.mailinator.request( GetAttachmentsRequest(DOMAIN, INBOX, message_id) )
```

### HTTP Request
<b>GET</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/<b>:inbox</b>/messages/<b>:message_id</b>/attachments

## Fetch Links
This endpoint retrieves all links found within a given email

```shell
curl "https://mailinator.com/api/v2/domain/private/inboxes/testinbox/messages/testinbox-1570635306-12914603/links"

Response:
{
"links": [
        "https://www.yoursite.com/activate",
        "https://www.yoursite.com/privacy",
        "https://www.facebook.com/oursitepage"
         ]
}

```

``` java
  List<Links> links = mailinatorClient.request(
    new GetLinksRequest("private", "testinbox", "testinbox-1570635306-12914603"));
```

``` javascript
    mailinatorClient.request(new GetLinkssRequest("private", "testinbox", "testinbox-1570635306-12914603"))
            .then(response => {
                const result = response.result;
                const links = result?.links;
                if (links !== undefined) {
                    links.forEach((link)=>{
                        ...
                    });
                }
            });
```

```csharp
    FetchLinksRequest fetchLinksRequest = new FetchLinksRequest() 
    { 
        Domain = "yourDomainNameHere", 
        Inbox = "yourInboxHere", 
        MessageId = "yourMessageIdWithAttachmentHere" 
    };
    FetchLinksResponse fetchLinksResponse = await mailinatorClient.MessagesClient.FetchLinksAsync(fetchLinksRequest);
```

```go
    res, err := mailinatorClient.FetchMessageLinks(&FetchMessageLinksOptions{"yourDomainNameHere", "yourInboxHere", "yourMessageIdHere"})
```

```ruby
    response = mailinatorClient.messages.fetch_message_links(domain:"yourDomainNameHere", inbox: "yourInboxHere", messageId: "yourMessageIdHere")
```

```python
    links = self.mailinator.request( GetMessageLinksRequest(DOMAIN, INBOX, message_id) )
```

### HTTP Request
<b>GET</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/<b>:inbox</b>/messages/<b>:message_id</b>/links


## Fetch Attachment
This endpoint retrieves a list of attachments for a message. Note attachments are expected to be in Email format.

```shell
curl "https://mailinator.com/api/v2/domain/private/inboxes/testinbox/messages/testinbox-1570635306-12914603/attachments/nodes.pdf"
```

``` java
   // Attachment attachment = mailinatorClient.request(
   //       new GetAttachmentRequest("<domain>", "<inbox-name>", "<msg-id>", attachmentId));
 Attachment attachment = mailinatorClient.request(
   new GetAttachmentRequest("private", "testinbox", "testinbox-1570635306-12914603", 1));
```

``` javascript
        const file = fs.createWriteStream("filename");
        mailinatorClient.request(new GetAttachmentRequest("<domain>", "<inbox-name>", "<msg-id>", attachmentId))
            .then(response => {
                response.result!.pipe(file);
            });
```

```csharp
    FetchAttachmentRequest fetchAttachmentRequest = new FetchAttachmentRequest() 
    { 
        Domain = "yourDomainNameHere", 
        Inbox = "yourInboxHere", 
        MessageId = "yourMessageIdWithAttachmentHere", 
        AttachmentId = "yourAttachmentIdHere" 
    };
    FetchAttachmentResponse fetchAttachmentResponse = await mailinatorClient.MessagesClient.FetchAttachmentAsync(fetchAttachmentRequest);
```

```go
    res, err := mailinatorClient.FetchAttachment(&FetchAttachmentOptions{"yourDomainNameHere", "yourInboxHere", "yourMessageIdWithAttachmentHere", "yourAttachmentIdHere"})
```

```ruby
    response = mailinatorClient.messages.fetch_attachment(domain:"yourDomainNameHere", inbox: "yourInboxHere", messageId: "yourMessageIdWithAttachmentHere", attachmentId: "yourAttachmentIdHere")
```

```python
    response = self.mailinator.request( GetAttachmentRequest(DOMAIN, INBOX, message_id, attachment_id) )
```

### HTTP Request
<b>GET</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/<b>:inbox</b>/messages/<b>:message_id</b>/attachments/<b>:attachment_name</b>

Note that alternatively, you specify the "attachment-id" value instead of the attachment name.



## Delete ALL Messages (by Domain)
<aside class="notice">
This endpoint deletes <b>ALL</b> messages from a Private Domain. Caution: This action is irreversible.
</aside>



```shell
curl  -X DELETE "https://mailinator.com/api/v2/domains/private/inboxes/"

Response:
{
    "status" : "ok",
    "messages_deleted" : 1048
}

```

``` java
    DeletedMessages deletedMessages = mailinatorClient.request(
      new DeleteDomainMessagesRequest("private"));
    System.out.println(deletedMessages.getCount() + " messages deleted");
```

``` javascript
    mailinatorClient.request(new DeleteDomainMessagesRequest("private"))
            .then(response => {
                const count = response.result!.count;
            });
```

```csharp
    DeleteAllDomainMessagesRequest deleteAllDomainMessagesRequest = new DeleteAllDomainMessagesRequest() 
    { 
        Domain = "yourDomainNameHere" 
    };
    DeleteAllDomainMessagesResponse deleteAllDomainMessagesResponse = 
        await mailinatorClient.MessagesClient.DeleteAllDomainMessagesAsync(deleteAllDomainMessagesRequest);
```

```go
    res, err := mailinatorClient.DeleteAllDomainMessages(&DeleteAllDomainMessagesOptions{"yourDomainNameHere"})
```

```ruby
    response = mailinatorClient.messages.delete_all_domain_messages(domain:"yourDomainNameHere")
```

```python
    response = self.mailinator.request( DeleteDomainMessagesRequest(DOMAIN) )
```

<b>DELETE</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/

Path Element |  Value | Description
--------- | ------- | -------- | -----------
:domain   | private  | Delete ALL messages in all your private domains
          | [your_private_domain.com] |  Delete all messages in a specific private domain
:inbox    | null    | Delete from all inboxes, or
          | *       | Delete from all inboxes



## Delete ALL Messages (by Inbox)

This endpoint deletes <b>ALL</b> messages from a specific private inbox.


```shell
curl  -X DELETE "https://mailinator.com/api/v2/domains/private/inboxes/testinbox"

Response:
{
    "status" : "ok",
    "messages_deleted" : 11
}


```

``` java
  DeletedMessages deletedMessages = mailinatorClient.request(new DeleteInboxMessagesRequest("private", "testinbox"));
  System.out.println(deletedMessages.getCount() + " messages deleted");
```

``` javascript
    mailinatorClient.request(new DeleteInboxMessagesRequest("private", "testinbox"))
            .then(response => {
                const count = response.result!.count;
            });
```

```csharp
    DeleteAllInboxMessagesRequest deleteAllInboxMessagesRequest = new DeleteAllInboxMessagesRequest() 
    { 
        Domain = "yourDomainNameHere", 
        Inbox = "yourInboxHere" 
    };
    DeleteAllInboxMessagesResponse deleteAllInboxMessagesResponse = 
        await mailinatorClient.MessagesClient.DeleteAllInboxMessagesAsync(deleteAllInboxMessagesRequest);
```

```go
    res, err := mailinatorClient.DeleteAllInboxMessages(&DeleteAllInboxMessagesOptions{"yourDomainNameHere", "yourInboxHere"})
```

```ruby
    response = mailinatorClient.messages.delete_all_inbox_messages(domain:"yourDomainNameHere", inbox: "yourInboxHere")
```

```python
    response = self.mailinator.request( DeleteInboxMessagesRequest(DOMAIN) )    
```


<b>DELETE</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/<b>:inbox</b>

Path Element |  Value | Description
--------- | ------- | -------- | -----------
:domain   | private  | Delete all messages from an inbox from any private domain
          | [your_private_domain.com] |  Delete all messages from an inbox from a specific private domain
:inbox    | [inbox_name]    | Delete all messages from a specific inbox


## Delete a Message
This endpoint deletes a specific messages

```shell
curl -X DELETE "https://mailinator.com/api/v2/domains/private/inboxes/testinbox/messages/testinbox-1570635306-12914603"

Response:
{
    "status" : "ok",
    "messages_deleted" : 1
}
```

``` java
    mailinatorClient.request(new DeleteMessagesRequest("private"));
    System.out.println(deletedMessages.getCount() + " messages deleted");
```

``` javascript
    mailinatorClient.request(new DeleteMessageRequest("private", "testinbox", "testinbox-1570635306-12914603"))
            .then(response => {
                const count = response.result!.count;
            });
```

```csharp
    DeleteMessageRequest deleteMessageRequest = new DeleteMessageRequest() 
    { 
        Domain = "yourDomainNameHere", 
        Inbox = "yourInboxHere", 
        MessageId = "yourMessageIdHere" 
    };
    DeleteMessageResponse deleteMessageResponse = await mailinatorClient.MessagesClient.DeleteMessageAsync(deleteMessageRequest);
```

```go
    res, err := mailinatorClient.DeleteMessage(&DeleteMessageOptions{"yourDomainNameHere", "yourInboxHere", "yourMessageIdHere"})
```

```ruby
    response = mailinatorClient.messages.delete_message(domain:"yourDomainNameHere", inbox: "yourInboxHere", messageId: "yourMessageIdHere")
```

```python
    response = self.mailinator.request( DeleteMessageRequest(DOMAIN, INBOX, message_id) )
```

<b>DELETE</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/<b>:inbox</b>/messages/<b>:message_id</b>

Path Element |  Value | Description
--------- | ------- | -------- | -----------
:domain   | private  | Delete message from any private domain
          | [your_private_domain.com] |  Delete message from a specific private domain
:inbox    | [inbox_name]    | Delete message from a specific inbox
:message_id | [message_id] | Delete message with this ID



## Inject a Message (HTTP Post messages)
```shell
curl -d '{"from":"ourtest@xyz.com", "subject":"testing message", "text" : "hello world" }'
     -H "Content-Type: application/json"
     -X POST "https://mailinator.com/api/v2/domains/private/inboxes/testinbox/messages"

Response:
{
    "status" : "ok",
    "id" : "testinbox-3282929-109191"
}
```

``` java
   MessageToPost msgToPost = new MessageToPost("subject", "from", "text_body");
   mailinatorClient.request(new PostMessageRequest("private", "testinbox", msgToPost));

```

``` javascript
        const msg = new MessageToPost("subject", "from", "text")
        mailinatorClient.request(new PostMessageRequest("private", "testinbox", msg))
            .then(response => {
                const count = response.result!.id;
            });
```

```csharp
    MessageToPost messageToPost = new MessageToPost()
            {
                Subject = "Testing message",
                From = "test_email@test.com",
                Text = "Hello World!"
            };
    InjectMessageRequest injectMessageRequest = new InjectMessageRequest() 
    { 
        Domain = "yourDomainNameHere", 
        Inbox = "yourInboxHere", 
        Message = messageToPost 
    };
    InjectMessageResponse injectMessageResponse = await mailinatorClient.MessagesClient.InjectMessageAsync(injectMessageRequest);
```

```go
    message := MessageToPost{
			Subject: "Testing message",
			From:    "test_email@test.com",
			Text:    "Hello World!",
		}
    res, err := mailinatorClient.InjectMessage(&InjectMessageOptions{"yourDomainNameHere", "yourInboxHere", message})
```

```ruby
    messageToPost = {
        subject:"Testing ruby message",
        from:"test_email_ruby@test.com", 
        text:"I love Ruby!"
      }
    response = mailinatorClient.messages.inject_message(domain:"yourDomainNameHere", inbox: "yourInboxHere", messageToPost: messageToPost)
```

```python
    post_message = PostMessage({'from':'test_email@test.com', 'subejct': "here my subject", 'text':"hello"})
    response = self.mailinator.request( PostMessageRequest(DOMAIN, INBOX, post_message) )
```

This endpoint allows you to deliver a JSON message into your private domain. This is similar to simply emailing a message to your private domain, except that you use HTTP Post and can programmatically inject the message.

Note that injected JSON Messages can have any schema they choose. However, if you want the Web interface to display them, they must follow a general email format with the fields of From, Subject, and Parts (see "Fetch Message" above).


<b>POST</b> https://mailinator.com/api/v2/domains/<b>:domain</b>/inboxes/<b>:inbox</b>

Path Element |  Value | Description
--------- | ------- | -------- | -----------
:domain   | private  | Inject to any (i.e. first) private domain
          | [your_private_domain.com] |  Inject to specific private domain
:inbox    | [inbox_name]    | TO destination for injected message






# Stats API
You may retrieve usage information for your Team using this API.


### Get All domains
```shell
curl "https://api.mailinator.com/api/v2/team/stats"

Response:
{
     "stats": [
           {
             "date": "20200921",
             "retrieved": {
                "web_private": 1029,
                "web_public": 0,
                "api_email": 983
                "api_error": 1,
              },
              "sent": {
                "sms": 0,
                "email": 1990
              }
           },
           {
             "date": "20200922",
             "retrieved": {
                "web_private": 829,
                "web_public": 2,
                "api_email": 800
                "api_error": 0,
              },
              "sent": {
                "sms": 3,
                "email": 1402
              }
           }
      ]
}
```

``` javascript

ADD JAVASCRIPT

```
``` java

ADD JAVA

```

```csharp
    GetTeamStatsResponse response = await mailinatorClient.StatsClient.GetTeamStatsAsync();
```

```go
    res, err := mailinatorClient.GetTeamStats()
```

```ruby
    response = mailinatorClient.stats.get_team_stats
```

```python
    
ADD PYTHON

```

#### HTTP Request

GET https://api.mailinator.com/api/v2/team/stats


# Domains API
You may add or replace Private Domains in your Team Settings panel.


### Get Usage Statistica
```shell
curl "https://api.mailinator.com/api/v2/team/stats"

Response:
{
  "domains" :
     [
	     {
	       "_id": "5c9602f5e881b5fbe91c754a",
         "description": "Domain representing some testing",
         "enabled": true,
         "name": "my.test.domain",
         "ownerid": "59188558619b4f3879751781",
         "rules": []
	     }
	   ]
}
```

``` javascript
        mailinatorClient.request(new GetDomainsRequest())
            .then(r => {
                const domains = r.result;
                domains?.domains.forEach((domain) => {
                    const name = domain.name;
                    // ...
                })
            });
```

```csharp
    GetAllDomainsResponse getAllDomainsResponse = await mailinatorClient.DomainsClient.GetAllDomainsAsync();
```

```go
    res, err := mailinatorClient.GetDomains()
```

```ruby
    response = mailinatorClient.domains.get_domains
```

```python
    domains = self.mailinator.request( GetDomainsRequest() )
```

The endpoint fetches a list of all your domains.

#### HTTP Request

GET https://api.mailinator.com/domains/

### Get Domain
```shell
curl "https://api.mailinator.com/api/v2/domains/:domain_id"

Response:
{
   "_id": "5c9602f5e881b5fbe91c754a",
   "description": "Domain representing some testing",
   "enabled": true,
   "name": "my.test.domain.com",
   "ownerid": "59188558619b4f3879751781",
   "rules": []
}
```

``` javascript
        mailinatorClient.request(new GetDomainRequest("domain_id"))
            .then(r => {
                const domain = r.result;
                const name = domain?.name;
                // ...
            });
```

```csharp
    GetDomainRequest getDomainRequest = new GetDomainRequest() 
    { 
        DomainId = "yourDomainIdHere" 
    };
    GetDomainResponse getDomainResponse = await mailinatorClient.DomainsClient.GetDomainAsync(getDomainRequest);
```

```go
    res, err := mailinatorClient.GetDomain(&GetDomainOptions{"yourDomainIdHere"})
```

```ruby
    response = mailinatorClient.domains.get_domain(domainId:"yourDomainIdHere")
```

```python
    domain = self.mailinator.request( GetDomainRequest(DOMAIN) )
```

The endpoint fetches a specific domain

### Create Private Domain
```shell
curl -X POST "https://api.mailinator.com/api/v2/domains/:domain_id"

Response:
{
  "status" : "ok"
}
```

This endpoint creates a private domain attached to your account. Note, the domain must be unique to the system and you must have not reached your maximum number of Private Domains.

### Create Private Domain
```shell
curl -X DELETE "https://api.mailinator.com/api/v2/domains/:domain_id"

Response:
{
  "status" : "ok"
}
```

This endpoint deletes a Private Domain. Use this first if you intend to add a new domain and have reached your Private Domain limit.

#### HTTP Request

GET https://api.mailinator.com/domains/:domain_id

#### PATH

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
	      :domain_id | (none) | true | This must be the Domain *name* or the Domain *id*


# Rules API
You may define domain-specific rules to process incoming messages. Rules are executed in priority order (Rules with equal priority run simultaneously).

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
     -X POST "https://api.mailinator.com/api/v2/domains/:domain_id/rules/"
     -d "@data.json"

(data.json):
{
   "description": "Rule to post all incoming mail starting with test* to my webhook",
   "enabled": true,
   "name": "testprefixpost",
   "conditions": [
      {
        "operation": "PREFIX",
        "condition_data": {
          "field": "to",
          "value": "test"
          }
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

Response:
{
   "_id": "5c9602f5e881b5fbe91c754a",
   "description": "Rule to post all incoming mail starting with test* to my webhook",
   "enabled": true,
   "name": "testprefixpost",
   "conditions": [
      {
        "operation": "PREFIX",
        "condition_data": {
          "field": "to",
          "value": "test"
          }
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

``` javascript
        const actionData = new ActionData();
        actionData.url = "https://www.mywebsite.com/restendpoint";
        const action = new Action();
        action.action = ActionType.WEBHOOK;
        action.action_data = actionData;

        const condition = new Condition();
        condition.operation = OperationType.EQUALS;
        condition.value = "raul";

        const ruleToCreate = new RuleToCreate();
        ruleToCreate.name = 'rule name';
        ruleToCreate.priority = 15;
        ruleToCreate.conditions = [condition];
        ruleToCreate.actions = [action];
        mailinatorClient.request(new CreateRuleRequest("domain_id", ruleToCreate))
            .then(r => {
                const rule = r.result;
                const name = rule?.name;
                // ...
            });
```

```csharp
    RuleToCreate ruleToCreate = new RuleToCreate()
          {
              Name = "RuleName",
              Priority = 15,
              Description = "Description",
              Conditions = new List<Condition>()
              {
                  new Condition()
                  {
                      Operation = OperationType.PREFIX,
                      ConditionData = new ConditionData()
                      {
                          Field = "to",
                          Value = "raul"
                      }
                  }
              },
              Enabled = true,
              Match = MatchType.ANY,
              Actions = new List<ActionRule>() { new ActionRule() { Action = ActionType.WEBHOOK, ActionData = new ActionData() { Url = "https://www.google.com" } } }
          };
    CreateRuleRequest createRuleRequest = new CreateRuleRequest() 
    { 
        DomainId = "yourDomainIdHere", 
        Rule = ruleToCreate 
    };
    CreateRuleResponse createRuleResponse = await mailinatorClient.RulesClient.CreateRuleAsync(createRuleRequest);
```

```go
    rule := RuleToCreate{
		Name:        "RuleName",
		Priority:    15,
		Description: "Description",
		Conditions: []Condition{
			Condition{
				Operation: OperationType("PREFIX"),
				ConditionData: ConditionData{
					Field: "to",
					Value: "raul",
				},
			},
		},
		Enabled: true,
		Match:   MatchType("ANY"),
		Actions: []ActionRule{
			ActionRule{
				Action: ActionType("WEBHOOK"),
				ActionData: ActionData{
					Url: "https://www.google.com",
				},
			},
		},
	}

	res, err := mailinatorClient.CreateRule(&CreateRuleOptions{"yourDomainIdHere", rule})
```

```ruby
    ruleToPost = {
        name:        "RuleName",
        priority:    15,
        description: "Description",
        conditions: [
          {
            operation: "PREFIX",
            condition_data: {
              field: "to",
              value: "raul"
            }
          }
        ],
        enabled: true,
        match:   "ANY",
        actions: [
          {
            action: "WEBHOOK",
            action_data: {
              url: "https://www.google.com"
            }
          }
        ]
      }

    response = mailinatorClient.rules.create_rule(domainId:"yourDomainIdHere", ruleToPost: ruleToPost)
```

```python
    conditions = [Condition(operation=Condition.OperationType.PREFIX, field="to", value="test")]
    actions = [Action(action=Action.ActionType.DROP, action_data=Action.ActionData("https://www.mywebsite.com/restendpoint"))]
    rule = Rule(description="mydescription", enabled=True, name="MyName", conditions=conditions, actions=actions)

    rule = self.mailinator.request( CreateRuleRequest(DOMAIN, rule ) )
```

This endpoint allows you to create a Rule. Note that in the examples, ":domain_id" can be one of your private domains.

#### HTTP Request

POST https://api.mailinator.com/api/v2/domains/:domain_id/rules/

#### PATH

Parameter | Default | Description
--------- | ------- | -----------
:domain_id | (none) | This must be the Domain *name* or the Domain *id* (i.e. your private domain)

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
curl -X PUT "https://api.mailinator.com/api/v2/domains/:domain_id/rules/:rule_id?action=enable"

Response:
{
   "status": "ok"
}
```

``` javascript
    mailinatorClient.request(new EnableRuleRequest("domain_id", "rule_id"))
            .then(r => {
                const statusCode = r.statusCode;
                // ...
            });
```

```csharp
    EnableRuleRequest enableRuleRequest = new EnableRuleRequest() 
    { 
        DomainId = "yourDomainIdHere", 
        RuleId = "yourRuleIdHere" 
    };
    EnableRuleResponse enableRuleResponse = await mailinatorClient.RulesClient.EnableRuleAsync(enableRuleRequest);
```

```go
    res, err := mailinatorClient.EnableRule(&EnableRuleOptions{"yourDomainIdHere", "yourRuleIdHere"})
```

```ruby
    response = mailinatorClient.rules.enable_rule(domainId:"yourDomainIdHere", ruleId: "yourRuleIdHere")
```

```python
    self.mailinator.request( EnableRuleRequest(DOMAIN, rule_id) )
```

This endpoint allows you to enable an existing Rule

#### HTTP Request

PUT https://api.mailinator.com/api/v2/domains/:domain_id/rules/:rule_id?action=enable

#### PATH

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
:domain_id | (none) | true | This must be the Domain *name* or the Domain *id*
:rule_id | (none) | true | This must be the Rule *name* or the Domain *id*






### Disable Rule
```shell
curl -X PUT "https://api.mailinator.com/api/v2/domains/:domain_id/rules/:rule_id/?action=disable"

Response:
{
   "status": "ok"
}
```

``` javascript
    mailinatorClient.request(new DisableRuleRequest("domain_id", "rule_id"))
            .then(r => {
                const statusCode = r.statusCode;
                // ...
            });
```

```csharp
    DisableRuleRequest disableRuleRequest = new DisableRuleRequest() 
    { 
        DomainId = "yourDomainIdHere", 
        RuleId = "yourRuleIdHere" 
    };
    DisableRuleResponse disableRuleResponse = await mailinatorClient.RulesClient.DisableRuleAsync(disableRuleRequest);
```

```go
    res, err := mailinatorClient.DisableRule(&DisableRuleOptions{"yourDomainIdHere", "yourRuleIdHere"})
```

```ruby
    response = mailinatorClient.rules.disable_rule(domainId:"yourDomainIdHere", ruleId: "yourRuleIdHere")
```

```python
    self.mailinator.request( DisableRuleRequest(DOMAIN, rule_id) )
```

This endpoint allows you to disable an existing Rule

#### HTTP Request

PUT https://api.mailinator.com/api/v2/domains/:domain_id/rules/:rule_id?action=disable

#### PATH

Parameter | Default | Required | Description
--------- | ------- | -------- | -----------
:domain_id | (none) | true | This must be the Domain *name* or the Domain *id*
:rule_id | (none) | true | This must be the Rule *name* or the Domain *id*







### Get All Rules
```shell
curl "https://api.mailinator.com/api/v2/domains/:domain_id/rules/"

Response:
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
             "condition_data": {
               "field": "to",
               "value": "test1"
               }
           },
           {
             "operation": "EQUALS",
             "condition_data": {
               "field": "to",
               "value": "test2"
               }
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

``` javascript
    mailinatorClient.request(new GetRulesRequest("domain_id"))
            .then(r => {
                const result = r.result;
                const rules = result?.rules;
                // ...
            });
```

```csharp
    GetAllRulesRequest getAllRulesRequest = new GetAllRulesRequest() 
    { 
        DomainId = "yourDomainIdHere" 
    };
    GetAllRulesResponse getAllRulesResponse = await mailinatorClient.RulesClient.GetAllRulesAsync(getAllRulesRequest);
```

```go
    res, err := mailinatorClient.GetAllRules(&GetAllRulesOptions{"yourDomainIdHere"})
```

```ruby
    response = mailinatorClient.rules.get_all_rules(domainId:"yourDomainIdHere")
```

```python
    rules = self.mailinator.request( GetRulesRequest(DOMAIN) )
```

This endpoint fetches all Rules for a Domain

### HTTP Request

GET https://api.mailinator.com/api/v2/domains/:domain_id/rules/

### PATH

Parameter | Default | Description
--------- | ------- | -----------
:domain_id | (none) | This must be the Domain *name* or the Domain *id*




## Get Rule
```shell
curl "https://mailinator.com/api/v2/domains/:domain_id/rules/:rule_id"

Response:
{
   "_id": "5c9602f5e881b5fbe91c754a",
   "description": "Rule to post all incoming mail to test1 or test2, then drop the email",
   "enabled": true,
   "match" : "ANY",
   "name": "testprefixpost",
   "conditions": [
     {
      "operation": "EQUALS",
      "condition_data": {
        "field": "to",
        "value": "test1"
        }
     },
     {
      "operation": "EQUALS",
      "condition_data": {
        "field": "to",
        "value": "test2"
        }
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

``` javascript
    mailinatorClient.request(new GetRuleRequest("domain_id", "rule_id"))
            .then(r => {
                const result = r.result;
                const name = result?.name;
                // ...
            });
```

```csharp
    GetRuleRequest getRuleRequest = new GetRuleRequest() 
    { 
        DomainId = "yourDomainIdHere", 
        RuleId = "yourRuleIdHere" 
    };
    GetRuleResponse getRuleResponse = await mailinatorClient.RulesClient.GetRuleAsync(getRuleRequest);
```

```go
    res, err := mailinatorClient.GetRule(&GetRuleOptions{"yourDomainIdHere", "yourRuleIdHere"})
```

```ruby
    response = mailinatorClient.rules.get_rule(domainId:"yourDomainIdHere", ruleId: "yourRuleIdHere")
```

```python
    rule = self.mailinator.request( GetRuleRequest(DOMAIN, rule_id) )
```

This endpoint fetches a Rules for a Domain

### HTTP Request

GET https://api.mailinator.com/api/v2/domains/:domain_id/rules/:rule_id

### PATH

Parameter | Default | Description
--------- | ------- | -----------
:domain_id | (none) | This must be the Domain *name* or the Domain *id*
:rule_id | (none) | This must be the rule *name* or the Rule *id*

## Delete Rule

```shell
curl -X DELETE "https://api.mailinator.com/api/v2/domains/:domain_id/rules/:rule_id"

Response:
{
   "status" : "ok"
}
```

``` javascript
    mailinatorClient.request(new DeleteRuleRequest("domain_id", "rule_id"))
            .then(r => {
                const result = r.result;
                const status = result?.status;
                // ...
            });
```

```csharp
    DeleteRuleRequest deleteRuleRequest = new DeleteRuleRequest() 
    { 
        DomainId = "yourDomainIdHere", 
        RuleId = "yourRuleIdHere" 
    };
    DeleteRuleResponse deleteRuleResponse = await mailinatorClient.RulesClient.DeleteRuleAsync(deleteRuleRequest);
```

```go
    res, err := mailinatorClient.DeleteRule(&DeleteRuleOptions{"yourDomainIdHere", "yourRuleIdHere"})
```

```ruby
    response = mailinatorClient.rules.delete_rule(domainId:"yourDomainIdHere", ruleId: "yourRuleIdHere")
```

```python
    response = self.mailinator.request( DeleteRuleRequest(DOMAIN, rule_id) )
```

This endpoint deletes a specific Rule from a Domain

### HTTP Request

DELETE https://api.mailinator.com/api/v2/domains/:domain_id/rules/:rule_id

### PATH

Parameter | Default | Description
--------- | ------- | -----------
:domain_id | (none) | This must be the Domain *name* or the Domain *id*
:rule_id | (none) | This must be the rule *name* or the Rule *id*
