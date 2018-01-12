# Twitch API Consumer Sample Project

I wanted to gain a little more familiarity with PromiseKit, testing, and Dependency Injection, so I made this small project.

It simply hits an endpoint to retrieve the top watched games on Twitch and then displays that to the user.

The main view's service takes an API session that adheres to the TwitchAPISession protocol. This would ideally keep the mainViewService free from having to be rewritten in the event that the APISession class needed to change how it makes its calls.

This also allows my to inject a test session into mainViewService that complies with the TwitchAPISession protocol to easily test the decode process with some mock data.

<img src="https://github.com/adarak/TwitchConsumerSampleProject/blob/master/example.gif?raw=true" style="width: 350px;">
