# MongoDB for Habitat

## Requirements:

You must provide a volume for data persistance which is mounted at /data/db

## Running 

```
benr@magnolia:~$ docker run -it -v ~/mongo_data:/data/db chefops/mongodb
hab-sup(MN): Starting chefops/mongodb
hab-sup(GS): Supervisor 172.17.0.2: 50e730eb-b0e1-4056-a2d2-9024bd43f5a9
hab-sup(GS): Census mongodb.default: 0142858a-9b7f-4482-acdb-69475c520640
hab-sup(GS): Starting inbound gossip listener
hab-sup(GS): Starting outbound gossip distributor
hab-sup(GS): Starting gossip failure detector
hab-sup(CN): Starting census health adjuster
init(PH): Symlinking /lib/ld-linux-x86-64.so.2...
mongodb(SV): Starting
mongodb(O): 2016-05-03T07:54:22.817+0000 I CONTROL  [initandlisten] MongoDB starting : pid=214 port=27017 dbpath=/data/db 64-bit host=2316fbeff8e4
mongodb(O): 2016-05-03T07:54:22.817+0000 I CONTROL  [initandlisten] db version v3.2.6
mongodb(O): 2016-05-03T07:54:22.817+0000 I CONTROL  [initandlisten] git version: 05552b562c7a0b3143a729aaa0838e558dc49b25
mongodb(O): 2016-05-03T07:54:22.817+0000 I CONTROL  [initandlisten] allocator: tcmalloc
mongodb(O): 2016-05-03T07:54:22.817+0000 I CONTROL  [initandlisten] modules: none
mongodb(O): 2016-05-03T07:54:22.817+0000 I CONTROL  [initandlisten] build environment:
mongodb(O): 2016-05-03T07:54:22.817+0000 I CONTROL  [initandlisten]     distarch: x86_64
mongodb(O): 2016-05-03T07:54:22.817+0000 I CONTROL  [initandlisten]     target_arch: x86_64
mongodb(O): 2016-05-03T07:54:22.817+0000 I CONTROL  [initandlisten] options: { net: { http: { RESTInterfaceEnabled: true, enabled: true } }, security: { authorization: "disabled" } }
mongodb(O): 2016-05-03T07:54:22.827+0000 I STORAGE  [initandlisten] wiredtiger_open config: create,cache_size=18G,session_max=20000,eviction=(threads_max=4),config_base=false,statistics=(fast),log=(enabled=true,archive=true,path=journal,compressor=snappy),file_manager=(close_idle_time=100000),checkpoint=(wait=60,log_size=2GB),statistics_log=(wait=0),
mongodb(O): 2016-05-03T07:54:23.006+0000 I CONTROL  [initandlisten] ** WARNING: You are running this process as the root user, which is not recommended.
mongodb(O): 2016-05-03T07:54:23.006+0000 I CONTROL  [initandlisten] 
mongodb(O): 2016-05-03T07:54:23.006+0000 I CONTROL  [initandlisten] 
mongodb(O): 2016-05-03T07:54:23.006+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/enabled is 'always'.
mongodb(O): 2016-05-03T07:54:23.006+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
mongodb(O): 2016-05-03T07:54:23.006+0000 I CONTROL  [initandlisten] 
mongodb(O): 2016-05-03T07:54:23.006+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/defrag is 'always'.
mongodb(O): 2016-05-03T07:54:23.006+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
mongodb(O): 2016-05-03T07:54:23.006+0000 I CONTROL  [initandlisten] 
mongodb(O): 2016-05-03T07:54:23.007+0000 I NETWORK  [websvr] admin web console waiting for connections on port 28017
mongodb(O): 2016-05-03T07:54:23.007+0000 I FTDC     [initandlisten] Initializing full-time diagnostic data capture with directory '/data/db/diagnostic.data'
mongodb(O): 2016-05-03T07:54:23.007+0000 I NETWORK  [HostnameCanonicalizationWorker] Starting hostname canonicalization worker
mongodb(O): 2016-05-03T07:54:23.058+0000 I NETWORK  [initandlisten] waiting for connections on port 27017
```

The web interface is available on port 28017.  

If you have the MongoDB Shell, connect like so:

```
$ ./mongo 172.17.0.2
MongoDB shell version: 3.2.6
connecting to: 172.17.0.2/test
Welcome to the MongoDB shell.
...
> db
test
> db.users
test.users
> exit
bye
```

Or the Simple REST interface:

```
$ curl 172.17.0.2:28017/test/
{
  "offset" : 0,
  "rows": [

  ],

  "total_rows" : 0 ,
  "query" : {} ,
  "millis" : 0
}
```

## TODO:

* No config templating yet done.
