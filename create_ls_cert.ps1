$cert = New-SelfSignedCertificate -DnsName "trial.avm" -CertStoreLocation "cert:\LocalMachine\My" -KeyUsage DigitalSignature,CertSign,CRLSign -KeyAlgorithm RSA -KeyLength 2048 -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" -NotAfter (Get-Date).AddYears(5)

$pwd = '12345'

$SSpwd = ConvertTo-SecureString -String $pwd -Force -AsPlainText

Export-PfxCertificate -Cert "Cert:\LocalMachine\My\$($cert.Thumbprint)" -FilePath C:\custom_cert.pfx -Password $SSpwd