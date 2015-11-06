#
# Author: Gowrish.Mallipattana
#
# Oracle client installation recipe
#
#

# Variables set for use by templates and others

responseFile='/tmp/oracle_client_12c_unix.rsp'
softwareFolder=node[:softwareFolder]
softwareBundle=node[:ora_client12c][:softwareBundle]
softwareCopy=/tmp/#{softwareBundle}
unzipDir='/tmp/oracle_client_unzip'
#runInstaller='#{unzipDir}/client/runInstaller'
runInstaller='/tmp/oracle_client_unzip/client/runInstaller'
oraHome= node[:ora_client12c][:oraHome]
oraInventory=node[:oracle][:oraInventory]

# Create the response file from template
template '/tmp/oracle_client_12c_unix.rsp' do
#template '#{responseFile}' do
  source 'oracle_client_12c_unix_rsp.erb'
   owner 'oracle'
   group 'oinstall'
    mode '0755'
    variables({
     :installGroup  => node[:oracle][:installGroup],
     :installUser   => node[:ora_client12c][:installUser],
     :oraInventory  => node[:oracle][:oraInventory],
     :oraBase       => node[:oracle][:oraBase],
     :oraHome       => node[:ora_client12c][:oraHome],
     :installType   => node[:ora_client12c][:installType],
     :hostname      => node[:hostname]
  })
end

 
execute 'create unzip directory for oracle software bundle' do
  command "su oracle -c 'mkdir -p #{unzipDir}' "
end

execute 'unzip oracle software bundle' do
  command "su oracle -c 'unzip #{softwareFolder}/#{softwareBundle} -d #{unzipDir}' "
end

execute 'install oracle software bundle' do
  command "su oracle -c '#{runInstaller} -silent -waitforcompletion -noconfig -ignoreSysPrereqs -ignorePrereq -responseFile #{responseFile} > /tmp/out 2>> /tmp/out' "
  ##command "su oracle -c 'touch #{runInstaller}' "
end

execute 'sleep a while for all filecopy to end' do
  command "sleep 60"
end

execute 'run root shell' do
  #command "sudo su - root -c '#{oraHome}/root.sh'"
  user "root"
  command "#{oraHome}/root.sh"
end

execute 'run orainstRoot shell' do
  command "sudo su - root -c '#{oraInventory}/orainstRoot.sh'"
end

