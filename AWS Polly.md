# AWS Polly

https://github.com/awslabs/aws-sdk-ios-samples/tree/master/Polly-Sample/Swift

```swift
//AppDelegate.swift
import AWSCore

let AWS_REGION = AWSRegionType.APNortheast2 // e.g. AWSRegionType.USEast1
let COGNITO_IDENTITY_POOLID = "ap-northeast-2:3e83174d-7119-41c5-8242-325eb8df383e"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: AWS_REGION, identityPoolId: COGNITO_IDENTITY_POOLID)
        let configuration = AWSServiceConfiguration(
            region: AWS_REGION,
            credentialsProvider: credentialProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    
        return true
    }

	...
}
```

```swift
import AVFoundation
import AWSPolly

struct AWSPolly_TTS{
    static let task = AWSPolly.default().describeVoices(AWSPollyDescribeVoicesInput())
    
    static func continueSpeach(audioPlayer: AVPlayer, text: String) {
        task.continueOnSuccessWith { (awsTask: AWSTask<AWSPollyDescribeVoicesOutput>) -> Any? in
            let input = AWSPollySynthesizeSpeechURLBuilderRequest()
            input.text = text
            input.outputFormat = AWSPollyOutputFormat.mp3
            input.voiceId = AWSPollyVoiceId.seoyeon //Korean Voice ID
            
            let builder = AWSPollySynthesizeSpeechURLBuilder.default().getPreSignedURL(input)
            builder.continueOnSuccessWith(block: { (awsTask: AWSTask<NSURL>) -> Any? in
                let url = awsTask.result!
                
                audioPlayer.replaceCurrentItem(with: AVPlayerItem(url: url as URL))
                audioPlayer.play()
                return nil
            })
            
            return nil
        }
    }
}
```

