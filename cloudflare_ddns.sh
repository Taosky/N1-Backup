#!/bin/sh
NEW_IP=`curl http://members.3322.org/dyndns/getip`
CURRENT_IP=`cat /var/tmp/current_ip.txt`
if [ "$NEW_IP" = "$CURRENT_IP" ]
then
     echo "No Change in IP Adddress"
else
     curl -X PUT "https://api.cloudflare.com/client/v4/zones/【域名的区域id,点击域名后右下角】/dns_records/【dns id 可以搜一下怎么获取】" \
     -H "X-Auth-Email: 【邮箱】" \
     -H "X-Auth-Key: 【密钥（我的个人资料-API令牌-Global）】" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"【域名】","content":"'$NEW_IP'","ttl":1}'
     echo $NEW_IP > /var/tmp/current_ip.txt
fi

