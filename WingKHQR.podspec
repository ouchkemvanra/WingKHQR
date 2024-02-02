Pod::Spec.newdo |spec|
spec.name         = 'WingKHQR'
spec.version      = '0.1.0'
spec.authors      = {
'Kemvanra ouch' => 'ouchkemvanra1@gmail.com',
'Another Kemvanra ouch' => 'ouchkemvanra1@gmail.com'
}
spec.license      = {
:type => 'MIT',
:file => 'LICENSE'
}
spec.homepage     = 'https://github.com/ouchkemvanra/WingKHQR.git'
spec.source       = {
:git => 'https://github.com/ouchkemvanra/WingKHQR.git',
:branch => 'master',
:tag => spec.version.to_s
}
spec.summary      = 'Custom view for wing khqr'
spec.source_files = '**/*.swift', '*.swift'
spec.swift_versions = '4.0'
spec.ios.deployment_target= '12.0'
end