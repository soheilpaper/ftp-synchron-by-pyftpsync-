

${OPENSHIFT_HOMEDIR}/app-root/runtime/srv/python/bin/easy_install pyftpsync
#${OPENSHIFT_HOMEDIR}/app-root/runtime/srv/python/bin/pyftpsync upload ${OPENSHIFT_HOMEDIR}/app-root/runtime/repo/php/ ftp://u882460391:ss123456@31.170.167.80:21/ --delete -x

mkdir ${OPENSHIFT_HOMEDIR}/app-root/runtime/srv
mkdir ${OPENSHIFT_HOMEDIR}/app-root/runtime/srv/tmp
#cd ${OPENSHIFT_HOMEDIR}/app-root/runtime/srv/tmp
cd /tmp
rm -rf *
wget http://wp-gl22.rhcloud.com/rp/0x14/onepage.zip

cat << 'EOF' > ftp_sync.py
#http://elec-lab.4rog.in
from ftpsync.synchronizers import DownloadSynchronizer, UploadSynchronizer,BiDirSynchronizer

from ftpsync.targets import FsTarget #, UploadSynchronizer, DownloadSynchronizer
from ftpsync.ftp_target import FtpTarget
import os

env_var = os.environ['OPENSHIFT_HOMEDIR']
#local = FsTarget(env_var+"/app-root/runtime/tmp/")
local = FsTarget('/tmp')
user ="u220290147"
passwd = "ss123456"
#ip='31.170.167.182';user='u364816941';# ss-22.4rog.in
#ip='31.170.167.90';user='u929884673';# iran-balabar.tk master@tb-simple.heliohost.org
ip='s.id.ai';user='u707539103';# s.id.ai soheil_paper@yahoo.om

#ip='tb-blog.4rog.in';user='u721167122';# tb-blog.4rog.in
#remote = FtpTarget("/home/"+user+"/public_html", "93.188.160.83", user, passwd)
remote = FtpTarget("/public_html", ip,21, user, passwd)
opts = {"force": False, "delete_unmatched": False, "verbose": 3, "execute": True, "dry_run" : False}
#opts = {"force": True, "delete_unmatched": True, "verbose": 3, "execute": True, "dry_run" : False}
s = UploadSynchronizer(local, remote, opts)
#s = DownloadSynchronizer(local, remote, opts)
s.run()
stats = s.get_stats()
print(stats)
EOF

nohup sh -c " ${OPENSHIFT_HOMEDIR}/app-root/runtime/srv/python/bin/python ftp_sync.py"> $OPENSHIFT_LOG_DIR/python_ftp_sync.log /dev/null 2>&1 &  
tail -f  $OPENSHIFT_LOG_DIR/python_ftp_sync.log


#nohup sh -c " wget -e --ues_proxy=yes -e --http_proxy=182.118.31.110:80 'http://s15.hexupload.com/files/8/h7owr8ia0gupw1/RoboCop.2014.CAM_TalaFilm_.mkv'"> $OPENSHIFT_LOG_DIR/python_ftp_sync.log /dev/null 2>&1 &  
#tail -f  $OPENSHIFT_LOG_DIR/python_ftp_sync.log
