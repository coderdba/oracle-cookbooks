#
# Author: Gowrish.Mallipattana
#
# Attributes file default.rb for oracle installation
#
#

default['hostname'] = 'oel650'

default['oracle']['installGroup'] = 'oinstall'
default['oracle']['oraInventory'] = '/u01/app/oraInventory'
default['oracle']['oraBase'] = '/u01/app/oracle'
default['softwareFolder'] = '/vagrant'

default['ora_client12c']['installUser'] = 'oracle'
default['ora_client12c']['oraHome']  = '/u01/app/oracle/product/client12c1'
default['ora_client12c']['installType']  = 'Administrator'
default['ora_client12c']['softwareBundle']  = 'linuxamd64_12c_client.zip'
default['ora_client12c']['installScreenOutputLog'] = '/tmp/ora_client12c_inst.out'

#
#  JSON FORMAT (partial - for reference)
#

#default[:ora_client12c] = {
#  :orahome => '/u01/app/oracle/product/client12c1',
#  :installType => 'Administrator',
#  :installScreenOutputLog => '/tmp/ora_client12c_inst.out'
#}
