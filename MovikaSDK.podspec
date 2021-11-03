Pod::Spec.new do |s|

    # 1
    s.platform = :ios
    s.ios.deployment_target = '12.0'
    s.name = 'MovikaSDK'
    s.summary = "MovikaSDK"
    s.requires_arc = true

    # 2
    s.version = "3.0.0"

    # 3
    s.license = { :type => "MIT", :file => "LICENSE" }

    # 4
    s.author = { "Dinislam Ishmukhametov" => "dinislam.ishmukhametov@movika.com" }

    # 5
    s.homepage = "https://movika.com"

    # 6
    s.source = { :git => "https://github.com/movika/movika-sdk-ios.git", :tag => "#{s.version}" }
    # 7

    s.ios.vendored_frameworks = 'MovikaSDK.xcframework'

    # 10
    s.swift_version = "5.0"

end
