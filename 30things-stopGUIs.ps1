#https://www.youtube.com/watch?v=c24VlfJy8-k
ipconfig.exe  #nie wiadomo kiedy przestanie byc wspierane !
Get-NetIPConfiguration  

#Get-NetIPAddress

#Wiele net Adapters !
Get-NetAdapter
Get-NetAdapterStatistics  # pokazuje te z trafickiem

#manualy Config IP address
#Set-NetAdapter IP to mi przyszłodo łowy ale NIE !
New-NetIPAddress -InterfaceAlias etherntCos -IPAddress 172.16.0.2 -PrefixLength 24 -DefaultGateway 172.16.0.1

SetDnsClientServerAddress -interfaceAlias "ethernetCos" -serverAddress 172.16.0.

#ping -
Test-NetConnection 
Test-NetConnection www.bing.com -TraceRoute

#Telneting
Test-NetConnection smtp.com -Port 25

#Services
Get-Service | Out-GridView
Restart-Service

#Names & Domains
Rename-Computer 
Restart-Computer   # mozna z ps . 

#Ad
Add-Computer -domainname addatum.internal


#Add Reoles& Fu
Install-WindowsFeature Net-Framework-Core -source d:\sources\sxs

#naprawa - podobno Favorite !
# Fix computer trust relationship   -bezRebootu !!!!!
Test-ComputerSecureChannel -credential domain\admin -Repair

#only for testing
Set-NetFirewallProfile -profile domain,public,private -Enabled false

New-NetFirewallRule -DisplayName "allow inbond port 78" -Direction inbond port -LocalPort 78 -Protocol Tcp  -Action allow

New-NetFirewallRule -DisplayName "block inbond port 78" -Direction outbond port -LocalPort 78 -Protocol Tcp -Action  -Action block  

#VM
Nev-VM -memoryStartupBytes 2048MV -Name "MW-VM"
    -Path "d:\MW-VM"
    -Vhdpath "d:\MW-VM\prep-disk.vhdx"

#Zrobic SYSPREP zrobić Template sysdysk  !!!!!jak kurw\
#jedyna rzecza jakiej nie można zrobć z nową VM to assigne net adapter - z
#wiec Trick - Byc moze w nowym PS nie trzeba - to jest z 2016
Get-VM -Name MW* | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName 'Private Network'
#Checkpont VM
Check-VM -Name

#PASSSSSword reset

$newpwd = ConvertTo-SecureString -String "Pass" asPlainText -Force

Set-Ad-AccountPassword  Pan.Zapminalski -NewPassword $newpwd -Reset

Set-AdaccountPassword Pan.Zapminalski -NewPassword $newpwd -Reset Passthru 
Set-AdUser -ChangePasswordAtLogin $True #bylo Logon a podpowiedizalo sie Login


# Locate FSMO Rolse  to było PAIN w previous version win    

Get-ADForest mwdom.com | FT SchemaMaster
Get-ADForest mwdom.com | FT DomainNamingMaster
Get-ADDomain mwdom.com | FT PDCEmulator 
Get-ADDomain mwdom.com | FT InfrastructureMaster
Get-ADDomain mwdom.com | FT RidMaster

# ale jeszcze bardziej cool jest sprawdznie tego w komputerach z którymi nie ma kontaktu 
# zamiast NTDs util gdzie trzeba full comon name itp

# Seize FSMO Roles
Move-AddirectoryServerOperationMasterRoles -identity MW-DC -OperationMasterRoles,RidMaster,InfrastructureMaster,domainnamingmaster -Force -verbose

#
Get-HotFix | Out-GridView

#Set Date
Set-Date "12/12/2021 10:30PM"

(Get-WmiObject win32_timezone).Captions 

TZUTIL /s "New Zealand Standard Time"

####
Search-Adaccount -PasswordNewerExpires | Out-GridView





###z 2giej prezentacji 
search-Adaccount -accountDisabled
search-AdAccount -accountLockout


@snipet  - execution policy musi byćunrestricted ~!!!!!
new-isesnippet -Force -Title "pass_string"
-Description "SecurePasss Str" -Text
" `$newpwd =ConvertToSecureString -String jakisPass -AsPlaneText -Force"
# wazny jest ten ` !!!!!!!! aby NIE ignorowął $  
get-conmand snipet   # import export 

######## DNS
#new primary zone !
Add-DnsServerPrimaryZone -name "wschod.mwdom.com" -replicationScope "Forest" -PassThru 

#NewRecord 
Add-DnsServerResourceRecordA -Name "wschod " -ZoneName "mwdom.com" IPAddress "172.18.99.23" -TimeToLive 01:00:00 -

#DHCP 
Add-DHCPServerv4Scope -Name "Alpha-Scope" -StartRange 172.16.0.0 -endRange 172.16.128 -subnetmask 255.255.255.0

Add-DHCPServerv4Reservation -ComputerName "Alpha.mwdom.com" -ScopeId 172.16.0.0
-optional 003 -Value "172.16.0.1"


#FIle Server Managemrn
New-SmbShare -Name "Udostepniony" -Path C:\Udostepniony -FullAccess MWDOM\Administratos -ReadAccess MWDOM\Pan.Zapominalskill



###########przy okazji 
Get-WmiObject -query 'select * from win32_quickfixengineering'


https://gallery.technet.microsoft.com/scriptcenter/Find-Missing-Patches-e6d55d67

