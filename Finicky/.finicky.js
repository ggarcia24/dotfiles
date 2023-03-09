/**
  * Save as ~/.finicky.js
  */

module.exports = {
  defaultBrowser: "Firefox",
  handlers: [
    {
        match: finicky.matchHostnames([
          "www.zep-online.de",
          "identity.getpostman.com",
          "meet.google.com",
          "docs.google.com",
          "jamboard.google.com",
          "aws.amazon.com",
          "amazonaws.com",
          "sites.google.com",
          "groups.google.com",
          "smartbox.kaercher.com",
          "taskbox.kaercher.com",
          "git.app.kaercher.com",
          "ci.dev-iot.kaercher.com",
          "plus.google.com",
          "app.slack.com",
          "kaercher.slack.com",
          "www.lucidchart.com",
          "sg.app.lucidchart.com",
          "git.zoi.de",
          "chat.google.com",
          "tf-akiot-fargate-alb-1368073173.eu-west-1.elb.amazonaws.com",
          "zoi.freshservice.com",
          "app.retrium.com",
          "kaercher.webex.com",
          "eu-west-1.console.aws.amazon.com",
          "app-eu.whitesourcesoftware.com",
        ]),
        browser: "Google Chrome"
    },
    {
        match: finicky.matchHostnames([
          "youtube.com",
          "facebook.com",
          "wikipedia.org",
          "linkedin.com",
          "medium.com",
          "github.com",
        ]),
        browser: "Firefox"
    }
  ]
};
// For more examples, see the Finicky github page https://github.com/johnste/finicky
