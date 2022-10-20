// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ChatApp{
  struct Account {
    string name;
    address accountAddress;
    Contact[] contacts;
    Contact[] sendedRequests;
    Contact[] receivedRequests;
    Chat[] chats;
    bool isPublic;
  }

  struct Contact {
    string name;
    address accountAddress;
  }

  struct Chat {
    string _id;
    Message[] messages;
  }

  struct Message {
    string _id;
    address sender;
    address receiver;
    string timestamp;
    string text;
  }


  Account[] private accountList;
  Chat[] private chatList;

  // -----------------------------------------------------------------------------------------------------------
  // Account
  // -----------------------------------------------------------------------------------------------------------
  function createAccount(string memory name) public {
    require(ripemd160(abi.encodePacked(name)) != ripemd160(""), "No accountname set");
    (uint pos, bool exists) = findAccount(msg.sender);
    require(!exists, "Account already exists");
    
    Contact[] memory contacts;
    Contact[] memory sendedRequests;
    Contact[] memory receivedRequests;
    Chat[] memory chats;
    Account memory newAccount = Account(name, msg.sender, contacts, sendedRequests, receivedRequests, chats, false);
    insertAccount(newAccount);
  }

  function deleteAccount() public {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "Account does not exist");
    removeAccount(pos);
  }

  function getName() public view returns(string memory) {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You do not have an account yet");
    return accountList[pos].name;
  }

  function setName(string memory newName) public {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You don not have an account yet");
    accountList[pos].name = newName;
  }

  function getContacts() public view returns(Contact[] memory) {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You do not have an account yet");

    return accountList[pos].contacts;
  }

  function setAccountPublicity(bool isPublic) public {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You do not have an account yet");

    accountList[pos].isPublic = isPublic;
  } 

  // -----------------------------------------------------------------------------------------------------------
  // Requests
  // -----------------------------------------------------------------------------------------------------------
  function sendContactRequest(address receiverAddress) public {
    (uint senderPos, bool senderExists) = findAccount(msg.sender);
    require(senderExists, "You don not have an account yet");
    (uint receiverPos, bool receiverExists) = findAccount(receiverAddress);
    require(receiverExists, "The requested account does not exist");
  
    string memory senderName = accountList[senderPos].name;
    string memory receiverName = accountList[receiverPos].name;
    accountList[senderPos].sendedRequests.push(Contact(receiverName, receiverAddress));
    accountList[receiverPos].receivedRequests.push(Contact(senderName, msg.sender));
  }

  function deleteSendedRequest(address receiverAddress) public {
    (uint senderPos, bool senderExists) = findAccount(msg.sender);
    require(senderExists, "You don not have an account yet");
    (uint receiverPos, bool receiverExists) = findAccount(receiverAddress);
    require(receiverExists, "The requested account does not exist");

    (uint sendedReqPos, bool sendedRequestExists) = findContactInList(receiverAddress, accountList[senderPos].sendedRequests);
    (uint receivedReqPos, bool receivedRequestExists) = findContactInList(msg.sender, accountList[receiverPos].receivedRequests);

    assert(sendedRequestExists == receivedRequestExists);
    require(sendedRequestExists, "There is no request open for this account");

    delete accountList[senderPos].sendedRequests[sendedReqPos];
    delete accountList[receiverPos].receivedRequests[receivedReqPos];
  }

  function acceptContactRequest(address requestFrom) public{
    (uint receiverPos, bool receiverExists) = findAccount(msg.sender);
    require(receiverExists, "You don not have an account yet");
    (uint senderPos, bool senderExists) = findAccount(requestFrom);
    require(senderExists, "The requesting account does not exist");

    (uint sendedReqPos, bool sendedRequestExists) = findContactInList(msg.sender, accountList[senderPos].sendedRequests);
    (uint receivedReqPos, bool receivedRequestExists) = findContactInList(requestFrom, accountList[receiverPos].receivedRequests);
    assert(sendedRequestExists == receivedRequestExists);
    require(sendedRequestExists, "There is no open request from this account");
    delete accountList[senderPos].sendedRequests[sendedReqPos];
    delete accountList[receiverPos].receivedRequests[receivedReqPos];

    string memory senderName = accountList[senderPos].name;
    string memory receiverName = accountList[receiverPos].name;
    accountList[receiverPos].contacts.push(Contact(senderName, requestFrom));
    accountList[senderPos].contacts.push(Contact(receiverName, msg.sender));
  }

  function denieContactRequest(address requestFrom) public {
    (uint receiverPos, bool receiverExists) = findAccount(msg.sender);
    require(receiverExists, "You don not have an account yet");
    (uint senderPos, bool senderExists) = findAccount(requestFrom);
    require(senderExists, "The requesting account does not exist");

    (uint sendedReqPos, bool sendedRequestExists) = findContactInList(msg.sender, accountList[senderPos].sendedRequests);
    (uint receivedReqPos, bool receivedRequestExists) = findContactInList(requestFrom, accountList[receiverPos].receivedRequests);
    assert(sendedRequestExists == receivedRequestExists);
    require(sendedRequestExists, "There is no open request from this account");
    delete accountList[senderPos].sendedRequests[sendedReqPos];
    delete accountList[receiverPos].receivedRequests[receivedReqPos];
  }

  function getReceivedContactRequests() public view returns(Contact[] memory) {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You do not have an account yet");

    return accountList[pos].receivedRequests;
  }

  function getSendedContactRequests() public view returns (Contact[] memory) {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You do not have an account yet");

    return accountList[pos].sendedRequests;
  }

  // -----------------------------------------------------------------------------------------------------------
  // Chats content
  // -----------------------------------------------------------------------------------------------------------

  function getMessages() public view returns(string[] memory) {

  }

  function sendMessage(address receiver, string memory text) public returns(bool) {
    
  }

  function receiveMessages() public {

  }

  // -----------------------------------------------------------------------------------------------------------
  // Computations
  // -----------------------------------------------------------------------------------------------------------
  function findAccount(address accountAddress) private view returns(uint, bool) {
    for(uint i = 0; i < accountList.length; i++) {
      if(accountList[i].accountAddress == accountAddress) {
        return (i, true);
      }
    }
    return (0, false);
  }

  function findContactInList(address accountAddress, Contact[] memory contactList) private pure returns(uint, bool) {
    for(uint i = 0; i < contactList.length; i++) {
      if(contactList[i].accountAddress == accountAddress) {
        return (i, true);
      }
    }
    return (0, false);
  }

  function insertAccount(Account memory newAccount) private {
    accountList.push(newAccount);
  }

  function removeAccount(uint index) private {
    delete accountList[index];
  }
}