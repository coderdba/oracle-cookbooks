#
# Author: Gowrish.Mallipattana
#
# Oracle client installation recipe
#
#

# Variables set for use by templates and others

# Create the response file from template
#owner 'oracle'
#group 'oinstall'

template '/tmp/oracle_client_12c_unix.rsp' do
  source 'oracle_client_12c_unix_rsp.erb'
   owner 'root'
   group 'root'
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
