Starting for channel 'mychannel' with CLI timeout of '10' seconds and CLI delay of '3' seconds
Continue? [Y/n] y
proceeding ...
LOCAL_VERSION=1.4.0
DOCKER_IMAGE_VERSION=1.4.0
peer0.org2.example.com is up-to-date
orderer.example.com is up-to-date
peer1.org1.example.com is up-to-date
peer1.org2.example.com is up-to-date
peer0.org1.example.com is up-to-date
Creating cli ... done

 ____    _____      _      ____    _____ 
/ ___|  |_   _|    / \    |  _ \  |_   _|
\___ \    | |     / _ \   | |_) |   | |  
 ___) |   | |    / ___ \  |  _ <    | |  
|____/    |_|   /_/   \_\ |_| \_\   |_|  

Build your first network (BYFN) end-to-end test

#########################################################
#   All the following commands are in the docker CLI    #
#########################################################


Channel name : mychannel
Creating channel...
+ peer channel create -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
+ res=0
+ set +x
2019-03-03 19:22:39.807 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-03-03 19:22:39.925 UTC [cli.common] readBlock -> INFO 002 Received block: 0
===================== Channel 'mychannel' created ===================== 

#########################################################


Having all peers join the channel...
+ peer channel join -b mychannel.block
+ res=0
+ set +x
2019-03-03 19:22:40.122 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-03-03 19:22:40.208 UTC [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel
===================== peer0.org1 joined channel 'mychannel' ===================== 

+ peer channel join -b mychannel.block
+ res=0
+ set +x
2019-03-03 19:22:43.365 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-03-03 19:22:43.505 UTC [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel
===================== peer1.org1 joined channel 'mychannel' ===================== 

+ peer channel join -b mychannel.block
+ res=0
+ set +x
2019-03-03 19:22:46.680 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-03-03 19:22:46.791 UTC [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel
===================== peer0.org2 joined channel 'mychannel' ===================== 

+ peer channel join -b mychannel.block
+ res=0
+ set +x
2019-03-03 19:22:50.060 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-03-03 19:22:50.178 UTC [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel
===================== peer1.org2 joined channel 'mychannel' ===================== 

#########################################################


Updating anchor peers for org1...
+ peer channel update -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/Org1MSPanchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
+ res=0
+ set +x
2019-03-03 19:22:53.546 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-03-03 19:22:53.699 UTC [channelCmd] update -> INFO 002 Successfully submitted channel update
===================== Anchor peers updated for org 'Org1MSP' on channel 'mychannel' ===================== 

+ peer channel update -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/Org2MSPanchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
Updating anchor peers for org2...
+ res=0
+ set +x
2019-03-03 19:22:56.903 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-03-03 19:22:56.967 UTC [channelCmd] update -> INFO 002 Successfully submitted channel update
===================== Anchor peers updated for org 'Org2MSP' on channel 'mychannel' ===================== 


#########################################################



Installing chaincode on peer0.org1...
+ peer chaincode install -n mycc -v 1.0 -l golang -p github.com/chaincode/chaincode_example02/go/
+ res=0
+ set +x
2019-03-03 19:23:00.196 UTC [chaincodeCmd] checkChaincodeCmdParams -> INFO 001 Using default escc
2019-03-03 19:23:00.197 UTC [chaincodeCmd] checkChaincodeCmdParams -> INFO 002 Using default vscc
2019-03-03 19:23:01.963 UTC [chaincodeCmd] install -> INFO 003 Installed remotely response:<status:200 payload:"OK" > 
===================== Chaincode is installed on peer0.org1 ===================== 

Install chaincode on peer0.org2...
+ peer chaincode install -n mycc -v 1.0 -l golang -p github.com/chaincode/chaincode_example02/go/
+ res=0
+ set +x
2019-03-03 19:23:02.183 UTC [chaincodeCmd] checkChaincodeCmdParams -> INFO 001 Using default escc
2019-03-03 19:23:02.184 UTC [chaincodeCmd] checkChaincodeCmdParams -> INFO 002 Using default vscc
2019-03-03 19:23:02.465 UTC [chaincodeCmd] install -> INFO 003 Installed remotely response:<status:200 payload:"OK" > 
===================== Chaincode is installed on peer0.org2 ===================== 


#########################################################


Instantiating chaincode on peer0.org2...
+ peer chaincode instantiate -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc -l golang -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P 'AND ('\''Org1MSP.peer'\'','\''Org2MSP.peer'\'')'
+ res=0
+ set +x
2019-03-03 19:23:02.612 UTC [chaincodeCmd] checkChaincodeCmdParams -> INFO 001 Using default escc
2019-03-03 19:23:02.612 UTC [chaincodeCmd] checkChaincodeCmdParams -> INFO 002 Using default vscc
===================== Chaincode is instantiated on peer0.org2 on channel 'mychannel' ===================== 


#########################################################


Querying chaincode on peer0.org1...
===================== Querying on peer0.org1 on channel 'mychannel'... ===================== 
Attempting to Query peer0.org1 ...3 secs
+ peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'
+ res=0
+ set +x

100
===================== Query successful on peer0.org1 on channel 'mychannel' ===================== 
Sending invoke transaction on peer0.org1 peer0.org2...
+ peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc --peerAddresses peer0.org1.example.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0.org2.example.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"Args":["invoke","a","b","10"]}'
+ res=0
+ set +x
2019-03-03 19:24:33.735 UTC [chaincodeCmd] chaincodeInvokeOrQuery -> INFO 001 Chaincode invoke successful. result: status:200 
===================== Invoke transaction successful on peer0.org1 peer0.org2 on channel 'mychannel' ===================== 


#########################################################



Installing chaincode on peer1.org2...
+ peer chaincode install -n mycc -v 1.0 -l golang -p github.com/chaincode/chaincode_example02/go/
+ res=0
+ set +x
2019-03-03 19:24:33.883 UTC [chaincodeCmd] checkChaincodeCmdParams -> INFO 001 Using default escc
2019-03-03 19:24:33.883 UTC [chaincodeCmd] checkChaincodeCmdParams -> INFO 002 Using default vscc
2019-03-03 19:24:34.144 UTC [chaincodeCmd] install -> INFO 003 Installed remotely response:<status:200 payload:"OK" > 
===================== Chaincode is installed on peer1.org2 ===================== 


#########################################################



Querying chaincode on peer1.org2...
===================== Querying on peer1.org2 on channel 'mychannel'... ===================== 
Attempting to Query peer1.org2 ...3 secs
+ peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'
+ res=0
+ set +x

90
===================== Query successful on peer1.org2 on channel 'mychannel' ===================== 

========= All GOOD, BYFN execution completed =========== 


 _____   _   _   ____   
| ____| | \ | | |  _ \  
|  _|   |  \| | | | | | 
| |___  | |\  | | |_| | 
|_____| |_| \_| |____/  
