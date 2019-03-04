#########################################################
####################### Commands ########################
#########################################################


# What does this do?
    # 1. generate crypto with "./crypto-config.yaml"
# What are the linked files/parameters(s)?
    # configuration file
# What can I change?
    # configuration time can be changed
../bin/cryptogen generate --config=./crypto-config.yaml
# What does this do?
    # 2. set the currenct path to be the FABRIC_CFG_PATH
# What are the linked files/parameters(s)?
    # Path
# What can I change?
    # Path
export FABRIC_CFG_PATH=$PWD


# - ---------------------------
#   Generating peers and orderer
# - ---------------------------


# What does this do?
    # 3. ThreeOrgsOrdererGenesis is the profile defined in the configtx.yaml
    #    and here we output the genesis block to the channel-artifacts: a lot of genesis blocks
    #    (define the consortium)
    #    This allowing any entity communicate with the ordering service and get signature verification
# What are the linked files/parameters(s)?
    # the configtx.yaml
    # `generateChannelArtifacts()` in the byfn.sh
# What can I change?
    # the outputBlock
../bin/configtxgen -profile ThreeOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

# What does this do?
    # 4. provide channel id to the genesis block
# What are the linked files/parameters(s)?
    # ./channel-artifacts/genesis.block
# What can I change?
    # maybe the channel ID?
../bin/configtxgen -profile ThreeOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block


../bin/configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME


../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP


../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP

../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org3MSP
.
# What does this do?
    # 5. Create channel Tx
# What are the linked files/parameters(s)?
    # Channel name
# What can I change?
export CHANNEL_NAME=mychannel  && ../bin/configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME

# What does this do?
    # 6. create anchor peers
# What are the linked files/parameters(s)?
    # org name? anchor peer tx name?
# What can I change?
../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP

# What does this do?
    # 7. Another anchor peer
# What are the linked files/parameters(s)?
# What can I change?
../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP

# What does this do?
    # 8. docker compose up?
# What are the linked files/parameters(s)?
# What can I change?
docker-compose -f docker-compose-cli.yaml up -d

# What does this do?
    # 9. Env var for peer 0 in org1
# What are the linked files/parameters(s)?
# What can I change?
# Environment variables for PEER0
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

CORE_PEER_ADDRESS=peer0.org1.example.com:7051

CORE_PEER_LOCALMSPID="Org1MSP"

CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt

# What does this do?
    # 10. Run the cli docker bash
# What are the linked files/parameters(s)?
# What can I change?
docker exec -it cli bash


#########################################################
# ...Continue in the "step2-peer-bash.sh"
#########################################################




#########################################################
################# Commands And Outputs ##################
#########################################################

