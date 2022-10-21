// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ChatApp{
  struct Account {
    string name;
    Contact[] contacts;
    Contact[] sendedRequests;
    Contact[] receivedRequests;
    Chat[] chats;
    bool isPublic;
    bool exists;
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

  //Account[] private accountList;
  mapping(address => Account) private accountList;
  address[] private accountListKeys;
  Chat[] private chatList;

  // -----------------------------------------------------------------------------------------------------------
  // Account
  // -----------------------------------------------------------------------------------------------------------
  function createAccount(string memory name) public {
    require(!accountList[msg.sender].exists, "Account already exists");
    require(ripemd160(abi.encodePacked(name)) != ripemd160(""), "No accountname set");
    
    accountList[msg.sender].name = name;
    accountList[msg.sender].exists = true;
    accountListKeys.push(msg.sender);
  }

  function deleteAccount() public {
    require(accountList[msg.sender].exists, "Account does not exist");

    for(uint i = 0; i < accountListKeys.length; i++ ) {
      if(accountListKeys[i] == msg.sender) {
        delete accountListKeys[i];
        break;
      }
    }

    accountList[msg.sender].exists = false;
  }

  function getName() public view returns(string memory) {
    require(accountList[msg.sender].exists, "Account does not exist");
    return accountList[msg.sender].name;
  }

  function setName(string memory newName) public {
    require(accountList[msg.sender].exists, "Account does not exist");
    accountList[msg.sender].name = newName;
  }

  function getContacts() public view returns(Contact[] memory) {
    require(accountList[msg.sender].exists, "Account does not exist");
    return accountList[msg.sender].contacts;
  }

  function setAccountPublicity(bool isPublic) public {
    require(accountList[msg.sender].exists, "Account does not exist");
    accountList[msg.sender].isPublic = isPublic;
  } 

  // -----------------------------------------------------------------------------------------------------------
  // Requests
  // -----------------------------------------------------------------------------------------------------------
  function sendContactRequest(address receiverAddress) public {
    require(accountList[msg.sender].exists, "You don't have an account yet");
    require(accountList[receiverAddress].exists, "The account you requested does not exist");
  
    string memory senderName = accountList[msg.sender].name;
    string memory receiverName = accountList[receiverAddress].name;
    accountList[msg.sender].sendedRequests.push(Contact(receiverName, receiverAddress));
    accountList[receiverAddress].receivedRequests.push(Contact(senderName, msg.sender));
  }

  function retractContactRequest(address receiverAddress) public {
    require(accountList[msg.sender].exists, "You don't have an account yet");
    require(accountList[receiverAddress].exists, "The account you requested does not exist");

    (uint sendedReqPos, bool sendedRequestExists) = findContactInList(receiverAddress, accountList[msg.sender].sendedRequests);
    (uint receivedReqPos, bool receivedRequestExists) = findContactInList(msg.sender, accountList[receiverAddress].receivedRequests);

    assert(sendedRequestExists == receivedRequestExists);
    require(sendedRequestExists, "There is no request open for this account");

    delete accountList[msg.sender].sendedRequests[sendedReqPos];
    delete accountList[receiverAddress].receivedRequests[receivedReqPos];
  }

  function acceptContactRequest(address requestFrom) public{
    require(accountList[msg.sender].exists, "You don't have an account yet");
    require(accountList[requestFrom].exists, "The account whose request you want to accept does not exist");

    (uint sendedReqPos, bool sendedRequestExists) = findContactInList(msg.sender, accountList[requestFrom].sendedRequests);
    (uint receivedReqPos, bool receivedRequestExists) = findContactInList(requestFrom, accountList[msg.sender].receivedRequests);
    assert(sendedRequestExists == receivedRequestExists);
    require(sendedRequestExists, "There is no open request from this account");

    delete accountList[requestFrom].sendedRequests[sendedReqPos];
    delete accountList[msg.sender].receivedRequests[receivedReqPos];
    string memory senderName = accountList[requestFrom].name;
    string memory receiverName = accountList[msg.sender].name;
    accountList[msg.sender].contacts.push(Contact(senderName, requestFrom));
    accountList[requestFrom].contacts.push(Contact(receiverName, msg.sender));
  }

  function denieContactRequest(address requestFrom) public {
    require(accountList[msg.sender].exists, "You don't have an account yet");
    require(accountList[requestFrom].exists, "The account whose request you want to denie does not exist");

    (uint sendedReqPos, bool sendedRequestExists) = findContactInList(msg.sender, accountList[requestFrom].sendedRequests);
    (uint receivedReqPos, bool receivedRequestExists) = findContactInList(requestFrom, accountList[msg.sender].receivedRequests);
    assert(sendedRequestExists == receivedRequestExists);
    require(sendedRequestExists, "There is no open request from this account");

    delete accountList[requestFrom].sendedRequests[sendedReqPos];
    delete accountList[msg.sender].receivedRequests[receivedReqPos];
  }

  function getReceivedContactRequests() public view returns(Contact[] memory) {
    require(accountList[msg.sender].exists, "You don't have an account yet");

    return accountList[msg.sender].receivedRequests;
  }

  function getSendedContactRequests() public view returns (Contact[] memory) {
    require(accountList[msg.sender].exists, "You don't have an account yet");

    return accountList[msg.sender].sendedRequests;
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
  // Contract Infos
  // -----------------------------------------------------------------------------------------------------------

  function getAllContacts() public view returns (Contact[] memory) {
    // for development
    Contact[] memory contacts = new Contact[](1);

    for(uint i; i < accountListKeys.length; i++) {
      contacts[i] = Contact(accountList[accountListKeys[i]].name, accountListKeys[i]);
    }

    return contacts;
  }

  function getAllPublicContacts() public view returns (Contact[] memory) {
    Contact[] memory contacts = new Contact[](1);

    for(uint i; i < accountListKeys.length; i++) {
      if(accountList[accountListKeys[i]].isPublic) {
        contacts[i] = Contact(accountList[accountListKeys[i]].name, accountListKeys[i]);
      }
    }

    return contacts;
  }


  // -----------------------------------------------------------------------------------------------------------
  // Computations
  // -----------------------------------------------------------------------------------------------------------

  function findContactInList(address accountAddress, Contact[] memory contactList) private pure returns(uint, bool) {
    for(uint i = 0; i < contactList.length; i++) {
      if(contactList[i].accountAddress == accountAddress) {
        return (i, true);
      }
    }
    return (0, false);
  }
}