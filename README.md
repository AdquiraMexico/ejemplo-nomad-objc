NOTE: 

There is an error showing in the log that it has nothing to do with the NOMAD or PAYMENT process, it's an IOS12 and XCODE 10 problem. 

The error is : 

"AVAudioSessionPortImpl.mm:56:ValidateRequiredFields: Unknown selected data source for Port Speaker (type: Speaker)"

The message Unknown selected data source for Port Speaker seems to be a problem with iOS 12. Apparently it's some warning that appears even if the code is working. Perhaps Apple will fix this soon, so maybe for now you can ignore this warning and once they find a solution you will be able to silence it.

Source: AVAudioSession errors in iOS 12

https://forums.developer.apple.com/thread/108785

