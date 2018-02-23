# Building this private blockchain using the following info

* Commands:
1. geth --datadir=~/semicolons/data2/ init ~/semicolons/test_accounts/genesis.json
2. geth --datadir ./data2/ --networkid 961995 --rpcport 8546 --rpc --rpcapi eth,web3,personal,net --rpcaddr 0.0.0.0 console --port 30302
3. geth attach /path_to_your_data_directory/YOUR_FOLDER/geth.ipc


### Node 1
```
> admin.nodeInfo.enode
"enode://729df06eff42e27a13219cee518b7a21a0ae33a6ff0035fbf9356d30ea7dbdf56902c817983d4b9225c104b28b9fce5a21231ea6ff04e6e20e41e0b5b60e33e1@192.168.43.159:30303"
```

### Node 2
```
"enode://f614452a5de77368ef76ae1280aa8b31736111cbb842218014c92e88c58df17d7c18fed48024e8d8256c617b724b73d59c1f8d8e89f4ddaecee40305a96c7322@192.168.43.50:30303"
```

### Node 3
```
"enode://96afea63b02faed6ac0df9d684baf0d7ff050531b72ee643cd23cbb36d0cac0a62520ccd6d86eeb42c93754130257abdede4f66c6b43dbab3ff05273c3122974@[::]:30302"
```

**This Node3 and Node1 are on the same machine with the different terminal sessoins**
    * The point is we need to operate each node on different port, the default is : 30303 
    * This port is used for Node1 and so I used 30302 for Node3
    * Also rpcports need to be different as well the default is 8545.


## To Follow : 
https://ethereum.org/token