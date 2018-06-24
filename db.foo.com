;
; BIND data file for foo.com
;
$TTL    3h
@       IN      SOA       foo.com admin.foo.com. (
                          1        ; Serial
                          3h       ; Refresh after 3 hours
                          1h       ; Retry after 1 hour
                          1w       ; Expire after 1 week
                          1h )     ; Negative caching TTL of 1 day
;

@       IN      NS      controlbox.foo.com. 

controlbox.foo.com.    		IN      A       192.168.3.10
master.foo.com.    		IN      A       192.168.3.100
node1.foo.com.    		IN      A       192.168.3.101
node2.foo.com.    		IN      A       192.168.3.102
