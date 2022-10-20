// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ChatApp{
  struct Account {
    string name;
    address accountAddress;
    Contact[] contacts;
    address[] sendedRequests;
    address[] receivedRequests;
    Chat[] chats;
    bool isPublic;
  }

  struct Contact {
    string name;
    address accountAddress;
  }

  struct Message {
    uint id;
    address sender;
    address receiver;
    string timestamp;
    string text;
  }

  struct Chat {
    Account[2] user;
    Message[] messages;
  }

  Account[] private accountList;
  Chat[] private chatList;

  // Account
  function createAccount(string memory name) public {
    require(ripemd160(abi.encodePacked(name)) != ripemd160(""), "No accountname set");
    (uint pos, bool exists) = findAccount(msg.sender);
    require(!exists, "Account already exists");
    
    Contact[] memory contacts;
    address[] memory sendedRequests;
    address[] memory receivedRequests;
    Chat[] memory chats;
    Account memory newAccount = Account(name, msg.sender, contacts, sendedRequests, receivedRequests, chats, false);
    insertAccount(newAccount);
  }

  function deleteAccount(address accountAddress) public {
    require(accountAddress == msg.sender, "No Permission to delete this account");
    (uint pos, bool exists) = findAccount(accountAddress);
    require(exists, "Account does not exist");
    removeAccount(pos);
  }

  function getName() public view returns(string memory) {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You do not have an account yet");
    return accountList[pos].name;
  }

  function getName(address accountAddress) public view returns(string memory) {
    (uint pos, bool exists) = findAccount(accountAddress);
    require(exists, "Account does not exist");
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

  // Creata a chat with 1 Friend
  function sendContactRequest(address contactAddress) public {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You don not have an account yet");
    (uint contactPos, bool contactExists) = findAccount(contactAddress);
    require(contactExists, "The requested account does not exist");

    accountList[pos].sendedRequests.push(contactAddress);
    accountList[contactPos].receivedRequests.push(msg.sender);
  }

  function deleteSendedRequest(address contactAddress) public {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You don not have an account yet");
    (uint contactPos, bool contactExists) = findAccount(contactAddress);
    require(contactExists, "The requested account does not exist");

    (uint sendedPos, bool sendedExists) = findAddressInList(contactAddress, accountList[pos].sendedRequests);
    (uint receivedPos, bool receivedExists) = findAddressInList(contactAddress, accountList[contactPos].receivedRequests);

    assert(sendedExists == receivedExists);
    require(sendedExists, "There is no request open for this account");

    delete accountList[pos].sendedRequests[sendedPos];
    delete accountList[contactPos].receivedRequests[receivedPos];
  }

  function getContactRequests() public view returns(address[] memory) {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You don not have an account yet");

    //Contact[] memory contacts = accountList[pos].receivedRequests;
    return accountList[pos].receivedRequests;
  }

  function acceptContactRequest() public {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You don not have an account yet");

  }

  function denieContactRequest() public {
    (uint pos, bool exists) = findAccount(msg.sender);
    require(exists, "You don not have an account yet");

  }

  // Chats content

  function getMessages() public view returns(string[] memory) {

  }

  function sendMessage(address receiver, string memory text) public returns(bool) {
    
  }

  function receiveMessages() public {

  }

  // Computations
  function findAccount(address accountAddress) private view returns(uint, bool) {
    for(uint i = 0; i < accountList.length; i++) {
      if(accountList[i].accountAddress == accountAddress) {
        return (i, true);
      }
    }
    return (0, false);
  }

  function findAddressInList(address accountAddress, address[] memory addressList) private view returns(uint, bool) {
    for(uint i = 0; i < addressList.length; i++) {
      if(addressList[i] == accountAddress) {
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